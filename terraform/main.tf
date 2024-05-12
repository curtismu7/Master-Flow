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
  client_id      = var.admin_client_id
  client_secret  = var.admin_client_secret
  environment_id = var.admin_environment_id
  region         = var.region
}

provider "davinci" {
  username       = var.dv_admin_username
  password       = var.dv_admin_password
  environment_id = var.dv_environment_id != "" ? var.dv_environment_id : var.admin_environment_id
  region         = var.region
}