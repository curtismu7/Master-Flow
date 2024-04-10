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
#  DaVinci Connections  #
#########################

data "davinci_connections" "read_connections" {
  environment_id = var.pingone_environment_master_flow_environment_id

  connector_ids = [
    "annotationConnector", 
    "challengeConnector", 
    "errorConnector", 
    "flowConnector", 
    "functionsConnector", 
    "httpConnector", 
    "nodeConnector",
    "pingOneSSOConnector",
    "pingOneAuthenticationConnector",
    "pingOneMfaConnector",
    "notificationsConnector",
    "pingOneRiskConnector",
    "pingOneVerifyConnector",
    "skOpenIdConnector",
    "userPolicyConnector",
    "variablesConnector"
  ]
}

resource "davinci_connection" "Annotation" {
  connector_id   = "annotationConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "Annotation"
}

resource "davinci_connection" "Challenge" {
  connector_id   = "challengeConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "Challenge"
}

resource "davinci_connection" "Error-Message" {
  connector_id   = "errorConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "Error Message"
}

resource "davinci_connection" "Flow-Connector" {
  connector_id   = "flowConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "Flow Connector"
}

resource "davinci_connection" "Functions" {
  connector_id   = "functionsConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "Functions"
}

resource "davinci_connection" "Http" {
  connector_id   = "httpConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "Http"
}

resource "davinci_connection" "Node" {
  connector_id   = "nodeConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "Teleport"
}

resource "davinci_connection" "PingOne" {
  connector_id   = "pingOneSSOConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "PingOne"

  property {
    name  = "clientId"
    value = var.pingone_application_dv_worker_app_oidc_options_client_id
  }

  property {
    name  = "clientSecret"
    value = var.pingone_application_dv_worker_app_oidc_options_client_secret
  }

  property {
    name  = "envId"
    value = var.pingone_environment_master_flow_environment_id
  }

  property {
    name  = "region"
    value = var.davinci_connection_PingOne_region
  }
}

resource "davinci_connection" "PingOne-Authentication" {
  connector_id   = "pingOneAuthenticationConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "PingOne Authentication"
}

resource "davinci_connection" "PingOne-MFA" {
  connector_id   = "pingOneMfaConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "PingOne MFA"

  property {
    name  = "clientId"
    value = var.pingone_application_dv_worker_app_oidc_options_client_id
  }

  property {
    name  = "clientSecret"
    value = var.pingone_application_dv_worker_app_oidc_options_client_secret
  }

  property {
    name  = "envId"
    value = var.pingone_environment_master_flow_environment_id
  }

  property {
    name  = "region"
    value = var.davinci_connection_PingOne_region
  }
}

resource "davinci_connection" "PingOne-Authorize" {
  connector_id   = "pingOneAuthorizeConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "PingOne Authorize"

  property {
    name  = "clientId"
    value = var.pingone_application_dv_worker_app_oidc_options_client_id
  }

  property {
    name  = "clientSecret"
    value = var.pingone_application_dv_worker_app_oidc_options_client_secret
  }

  property {
    name  = "endpointURL"
    value = ""
  }
}

resource "davinci_connection" "PingOne-Notifications" {
  connector_id   = "notificationsConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "PingOne Notifications"

  property {
    name  = "clientId"
    value = var.pingone_application_dv_worker_app_oidc_options_client_id
  }

  property {
    name  = "clientSecret"
    value = var.pingone_application_dv_worker_app_oidc_options_client_secret
  }

  property {
    name  = "envId"
    value = var.pingone_environment_master_flow_environment_id
  }

  property {
    name  = "region"
    value = var.davinci_connection_PingOne_region
  }
}

resource "davinci_connection" "PingOne-Protect" {
  connector_id   = "pingOneRiskConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "PingOne Protect"

  property {
    name  = "clientId"
    value = var.pingone_application_dv_worker_app_oidc_options_client_id
  }

  property {
    name  = "clientSecret"
    value = var.pingone_application_dv_worker_app_oidc_options_client_secret
  }

  property {
    name  = "envId"
    value = var.pingone_environment_master_flow_environment_id
  }

  property {
    name  = "region"
    value = var.davinci_connection_PingOne_region
  }
}

