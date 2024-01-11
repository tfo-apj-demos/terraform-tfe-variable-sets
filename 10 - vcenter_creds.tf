module "vcenter_credentials" {
  source  = "app.terraform.io/tfo-apj-demos/varsets/tfe"
  version = "0.0.1"

  tfc_organization = "tfo-apj-demos"
  varset_name = "vcenter_credentials"

  varset_variables = [
    {
      name = "VSPHERE_USER"
      value = data.vault_generic_secret.this.data.username
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