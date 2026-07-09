module "vcenter_credentials" {
  source  = "app.terraform.io/tfo-apj-demos/varsets/tfe"
  version = "~> 0.0"

  tfc_organization = "tfo-apj-demos"
  varset_name      = "__gcve_vcenter_variables"
  workspace_tags   = ["vcenter"]

  # VSPHERE_PASSWORD retired 2026-07-09. Every vSphere workspace now reads the
  # vm_builder password from Vault at run time via TFC workload-identity dynamic
  # credentials. The sole exception, vsphere-vault-deploy — which deploys the very
  # Vault it would otherwise read from (a circular dependency) — uses a dedicated
  # long-living account set as a workspace-level VSPHERE_PASSWORD.
  #
  # This varset now carries only the static, non-rotating server + username, so the
  # 8-hourly rotation apply is no longer needed (schedule removed from the GitHub
  # Action). vm_builder's username is static — Vault rotates the password, not the
  # account name — so it is hardcoded here instead of read from the Vault LDAP mount.
  varset_variables = [
    {
      name     = "VSPHERE_USER"
      value    = "vm_builder@hashicorp.local"
      category = "env"
    },
    {
      name     = "VSPHERE_SERVER"
      value    = var.vcenter_address
      category = "env"
    }
  ]
}