resource "davinci_connection" "PingOne-Verify" {
  connector_id   = "pingOneVerifyConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "PingOne Verify"
}

resource "davinci_connection" "Token-Management" {
  connector_id   = "skOpenIdConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "Token Management"
}

resource "davinci_connection" "User-Policy" {
  connector_id   = "userPolicyConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "User Policy"
}

resource "davinci_connection" "Variables" {
  connector_id   = "variablesConnector"
  environment_id = var.pingone_environment_master_flow_environment_id
  name           = "Variables"
}



#######################
#  DaVinci Variables  #
#######################

resource "davinci_variable" "CodeSentMsg" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "CodeSentMsg"
  type           = "string"


}

resource "davinci_variable" "IsActionReg" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "IsActionReg"
  type           = "boolean"


}

resource "davinci_variable" "adminMessage" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "adminMessage"
  type           = "string"


}

resource "davinci_variable" "availableQuestions" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "availableQuestions"
  type           = "object"


}

resource "davinci_variable" "availableQuestions_2" {
  context        = "company"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "availableQuestions"
  type           = "object"
  value          = "${var.davinci_variable_availableQuestions_2_value}"



}

resource "davinci_variable" "buttonValueDeviceId" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "buttonValueDeviceId"
  type           = "string"


}

resource "davinci_variable" "canChangeDevice" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "canChangeDevice"
  type           = "boolean"


}

resource "davinci_variable" "companyName" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "companyName"
  type           = "string"


}

resource "davinci_variable" "deviceCount" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "deviceCount"
  type           = "number"


}

resource "davinci_variable" "gotoLogin" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gotoLogin"
  type           = "boolean"


}

resource "davinci_variable" "gv-QA-On" {
  context        = "company"
  description    = "Determines if KBA (Question and Answer) is turned on for Forgot password"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-QA-On"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-QA-On_value}"


}

resource "davinci_variable" "gv-allowPasswordless" {
  context        = "company"
  description    = "This shows both Password and passwordless button for sign in"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-allowPasswordless"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-allowPasswordless_value}"


}


resource "davinci_variable" "gv-mfaOnHighRisk" {
  context        = "company"
  description    = "This shows both Password and passwordless button for sign in"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-mfaOnHighRisk"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-mfaOnHighRisk}"
}

resource "davinci_variable" "gv-riskScreenDisplay" {
  context        = "company"
  description    = "This shows both Password and passwordless button for sign in"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-riskScreenDisplay"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-riskScreenDisplay}"


}

resource "davinci_variable" "gv-fakeLevel" {
  context        = "company"
  description    = "This tells the flow to use the gv-riskLevel for its score."
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-fakeLevel"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-mfaOnHighRisk}"


}


resource "davinci_variable" "gv-runVerifyUserRegistration" {
  context        = "company"
  description    = "This shows both Password and passwordless button for sign in"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runVerifyUserRegistration"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runVerifyUserRegistration}"


}

resource "davinci_variable" "gv-azureLogin" {
  context        = "company"
  description    = "Determine if Microsoft Azure is available"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-azureLogin"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-azureLogin_value}"


}

resource "davinci_variable" "gv-companyLogo" {
  context        = "company"
  description    = "URL for company logo, so easy to change on Sign in window"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-companyLogo"
  type           = "string"
  value          = "${var.davinci_variable_gv-companyLogo_value}"


}

resource "davinci_variable" "gv-companyName" {
  context        = "company"
  description    = "Used so you can easily change company Name on sign in window"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-companyName"
  type           = "string"
  value          = "${var.davinci_variable_gv-companyName_value}"


}

resource "davinci_variable" "gv-consent" {
  context        = "company"
  description    = "Consent (agreements in PingOne)"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-consent"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-consent_value}"


}

resource "davinci_variable" "gv-deviceManagement" {
  context        = "company"
  description    = "Determine if device management  is available"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-deviceManagement"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-deviceManagement_value}"


}

