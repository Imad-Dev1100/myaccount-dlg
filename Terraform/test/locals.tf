locals {
  platform_code = "gfdigital"
  service_name  = "myaccount"

  default_tags = {
    application    = "myaccount-dlg"
    business_owner = "TBD"
    cost_centre    = "111108"
    domain         = "cloud"
    environment    = var.environment
    support_group  = "TBD"
    technical_owner = "TBD"
    used_for       = "infrastructure-provisioning"
  }

  resource_prefix = "${local.platform_code}_${var.environment}_${local.service_name}"
  bucket_prefix   = "${local.platform_code}-${var.environment}-${local.service_name}"
  vpc_name        = "${local.platform_code}ctgfdigital${var.environment}-vpc"
}
