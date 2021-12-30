####################
# NCSC CAF
####################
data "http" "ncsc_caf" {
  url = "https://raw.githubusercontent.com/awslabs/aws-config-rules/master/aws-config-conformance-packs/Operational-Best-Practices-for-NCSC-CAF.yaml"
}

resource "aws_config_conformance_pack" "ncsc_caf" {
  name          = "Operational-Best-Practices-for-NCSC-CAF"
  template_body = data.http.ncsc_caf.body
}

####################
# NCSC CAF
####################
data "http" "ncsc_cloudsec" {
  url = "https://raw.githubusercontent.com/awslabs/aws-config-rules/master/aws-config-conformance-packs/Operational-Best-Practices-for-NCSC-CloudSec-Principles.yaml"
}

resource "aws_config_conformance_pack" "ncsc_cloudsec" {
  name          = "Operational-Best-Practices-for-NCSC-CloudSec-Principles"
  template_body = data.http.ncsc_cloudsec.body
}
