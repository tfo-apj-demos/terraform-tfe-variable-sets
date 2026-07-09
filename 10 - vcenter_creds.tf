module "vcenter_credentials" {
  source  = "app.terraform.io/tfo-apj-demos/varsets/tfe"
  version = "~> 0.0"

  tfc_organization = "tfo-apj-demos"
  varset_name      = "__gcve_vcenter_variables"
  workspace_tags   = ["vcenter"]

  # VSPHERE_USER and VSPHERE_PASSWORD retired 2026-07-09. Every vSphere workspace
  # now reads the vm_builder vCenter credential from Vault at run time via TFC
  # workload-identity dynamic credentials — the provider "vsphere" block sets both
  # user and password from data.vault_ldap_static_credentials.vm_builder, so the
  # workspaces no longer consume VSPHERE_USER/VSPHERE_PASSWORD from this varset.
  #
  # The sole exception, vsphere-vault-deploy — which deploys the very Vault it would
  # otherwise read from (a circular dependency) — uses a dedicated long-living
  # account set as workspace-level VSPHERE_USER/VSPHERE_PASSWORD that override this
  # varset. (vsphere-k8s-minikube is intentionally left un-migrated; give it its own
  # standalone VSPHERE_* vars before this change is applied, or it will lose vCenter
  # auth on the next run.)
  #
  # This varset now carries only the static, non-rotating server address, so the
  # 8-hourly rotation apply is no longer needed (schedule removed from the GitHub
  # Action) and the Vault LDAP data source that fed the rotating password is gone.
  varset_variables = [
    {
      name     = "VSPHERE_SERVER"
      value    = var.vcenter_address
      category = "env"
    }
  ]
}
