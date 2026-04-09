locals {
  default_tags = {
    application          = "example-app"
    applicationshortname = "example"
    business_owner       = "TBD"
    technical_owner      = "TBD"
    support_group        = "TBD"
    confidentiality      = "internal"
    department           = "engineering"
    domain               = "cloud"
    cost_centre          = "111108"
    environment          = var.environment
    provisioned_by       = "terraform"
    repo                 = "myaccount-dlg"
    project              = "myaccount-dlg"
  }
}
