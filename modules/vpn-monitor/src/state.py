import boto3
import logging
from os import path
from config import Config


dynamodb = boto3.client('dynamodb')
logger = logging.getLogger()
logger.setLevel(logging.INFO)


def get_state(vpn_id, tunnel_id):
    try:
        logger.debug(
            "Retrieving stored state for connection tunnel {0}/{1}".format(vpn_id, tunnel_id))
        response = dynamodb.get_item(
            Key={
                'VpnConnectionId': {
                    'S': vpn_id
                },
                'TunnelId': {
                    'S': tunnel_id
                }
            },
            TableName=Config.get('state_table_name'),
        )

        if 'Item' in response:
            return response['Item']['State']['S']

    except Exception as e:
        logger.error(
            'An error occured when retrieving state {0} : {1}'
            .format(tunnel_id, e)
        )


def set_state(vpn_name, vpn_id, tunnel_id, state):
    try:
        response = dynamodb.put_item(
            Item={
                'VpnConnectionId': {
                    'S': vpn_id,
                },
                'VpnName': {
                  'S': vpn_name
                },
                'TunnelId': {
                    'S': tunnel_id,
                },
                'State': {
                    'S': state,
                },
            },
            TableName=Config.get('state_table_name'),
        )
    except Exception as e:
        logger.error(
            'An error occured when updating state for vpn {0} and tunnel {1} : {2}'
            .format(vpn_id, tunnel_id, e)
        )