resource "davinci_variable" "gv-facebookLogin" {
  context        = "company"
  description    = "Determine if Facebook is available"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-facebookLogin"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-facebookLogin_value}"


}

resource "davinci_variable" "gv-facebookExternalIdpId" {

  context        = "company"
  description    = "The ID of the Facebook External IDP"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-facebookExternalIdpId"
  type           = "string"
  value          = var.davinci_variable_gv-facebookLogin_value == "true" ? "${var.pingone_identity_provider_facebook_id}" : "N/A"


}

resource "davinci_variable" "gv-forcePasswordless" {
  context        = "company"
  description    = "This will only allow you to login with Passwordless"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-forcePasswordless"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-forcePasswordless_value}"


}

resource "davinci_variable" "gv-forgotPasswordDisplay" {
  context        = "company"
  description    = "determines if to show Forgot Password on sign in window"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "false"
  name           = "gv-forgotPasswordDisplay"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-forgotPasswordDisplay_value}"


}

resource "davinci_variable" "gv-forgotUsernameDisplay" {
  context        = "company"
  description    = "determines if to show forgot username on sign in window"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "false"
  name           = "gv-forgotUsernameDisplay"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-forgotUsernameDisplay_value}"


}

resource "davinci_variable" "gv-githubLogin" {
  context        = "company"
  description    = "Determine if Github is available"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-githubLogin"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-githubLogin_value}"


}

resource "davinci_variable" "gv-googleLogin" {
  context        = "company"
  description    = "Determine if Google is available"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-googleLogin"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-googleLogin_value}"


}

resource "davinci_variable" "gv-googleExternalIdpId" {

  context        = "company"
  description    = "The ID of the Google External IDP"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-googleExternalIdpId"
  type           = "string"
  value          = var.davinci_variable_gv-googleLogin_value == "true" ? "${var.pingone_identity_provider_google_id}" : "N/A"


}

resource "davinci_variable" "gv-inlineMFAOn" {
  context        = "company"
  description    = "Determines if to run MFA inline"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-inlineMFAOn"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-inlineMFAOn_value}"


}

resource "davinci_variable" "gv-mfa-on" {
  context        = "company"
  description    = "Turn on and off MFA"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-mfa-on"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-mfa-on_value}"


}

resource "davinci_variable" "gv-p1AgreementId" {
  context        = "company"
  description    = "PingOne Agreement Id"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-p1AgreementId"
  type           = "string"
  value          = var.pingone_agreement_master_flow_agreement_id


}

resource "davinci_variable" "gv-p1PasswordPolicy" {
  context        = "company"
  description    = "Password Policy, pulled from PingOne"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-p1PasswordPolicy"
  type           = "object"
  value          = replace(replace(replace(jsonencode({
                      "id": jsondecode(var.pingone_password_policy_standard_password_policy).id,
                      "environment": { "id": jsondecode(var.pingone_password_policy_standard_password_policy).environment_id },
                      "name": jsondecode(var.pingone_password_policy_standard_password_policy).name,
                      "description": jsondecode(var.pingone_password_policy_standard_password_policy).description,
                      "excludesProfileData": jsondecode(var.pingone_password_policy_standard_password_policy).exclude_profile_data,
                      "notSimilarToCurrent": jsondecode(var.pingone_password_policy_standard_password_policy).not_similar_to_current,
                      "excludesCommonlyUsed": jsondecode(var.pingone_password_policy_standard_password_policy).exclude_commonly_used_passwords,
                      "maxAgeDays": 22,
                      "history": { "count": jsondecode(var.pingone_password_policy_standard_password_policy).password_history[0].prior_password_count, "retentionDays": jsondecode(var.pingone_password_policy_standard_password_policy).password_history[0].retention_days },
                      "lockout": { "failureCount": jsondecode(var.pingone_password_policy_standard_password_policy).account_lockout[0].fail_count, "durationSeconds": jsondecode(var.pingone_password_policy_standard_password_policy).account_lockout[0].duration_seconds },
                      "length": { "min": jsondecode(var.pingone_password_policy_standard_password_policy).password_length[0].min, "max": jsondecode(var.pingone_password_policy_standard_password_policy).password_length[0].max },
                      "minCharacters": {
                        "~!@#$%^&*()-_=+[]{}|;:,.<>/?": jsondecode(var.pingone_password_policy_standard_password_policy).min_characters[0].special_characters,
                        "0123456789": jsondecode(var.pingone_password_policy_standard_password_policy).min_characters[0].numeric,
                        "ABCDEFGHIJKLMNOPQRSTUVWXYZ": jsondecode(var.pingone_password_policy_standard_password_policy).min_characters[0].alphabetical_uppercase,
                        "abcdefghijklmnopqrstuvwxyz": jsondecode(var.pingone_password_policy_standard_password_policy).min_characters[0].alphabetical_lowercase
                      },
                      "populationCount": jsondecode(var.pingone_password_policy_standard_password_policy).population_count,
                      "default": true
                    }), "\\u0026", "&"), "\\u003c", "<"), "\\u003e", ">")


}

