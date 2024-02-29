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
  }
}