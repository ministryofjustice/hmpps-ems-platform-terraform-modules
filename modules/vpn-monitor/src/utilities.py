import boto3
import json
import logging
from datetime import datetime


logger = logging.getLogger()
logger.setLevel(logging.INFO)


def parse_tags(tags):
    flat_tags = {}
    for t in tags:
        flat_tags[t['Key']] = t['Value']
    return flat_tags
