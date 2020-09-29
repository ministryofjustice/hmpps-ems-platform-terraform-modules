import boto3
import logging
import json
import os

cloudwatch = boto3.client('cloudwatch')
ec2 = boto3.client('ec2')
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
  # Get transit gateways
  get_transit_gateways = ec2.describe_transit_gateways()

  # Loop over transit gateways
  for transit_gateway in get_transit_gateways['TransitGateways']:
    logger("Transit Gateway: " + transit_gateway['TransitGatewayId'])
    # Loop over transit gateway route tables filtering on transit gateway ID
    get_transit_gateway_route_tables = ec2.describe_transit_gateway_route_tables(
      Filters=[
        {
            'Name': 'transit-gateway-id',
            'Values': [
                transit_gateway['TransitGatewayId'],
            ]
        }
      ]
    )
    # Search transit gateways
    for transit_gateway_route_table in get_transit_gateway_route_tables['TransitGatewayRouteTables']:
      logger("  Transit Gateway Route Table: " + transit_gateway_route_table['TransitGatewayRouteTableId'])
      # Loop over transit gateway routes filtering on active state
      search_active_transit_gateway_routes = ec2.search_transit_gateway_routes(
        TransitGatewayRouteTableId = transit_gateway_route_table['TransitGatewayRouteTableId'],
        Filters=[
          {
              'Name': 'state',
              'Values': [
                  'active',
              ]
          }
        ]
      )
      if len(search_active_transit_gateway_routes['Routes']) == 0:
        logger("    No Transit Gateway Attachements in active state")
      else:
        for active_transit_gateway_route in search_active_transit_gateway_routes['Routes']:
          logger("    Transit Gateway Attachment (Active) " + active_transit_gateway_route['TransitGatewayAttachments'][0]['TransitGatewayAttachmentId'] + " Route: " + active_transit_gateway_route['DestinationCidrBlock'])
          put_cloudwatch_metric_data = cloudwatch.put_metric_data(
              Namespace='HMPPS/EMS/SharedNetworking',
              MetricData=[
                {
                  'MetricName': 'TransitGatewayAttachmentStatus',
                  'Dimensions': [
                    {
                      'Name': 'TransitGatewayAttachmentId',
                      'Value': active_transit_gateway_route['TransitGatewayAttachments'][0]['TransitGatewayAttachmentId']
                    },
                    {
                      'Name': 'DestinationCidrBlock',
                      'Value': active_transit_gateway_route['DestinationCidrBlock']
                    },
                    {
                      'Name': 'ResourceType',
                      'Value': active_transit_gateway_route['TransitGatewayAttachments'][0]['ResourceType']
                    },
                  ],
                  'Unit': 'None',
                  'Value': 1
                },
              ]
          )


      # Loop over transit gateway routes filtering on blackholed state
      search_blackholed_transit_gateway_routes = ec2.search_transit_gateway_routes(
        TransitGatewayRouteTableId = transit_gateway_route_table['TransitGatewayRouteTableId'],
        Filters=[
          {
              'Name': 'state',
              'Values': [
                  'blackhole',
              ]
          }
        ]
      )

      if len(search_blackholed_transit_gateway_routes['Routes']) == 0:
        logger("    No Transit Gateway Attachements in blackholed state")
      else:
        for blackholed_transit_gateway_route in search_blackholed_transit_gateway_routes['Routes']:
          logger("    Transit Gateway Attachment (Blackholed) " + blackholed_transit_gateway_route['TransitGatewayAttachments'][0]['TransitGatewayAttachmentId'] + " Route: " + blackholed_transit_gateway_route['DestinationCidrBlock'])
          put_cloudwatch_metric_data = cloudwatch.put_metric_data(
              Namespace='HMPPS/EMS/SharedNetworking',
              MetricData=[
                {
                  'MetricName': 'TransitGatewayAttachmentStatus',
                  'Dimensions': [
                    {
                      'Name': 'TransitGatewayAttachmentId',
                      'Value': blackholed_transit_gateway_route['TransitGatewayAttachments'][0]['TransitGatewayAttachmentId']
                    },
                    {
                      'Name': 'DestinationCidrBlock',
                      'Value': blackholed_transit_gateway_route['DestinationCidrBlock']
                    },
                    {
                      'Name': 'ResourceType',
                      'Value': blackholed_transit_gateway_route['TransitGatewayAttachments'][0]['ResourceType']
                    },
                  ],
                  'Unit': 'None',
                  'Value': 0
                },
              ]
          )