resource "davinci_variable" "gv-p1PopulationId" {
  context        = "company"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-p1PopulationId"
  type           = "string"
  value          = var.pingone_population_default_population_id


}

resource "davinci_variable" "gv-passwordlessAllowedTypes" {
  context        = "company"
  description    = "JSON showing allowed types for Passwordless"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-passwordlessAllowedTypes"
  type           = "object"
  value          = "${var.davinci_variable_gv-passwordlessAllowedTypes_value}"


}

resource "davinci_variable" "gv-progressiveProfiling" {
  context        = "company"
  description    = "Turn on Progressive profiling"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-progressiveProfiling"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-progressiveProfiling_value}"


}

resource "davinci_variable" "gv-riskLevel" {
  context        = "company"
  description    = "Used to control the Risk Level for Demos"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-riskLevel"
  type           = "string"
  value          = "${var.davinci_variable_gv-riskLevel_value}"


}

resource "davinci_variable" "gv-runMFAforForgot" {
  context        = "company"
  description    = "MFA and OTP for forgot password (drop down)"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runMFAforForgot"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runMFAforForgot_value}"


}

resource "davinci_variable" "gv-runMFAforLogin" {
  context        = "company"
  description    = "Run PingOne MFA after username login"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runMFAforLogin"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runMFAforLogin_value}"


}

resource "davinci_variable" "gv-runMFAforSocial" {
  context        = "company"
  description    = "Decide to run MFA after social login"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "false"
  name           = "gv-runMFAforSocial"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runMFAforSocial_value}"


}

resource "davinci_variable" "gv-runPasswordExpire" {
  context        = "company"
  description    = "Determines if we should run Password Expiration flow "
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runPasswordExpire"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runPasswordExpire_value}"


}

resource "davinci_variable" "gv-runProtect" {
  context        = "company"
  description    = "Run PingOne Protect subflow"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runProtect"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runProtect_value}"


}

resource "davinci_variable" "gv-runVerifyforHighRisk" {
  context        = "company"
  description    = "If you want to run Verify when user is High Risk"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runVerifyforHighRisk"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runVerifyforHighRisk_value}"


}

resource "davinci_variable" "gv-standardForgotPassword" {
  context        = "company"
  description    = "turn on Standard forgot password - Just MFA"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-standardForgotPassword"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-standardForgotPassword_value}"


}

resource "davinci_variable" "gv-isDeviceManagement" {
  context        = "company"
  description    = "Turns on the new device management page, allowing dev management in the middle of the flow"
  environment_id = var.pingone_environment_master_flow_environment_id
  mutable        = "true"
  name           = "gv-isDeviceManagement"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-isDeviceManagement}"


}

resource "davinci_variable" "gv-webAuthnSupport" {
  context        = "company"
  description    = "Set webauthn to \"platform\" or \"cross-platform\""
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-webAuthnSupport"
  type           = "string"
  value          = "${var.davinci_variable_gv-webAuthnSupport_value}"


}

