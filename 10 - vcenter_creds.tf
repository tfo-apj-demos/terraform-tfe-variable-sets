module "vcenter_credentials" {
  source  = "app.terraform.io/tfo-apj-demos/varsets/tfe"
  version = "~> 0.0"

  tfc_organization = "tfo-apj-demos"
  varset_name = "__gcve_vcenter_variables"
  workspace_tags = [ "vcenter" ]

  varset_variables = [
    {
      name = "VSPHERE_USER"
      value = "${data.vault_generic_secret.this.data.username}@hashicorp.local"
      category = "env"
    },
    {
      name = "VSPHERE_PASSWORD"
      value = data.vault_generic_secret.this.data.password
      category = "env"
      sensitive = true
    },
    {
      name = "VSPHERE_SERVER"
      value = var.vcenter_address
      category = "env"
    }
  ]
}

data "vault_generic_secret" "this" {
  path = "ldap/creds/vsphere_access"
}