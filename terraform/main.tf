terraform {
  required_providers {
    pingone = {
      source  = "pingidentity/pingone"
      version = ">= 1.0.0"
    }
    davinci = {
      source = "pingidentity/davinci"
      version = ">= 0.4.1, < 0.4.4"
    }
  }
}

provider "pingone" {
  client_id         = var.worker_id
  client_secret     = var.worker_secret
  environment_id    = var.pingone_environment_id
  region_code       = var.region_code
  append_user_agent = "MasterFlow/0.0.1"
}

provider "davinci" {
  username       = var.admin_username
  password       = var.admin_password
  environment_id = var.pingone_environment_id != "" ? var.pingone_environment_id : var.pingone_environment_id
  region         = var.region
}