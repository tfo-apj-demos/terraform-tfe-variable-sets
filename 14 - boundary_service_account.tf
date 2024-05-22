locals {
  boundary_service_account_vars = [
    "boundary_address",
    "service_account_authmethod_id",
    "service_account_name",
    "service_account_password"
  ]
}

module "boundary_service_account" {
  source  = "app.terraform.io/tfo-apj-demos/varsets/tfe"
  version = "0.0.1"

  tfc_organization = "tfo-apj-demos"
  varset_name = "boundary_service_account"

  varset_variables = [ for variable_name in local.boundary_service_account_vars: {
      name = "${variable_name}"
      value = data.hcp_vault_secrets_secret.boundary_service_account["${variable_name}"].secret_value
      category = "terraform"
    }
  ]
  apply_to_workspace_tags = ["boundary_management"]
}

data "hcp_vault_secrets_secret" "boundary_service_account" {
  for_each = toset(local.gcve_workspace_identity_tfc_vars)
  app_name    = "boundary-service-account"
  secret_name = each.value
}