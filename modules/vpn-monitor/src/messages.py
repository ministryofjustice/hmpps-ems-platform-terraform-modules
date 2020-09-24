import boto3
import logging
from os import path
from config import Config
from jinja2 import Environment, FileSystemLoader


sns = boto3.client('sns')
logger = logging.getLogger()
logger.setLevel(logging.INFO)


def format_snow_message(ci_name, priority):

    message = '<{lot}><{priority}><{service_name}><{alarm_name}><{ci_name}>'.format(
        lot=Config.get('resolver_group'),
        priority=priority,
        alarm_name=Config.get('alarm_name'),
        service_name=Config.get('service_name'),
        ci_name=ci_name
    )

    return message


def get_message_body(template_name, parameters):

    env = Environment(loader=FileSystemLoader(
        path.join(path.dirname(__file__), 'templates'), encoding='utf8'))
    template = env.get_template(template_name)

    return template.render(**parameters)


def send_sns_message(topic_name, subject, message):

    topic = sns.create_topic(Name=topic_name)
    sns.publish(
        TopicArn=topic["TopicArn"],
        Subject=subject,
        Message=message
    )
    logger.info('Succesfully published message to sns topic {0}'.format(topic["TopicArn"]))
