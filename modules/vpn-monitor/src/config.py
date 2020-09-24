import os


class Config:
    __conf = {
        'alarm_name': 'VPN-ALARM',
        'resolver_group': 'MoJ',
        'service_name': 'Vodafone - Network Links (Internet Link and AWS VPN(s))',
        'tolerance_breach_priority': 'P1',
        'redundancy_breach_priority': 'P3',
        'link_down_tolerance': 1
    }

    @staticmethod
    def get(name):

        value = None

        try:
            value = Config.__conf[name]
        except Exception:
            pass

        if value is None:
            value = os.environ.get(name)

        if value is None:
            raise KeyError(
                'Could not retrieve configuration value [{0}]'.format(name))

        return value
