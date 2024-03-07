# Security Operations Centre Role

A reusable, configurable role that can be easily deployed into an AWS account that grants access to security events.

Currently supported:
- Processing of logs in the shared logging environment
  - Access to S3 Buckets containing logs of security events
  - Access to SQS Queues containing notifications of S3 Object Created Events
- Processing of security events from AWS APIs
  - SecurityHub
- Asset collection
  - EC2 Instance Metadata

Possible additions:
- Processing of security events from AWS APIs
  - GuardDuty