resource "davinci_variable" "origin" {
  context        = "company"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "origin"
  type           = "string"
  value          = "${var.davinci_variable_origin_value}"


}

resource "davinci_variable" "origin_2" {
  context        = "flowInstance"
  description    = "FIDO2 origin"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "origin"
  type           = "string"
  value          = "${var.davinci_variable_origin_2_value}"


}

resource "davinci_variable" "p1AgreementId" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1AgreementId"
  type           = "string"


}

resource "davinci_variable" "p1AuthMethods" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1AuthMethods"
  type           = "string"


}

resource "davinci_variable" "p1AuthenticationMethods" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1AuthenticationMethods"
  type           = "string"


}

resource "davinci_variable" "p1DeviceAuthenticationId" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1DeviceAuthenticationId"
  type           = "string"


}

resource "davinci_variable" "p1DeviceId" {
  context        = "flowInstance"
  description    = "local device ID variable to manage the most current user device being used"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1DeviceId"
  type           = "string"


}

resource "davinci_variable" "p1UserId" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1UserId"
  type           = "string"


}

resource "davinci_variable" "populationId" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "populationId"
  type           = "string"
  value          = var.pingone_population_default_population_id


}

resource "davinci_variable" "preppedDevices" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "preppedDevices"
  type           = "object"


}

resource "davinci_variable" "publicKeyCredentialRequestOptions" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "publicKeyCredentialRequestOptions"
  type           = "string"


}

resource "davinci_variable" "relyingParty" {
  context        = "company"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "relyingParty"
  type           = "string"
  value          = "${var.davinci_variable_relyingParty_value}"


}

resource "davinci_variable" "relyingParty_2" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "relyingParty"
  type           = "string"


}

resource "davinci_variable" "rpid" {
  context        = "company"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "rpid"
  type           = "string"
  value          = "${var.davinci_variable_rpid_value}"


}

resource "davinci_variable" "rpid_2" {
  context        = "flowInstance"
  description    = "Relying Party ID"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "rpid"
  type           = "string"


}

resource "davinci_variable" "selectedDeviceId" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "selectedDeviceId"
  type           = "string"


}

resource "davinci_variable" "showCodeSentMsg" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "showCodeSentMsg"
  type           = "boolean"


}

resource "davinci_variable" "showRegButton" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "showRegButton"
  type           = "boolean"
  value          = "${var.davinci_variable_showRegButton_value}"


}

resource "davinci_variable" "showSettings" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "showSettings"
  type           = "boolean"


}

resource "davinci_variable" "stopSign" {
  context        = "flowInstance"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "stopSign"
  type           = "string"
  value          = "${var.davinci_variable_stopSign_value}"


}

resource "davinci_variable" "gv-captchaThreshold" {
  context        = "company"
  description    = "reCAPTCHA v3 Threshold"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-captchaThreshold"
  type           = "string"
  value          = "${var.davinci_variable_gv-captchaThreshold}"
}
resource "davinci_variable" "gv-reCaptcha" {
  context        = "company"
  description    = "Determines whether reCAPTCHA is enabled"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-reCaptcha"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-reCaptcha}"
}
resource "davinci_variable" "gv-captchaV3SiteKey" {
  context        = "company"
  description    = "reCAPTCHA v3 Site Key"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-captchaV3SiteKey"
  type           = "string"
  value          = "${var.davinci_variable_gv-captchaV3SiteKey}"
}
resource "davinci_variable" "gv-autoEnrollEmailMFA" {
  context        = "company"
  description    = "Determins whether email should be auto enrolled in MFA"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-autoEnrollEmailMFA"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-autoEnrollEmailMFA}"
}
resource "davinci_variable" "gv-agreement" {
  context        = "company"
  description    = ""
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-agreement"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-agreement}"
}
resource "davinci_variable" "gv-verifyPolicyId" {
  context        = "company"
  description    = "PingOne Verify Policy ID"
  environment_id = var.pingone_environment_master_flow_environment_id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-verifyPolicyId"
  type           = "boolean"
  value          = var.pingone_verify_policy_default_id
}
