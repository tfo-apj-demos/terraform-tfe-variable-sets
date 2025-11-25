terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3"
    }
    hcp = {
      source = "hashicorp/hcp"
      version = "~> 0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.69"
    }
  }
}

// add skip_tls_verify
provider "vault" {
  skip_tls_verify = true
}