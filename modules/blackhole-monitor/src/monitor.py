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
  getTransitGateways = ec2.describe_transit_gateways()

  # Loop over transit gateways
  for i in getTransitGateways['TransitGateways']:
    print("Transit Gateway: " + i['TransitGatewayId'])
    # Loop over transit gateway route tables filtering on transit gateway ID
    getTransitGatewayRouteTables = ec2.describe_transit_gateway_route_tables(
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
    for j in getTransitGatewayRouteTables['TransitGatewayRouteTables']:
      print("  Transit Gateway Route Table: " + j['TransitGatewayRouteTableId'])
      # Loop over transit gateway routes filtering on active state
      searchActiveTransitGatewayRoutes = ec2.search_transit_gateway_routes(
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
      if len(searchActiveTransitGatewayRoutes['Routes']) == 0:
        print("    No Transit Gateway Attachements in active state")
      else:
        for k in searchActiveTransitGatewayRoutes['Routes']:
          print("    Transit Gateway Attachment (Active) " + k['TransitGatewayAttachments'][0]['TransitGatewayAttachmentId'] + " Route: " + k['DestinationCidrBlock'])
          putCloudwatchMetric = cloudwatch.put_metric_data(
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
      searchBlackholedTransitGatewayRoutes = ec2.search_transit_gateway_routes(
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

      if len(searchBlackholedTransitGatewayRoutes['Routes']) == 0:
        print("    No Transit Gateway Attachements in blackholed state")
      else:
        for l in searchBlackholedTransitGatewayRoutes['Routes']:
          print("    Transit Gateway Attachment (Blackholed) " + k['TransitGatewayAttachments'][0]['TransitGatewayAttachmentId'] + " Route: " + k['DestinationCidrBlock'])
          putCloudwatchMetric = cloudwatch.put_metric_data(
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
