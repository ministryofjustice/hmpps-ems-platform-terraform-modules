# Security Operations Centre Role

A reusable, configurable role that can be easily deployed into an AWS account that grants access to seceurity events.

Currently supported:
- Processing of logs in the shared logging environment
  - Access to S3 Buckets containing logs of security events
  - Access to SQS Queues containing notifications of S3 Object Created Events

Possible additions:
- Proccessing of security events from AWS APIs
  - GuardDuty
  - SecurityHub
- Asset colletion
  - EC2 Instance Metadata