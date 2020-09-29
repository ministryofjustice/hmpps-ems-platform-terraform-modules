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
  for i in get_transit_gateways['TransitGateways']:
    print("Transit Gateway: " + i['TransitGatewayId'])
    # Loop over transit gateway route tables filtering on transit gateway ID
    get_transit_gateway_route_tables = ec2.describe_transit_gateway_route_tables(
      Filters=[
        {
            'Name': 'transit-gateway-id',
            'Values': [
                i['TransitGatewayId'],
            ]
        }
      ]
    )
    # Search transit gateways
    for j in get_transit_gateway_route_tables['TransitGatewayRouteTables']:
      print("  Transit Gateway Route Table: " + j['TransitGatewayRouteTableId'])
      # Loop over transit gateway routes filtering on active state
      search_active_transit_gateway_routes = ec2.search_transit_gateway_routes(
        TransitGatewayRouteTableId = j['TransitGatewayRouteTableId'],
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
        print("    No Transit Gateway Attachements in active state")
      else:
        for k in search_active_transit_gateway_routes['Routes']:
          print("    Transit Gateway Attachment (Active) " + k['TransitGatewayAttachments'][0]['TransitGatewayAttachmentId'] + " Route: " + k['DestinationCidrBlock'])
          put_cloudwatch_metric_data = cloudwatch.put_metric_data(
              Namespace='HMPPS/EMS/SharedNetworking',
              MetricData=[
                {
                  'MetricName': 'TransitGatewayAttachmentStatus',
                  'Dimensions': [
                    {
                      'Name': 'TransitGatewayAttachmentId',
                      'Value': k['TransitGatewayAttachments'][0]['TransitGatewayAttachmentId']
                    },
                    {
                      'Name': 'DestinationCidrBlock',
                      'Value': k['DestinationCidrBlock']
                    },
                    {
                      'Name': 'ResourceType',
                      'Value': k['TransitGatewayAttachments'][0]['ResourceType']
                    },
                  ],
                  'Unit': 'None',
                  'Value': 1
                },
              ]
          )


      # Loop over transit gateway routes filtering on blackholed state
      search_blackholed_transit_gateway_routes = ec2.search_transit_gateway_routes(
        TransitGatewayRouteTableId = j['TransitGatewayRouteTableId'],
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
        print("    No Transit Gateway Attachements in blackholed state")
      else:
        for l in search_blackholed_transit_gateway_routes['Routes']:
          print("    Transit Gateway Attachment (Blackholed) " + k['TransitGatewayAttachments'][0]['TransitGatewayAttachmentId'] + " Route: " + k['DestinationCidrBlock'])
          put_cloudwatch_metric_data = cloudwatch.put_metric_data(
              Namespace='HMPPS/EMS/SharedNetworking',
              MetricData=[
                {
                  'MetricName': 'TransitGatewayAttachmentStatus',
                  'Dimensions': [
                    {
                      'Name': 'TransitGatewayAttachmentId',
                      'Value': k['TransitGatewayAttachments'][0]['TransitGatewayAttachmentId']
                    },
                    {
                      'Name': 'DestinationCidrBlock',
                      'Value': k['DestinationCidrBlock']
                    },
                    {
                      'Name': 'ResourceType',
                      'Value': k['TransitGatewayAttachments'][0]['ResourceType']
                    },
                  ],
                  'Unit': 'None',
                  'Value': 0
                },
              ]
          )
