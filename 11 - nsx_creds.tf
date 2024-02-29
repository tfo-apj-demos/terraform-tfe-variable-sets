module "nsx_credentials" {
  source  = "app.terraform.io/tfo-apj-demos/varsets/tfe"
  version = "~> 0.0"

  tfc_organization = "tfo-apj-demos"
  varset_name = "__gcve_nsx_variables"
  workspace_tags = [ "vcenter" ]

  varset_variables = [
    {
      name = "NSXT_USERNAME"
      value = data.vault_generic_secret.this.data.username
      category = "env"
    },
    {
      name = "NSXT_PASSWORD"
      value = data.vault_generic_secret.this.data.password
      category = "env"
      sensitive = true
    },
    {
      name = "NSXT_MANAGER_HOST"
      value = var.vcenter_address
      category = "env"
    }
  ]
}