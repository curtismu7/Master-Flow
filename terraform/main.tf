terraform {
  required_providers {
    pingone = {
      source  = "pingidentity/pingone"
      version = ">= 0.27.0, < 1.0.0"
    }
    davinci = {
      source = "pingidentity/davinci"
      version = ">= 0.3.1, < 1.0.0"
    }
  }
}

provider "pingone" {
  client_id      = var.worker_id
  client_secret  = var.worker_secret
  environment_id = var.pingone_environment_id
  region         = var.region
}

provider "davinci" {
  username       = var.admin_username
  password       = var.admin_password
  environment_id = var.pingone_environment_id != "" ? var.pingone_environment_id : var.pingone_environment_id
  region         = var.region
}