locals {
  gcve_workspace_identity_tfc_vars = [
    "TFC_VAULT_ADDR",
    "TFC_VAULT_AUTH_PATH",
    "TFC_VAULT_PROVIDER_AUTH",
    "TFC_VAULT_RUN_ROLE",
    "TFC_VAULT_WORKLOAD_IDENTITY_AUDIENCE",
    "TFC_VAULT_ENCODED_CACERT",
  ]
}

module "workspace_auth_vault_gcve" {
  source  = "app.terraform.io/tfo-apj-demos/varsets/tfe"
  version = "~> 0.0"

  tfc_organization = "tfo-apj-demos"
  varset_name = "__gcve_workspace_identity_tfc"
  workspace_tags = ["vault-gcve"]

  varset_variables = [ for variable_name in local.gcve_workspace_identity_tfc_vars: {
      name = "${variable_name}"
      value = data.hcp_vault_secrets_secret.this["${variable_name}"].secret_value
      category = "env"
    }
  ]
}

data "hcp_vault_secrets_secret" "this" {
  for_each = toset(local.gcve_workspace_identity_tfc_vars)
  app_name    = "gcve-tfc-workspace-identity"
  secret_name = each.value
}