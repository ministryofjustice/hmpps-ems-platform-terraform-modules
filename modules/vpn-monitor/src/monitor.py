import json
import os
import boto3
import logging
from utilities import parse_tags
from config import Config
from messages import get_message_body, format_snow_message, send_sns_message
from state import get_state, set_state


ec2 = boto3.client('ec2')
sts = boto3.client('sts')
logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):

    account = sts.get_caller_identity()['Account']

    if (Config.get('enable_mock_response') == 'true'):
      logger.info('Using mock data for describe_vpn_connections()')
      path = os.path.dirname(os.path.abspath(__file__))
      with open(path + '/data/mock_vpn_connections.json') as mock_vpn_connections:
          response = json.load(mock_vpn_connections)
    else:
      response = ec2.describe_vpn_connections()

    link_down_tolerance = Config.get('link_down_tolerance')
    subject_line = '[{0}] VPN state change detected!'

    for vpnConnection in response['VpnConnections']:

        links_down = []
        links_up = []
        message_details = []
        tunnel_state = []
        message_description = ''
        state_changed = False

        tags = parse_tags(vpnConnection['Tags'])

        logger.info('Processing vpn connection with id {0}'.format(
            vpnConnection['VpnConnectionId']))

        logger.debug('This vpn has {0} tunnels and has a link down tolerance of {1}'.format(
            len(vpnConnection['VgwTelemetry']),
            link_down_tolerance)
        )

        for tunnel_telemetry in vpnConnection['VgwTelemetry']:

            last_state = get_state(
                vpnConnection['VpnConnectionId'], tunnel_telemetry['OutsideIpAddress'])

            current_state = tunnel_telemetry['Status']

            logger.debug('Tunnel {0} has a current status of {1}'.format(
                tunnel_telemetry['OutsideIpAddress'],
                current_state)
            )

            if current_state == 'UP':
                links_up.append(tunnel_telemetry)

            if current_state == 'DOWN':
                links_down.append(tunnel_telemetry)

            if (last_state is not None) and (last_state != current_state):

                if current_state != 'UP':
                    state_changed = True

                logger.warn('Connection change detected on tunnel {tunnel}: {original_status} -> {new_status}'.format(
                    tunnel=tunnel_telemetry['OutsideIpAddress'],
                    original_status=last_state,
                    new_status=current_state)
                )

                tunnel_state.append({
                    'id': tunnel_telemetry['OutsideIpAddress'],
                    'last_state': last_state,
                    'current_state': current_state
                })

            set_state(tags['Name'], vpnConnection['VpnConnectionId'],
                      tunnel_telemetry['OutsideIpAddress'], current_state)

        # If there has been a state change, then..
        if state_changed is True:

            # --- Info message if the number of active links is equal to the number of connections
            if len(links_up) == len(vpnConnection['VgwTelemetry']):

                subject = subject_line.format('INFO')
                message_details.append('Tunnel connections are within bounds.')

            # --- Alert if the number of dead is equal to the number of connections
            elif len(links_down) == len(vpnConnection['VgwTelemetry']):

                subject = subject_line.format(
                    Config.get('tolerance_breach_priority'))

                message_details.append(
                    'All tunnel connections are down.')

                message_description = format_snow_message(
                    tags['Name'], Config.get('tolerance_breach_priority'))

            # --- Alert if there is a loss of redundancy
            elif (len(links_down) > 0) and (len(links_down) < len(vpnConnection['VgwTelemetry'])):

                subject = subject_line.format(
                    Config.get('redundancy_breach_priority'))

                message_details.append(
                    'Loss of redundancy has occured.')

                message_description = format_snow_message(
                    tags['Name'], Config.get('redundancy_breach_priority'))


            logger.info('Publishing message..')
            message_parameters = {
                'details': '\n'.join(message_details),
                'vpn_name': tags['Name'],
                'description': message_description,
                'tunnels': tunnel_state,
                'requestId': context.aws_request_id
            }

            # --- Send an email alert
            send_sns_message(
                Config.get('sns_email_topic_name'),
                subject,
                get_message_body(
                    'email_message_template.txt',
                    message_parameters
                )
            )

            # --- Send a slack alert
            send_sns_message(
                Config.get('sns_slack_topic_name'),
                subject,
                get_message_body(
                    'slack_message_template.txt',
                    message_parameters
                )
            )

    return {
        'statusCode': 202,
    }
