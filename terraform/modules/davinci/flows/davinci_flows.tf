terraform {
  required_providers {
    davinci = {
      source = "pingidentity/davinci"
    }
  }
}

provider "davinci" {
  username       = var.dv_admin_username
  password       = var.dv_admin_password
  environment_id = var.admin_environment_id
  region         = var.region
}

#########################
#  DaVinci Application  #
#########################

resource "davinci_application" "PingOne-SSO-Connection" {
  api_key_enabled = "true"
  environment_id  = var.pingone_environment_master_flow_environment_id
  name            = "PingOne SSO Connection"

  oauth {
    enabled = "true"

    values {
      allowed_grants                = ["authorizationCode"]
      allowed_scopes                = ["openid", "profile"]
      enabled                       = "true"
      enforce_signed_request_openid = "false"
      redirect_uris                 = ["https://auth.pingone.com/${var.pingone_environment_master_flow_environment_id}/rp/callback/openid_connect"]
    }
  }

  saml {
    values {
      enabled                = "false"
      enforce_signed_request = "false"
    }
  }
}

resource "davinci_application_flow_policy" "PingOne-SSO-Flow-Policy" {
  environment_id = var.pingone_environment_master_flow_environment_id
  application_id = davinci_application.PingOne-SSO-Connection.id
  name           = "PingOne SSO Connection"
  status         = "enabled"
  policy_flow {
    flow_id    = davinci_flow.PingOne-SSO-Authentication-MASTER.id
    version_id = -1
    weight     = 100
  }
}

###################
#  Davinci Flows  #
###################

resource "davinci_flow" "PingOne-Custom-Security-Question-and-Answer-Registration-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Custom Security Question and Answer Registration subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-Davinci-Custom-Magic-Link-registration-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Challenge_id
    name = "Challenge"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-MFA_id
    name = "PingOne MFA"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-Notifications_id
    name = "PingOne Notifications"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Davinci Custom Magic Link registration subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-Davinci-Custom-Magic-Link-Subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Challenge_id
    name = "Challenge"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-Notifications_id
    name = "PingOne Notifications"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }
  
  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Davinci Custom Magic Link Subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-MFA-Authentication-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-MFA_id
    name = "PingOne MFA"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne MFA Authentication subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-Subflow.id
    name = "PingOne Davinci Custom Magic Link Subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Management-Subflow.id
    name = "PingOne MFA Device Management Subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
    name = "PingOne MFA Device Registration subflow"
  }

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-MFA-Device-Management-Subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-MFA_id
    name = "PingOne MFA"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne MFA Device Management Subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
    name = "PingOne MFA Device Registration subflow"
  }

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-MFA-Device-Registration-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-MFA_id
    name = "PingOne MFA"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne MFA Device Registration subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.id
    name = "PingOne Davinci Custom Magic Link registration subflow"
  }

  depends_on = [
    var.davinci_connections_read_connections
  ]
  #subflow_link {
  #  id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
  #  name = "PingOne MFA Authentication subflow"
  #}
}

