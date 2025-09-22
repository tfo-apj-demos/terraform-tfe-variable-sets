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