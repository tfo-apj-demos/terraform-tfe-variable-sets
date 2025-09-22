# locals {
#   nsx_vars = [
#     "NSXT_USERNAME",
#     "NSXT_PASSWORD",
#     "NSXT_MANAGER_HOST"
#   ]
# }

# module "nsx_credentials" {
#   source  = "app.terraform.io/tfo-apj-demos/varsets/tfe"
#   version = "~> 0.0"

#   tfc_organization = "tfo-apj-demos"
#   varset_name = "__gcve_nsx_variables"
#   workspace_tags = [ "vcenter" ]

#   varset_variables = [ for variable_name in local.nsx_vars: {
#       name = "${variable_name}"
#       # value = data.hcp_vault_secrets_secret.nsx["${variable_name}"].secret_value
#       value = ""
#       category = "env"
#     }
#   ]
# }

# data "hcp_vault_secrets_secret" "nsx" {
#   for_each = toset(local.nsx_vars)
#   app_name    = "nsx-gcve"
#   secret_name = each.value
# }