resource "davinci_flow" "PingOne-Protect-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-Protect_id
    name = "PingOne Protect"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Protect subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = "PingOne MFA Authentication subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Verify-subflow.id
    name = "PingOne Verify subflow"
  }

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Account-Verification-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Account Verification subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Authentication-MASTER" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-Authentication_id
    name = "PingOne Authentication"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Authentication MASTER.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = "PingOne MFA Authentication subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-User-Registration-subflow.id
    name = "PingOne SSO User Registration subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Protect-subflow.id
    name = "PingOne Protect subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Account-Verification-subflow.id
    name = "PingOne SSO Account Verification subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Change-Password-subflow.id
    name = "PingOne SSO Change Password subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Forgot-Password-subflow.id
    name = "PingOne SSO Forgot Password subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Forgot-Username-subflow.id
    name = "PingOne SSO Forgot Username subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Password-Expiration-subflow.id
    name = "PingOne SSO Password Expiration subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.id
    name = "PingOne SSO Progressive Profiling subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Social-External-IdP-authentication-subflow.id
    name = "PingOne SSO Social External IdP authentication subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Authorize-subflow.id
    name = "PingOne Authorize Flow"
  }

    subflow_link {
    id   = davinci_flow.PingOne-reCAPTCHA-v3-subflow.id
    name = "PingOne reCAPTCHA v3 Sign On Example"
  }

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Change-Password-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-MFA_id
    name = "PingOne MFA"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Change Password subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Consent-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Consent subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Forgot-Password-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Forgot Password subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = "PingOne MFA Authentication subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Security-Question-and-Answer-Validation-subflow.id
    name = "PingOne Security Question and Answer Validation subflow"
  }

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Forgot-Username-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-Notifications_id
    name = "PingOne Notifications"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Forgot Username subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Password-Expiration-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Password Expiration subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Progressive-Profiling-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Progressive Profiling subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Social-External-IdP-authentication-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-Authentication_id
    name = "PingOne Authentication"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Social External IdP authentication subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-Auto-enroll-user-in-email.id
    name = "PingOne Auto enroll user in email"
  }

    subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = "PingOne MFA Authentication subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Protect-subflow.id
    name = "PingOne Protect subflow"
  }

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-User-Registration-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-MFA_id
    name = "PingOne MFA"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO User Registration subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-Custom-Security-Question-and-Answer-Registration-subflow.id
    name = "PingOne Custom Security Question and Answer Registration subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Protect-subflow.id
    name = "PingOne Protect subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
    name = "PingOne MFA Device Registration subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Account-Verification-subflow.id
    name = "PingOne SSO Account Verification subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Consent-subflow.id
    name = "PingOne SSO Consent subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.id
    name = "PingOne SSO Progressive Profiling subflow"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Verify-subflow.id
    name = "PingOne Verify subflow"
  }

  depends_on = [
    var.davinci_connections_read_connections
  ]
}


resource "davinci_flow" "PingOne-Security-Question-and-Answer-Validation-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Security Question and Answer Validation subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

/*
resource "davinci_flow" "PingOne-Session-Main-Flow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-Authentication_id
    name = "PingOne Authentication"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Session Main Flow.json")}"
/*
  subflow_link {
    id   = davinci_flow.PingOne-Sign-On-with-Registration-Password-Reset-and-Recovery.id
    name = "PingOne Sign On with Registration, Password Reset and Recovery"
  }
* /
  depends_on = [
    var.davinci_connections_read_connections
  ]
}



resource "davinci_flow" "PingOne-Sign-On-with-Registration-Password-Reset-and-Recovery" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Sign On with Registration, Password Reset and Recovery.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}*/

resource "davinci_flow" "PingOne-Verify-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne_id
    name = "PingOne"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-Verify_id
    name = "PingOne Verify"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Verify subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-reCAPTCHA-v3-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne reCAPTCHA v3  subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-Authorize-subflow" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-MFA_id
    name = "PingOne MFA"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-Authorize_id
    name = "PingOne Authorize"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Error-Message_id
    name = "Error Message"
  }

  connection_link {
    id   = var.davinci_connection_Flow-Connector_id
    name = "Flow Connector"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Verify subflow.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}

resource "davinci_flow" "PingOne-Auto-enroll-user-in-email" {
  connection_link {
    id   = var.davinci_connection_Annotation_id
    name = "Annotation"
  }

  connection_link {
    id   = var.davinci_connection_Functions_id
    name = "Functions"
  }

  connection_link {
    id   = var.davinci_connection_Http_id
    name = "Http"
  }

  connection_link {
    id   = var.davinci_connection_Node_id
    name = "Teleport"
  }

  connection_link {
    id   = var.davinci_connection_PingOne-MFA_id
    name = "PingOne MFA"
  }

  connection_link {
    id   = var.davinci_connection_Variables_id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = var.pingone_environment_master_flow_environment_id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Auto enroll user in email.json")}"

  depends_on = [
    var.davinci_connections_read_connections
  ]
}