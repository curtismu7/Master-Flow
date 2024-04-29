#########################
#  DaVinci Connections  #
#########################

data "davinci_connections" "read_connections" {
  environment_id = pingone_environment.master_flow_environment.id

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
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Annotation"
}

resource "davinci_connection" "Challenge" {
  connector_id   = "challengeConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Challenge"
}

resource "davinci_connection" "Error-Message" {
  connector_id   = "errorConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Error Message"
}

resource "davinci_connection" "Flow-Connector" {
  connector_id   = "flowConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Flow Connector"
}

resource "davinci_connection" "Functions" {
  connector_id   = "functionsConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Functions"
}

resource "davinci_connection" "Http" {
  connector_id   = "httpConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Http"
}

resource "davinci_connection" "Node" {
  connector_id   = "nodeConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Teleport"
}

resource "davinci_connection" "PingOne" {
  connector_id   = "pingOneSSOConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne"

  property {
    name  = "clientId"
    value = pingone_application.dv_worker_app.oidc_options[0].client_id
  }

  property {
    name  = "clientSecret"
    value = pingone_application.dv_worker_app.oidc_options[0].client_secret
  }

  property {
    name  = "envId"
    value = pingone_environment.master_flow_environment.id
  }

  property {
    name  = "region"
    value = var.davinci_connection_PingOne_region
  }
}

resource "davinci_connection" "PingOne-Authentication" {
  connector_id   = "pingOneAuthenticationConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne Authentication"
}

resource "davinci_connection" "PingOne-MFA" {
  connector_id   = "pingOneMfaConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne MFA"

  property {
    name  = "clientId"
    value = pingone_application.dv_worker_app.oidc_options[0].client_id
  }

  property {
    name  = "clientSecret"
    value = pingone_application.dv_worker_app.oidc_options[0].client_secret
  }

  property {
    name  = "envId"
    value = pingone_environment.master_flow_environment.id
  }

  property {
    name  = "region"
    value = var.davinci_connection_PingOne_region
  }
}

resource "davinci_connection" "PingOne-Authorize" {
  connector_id   = "pingOneAuthorizeConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne Authorize"

  property {
    name  = "clientId"
    value = pingone_application.dv_worker_app.oidc_options[0].client_id
  }

  property {
    name  = "clientSecret"
    value = pingone_application.dv_worker_app.oidc_options[0].client_secret
  }

  property {
    name  = "endpointURL"
    value = ""
  }
}

resource "davinci_connection" "PingOne-Notifications" {
  connector_id   = "notificationsConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne Notifications"

  property {
    name  = "clientId"
    value = pingone_application.dv_worker_app.oidc_options[0].client_id
  }

  property {
    name  = "clientSecret"
    value = pingone_application.dv_worker_app.oidc_options[0].client_secret
  }

  property {
    name  = "envId"
    value = pingone_environment.master_flow_environment.id
  }

  property {
    name  = "region"
    value = var.davinci_connection_PingOne_region
  }
}

resource "davinci_connection" "PingOne-Protect" {
  connector_id   = "pingOneRiskConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne Protect"

  property {
    name  = "clientId"
    value = pingone_application.dv_worker_app.oidc_options[0].client_id
  }

  property {
    name  = "clientSecret"
    value = pingone_application.dv_worker_app.oidc_options[0].client_secret
  }

  property {
    name  = "envId"
    value = pingone_environment.master_flow_environment.id
  }

  property {
    name  = "region"
    value = var.davinci_connection_PingOne_region
  }
}

resource "davinci_connection" "PingOne-Verify" {
  connector_id   = "pingOneVerifyConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne Verify"
}

resource "davinci_connection" "Token-Management" {
  connector_id   = "skOpenIdConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Token Management"
}

resource "davinci_connection" "User-Policy" {
  connector_id   = "userPolicyConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "User Policy"
}

resource "davinci_connection" "Variables" {
  connector_id   = "variablesConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Variables"
}



#######################
#  DaVinci Variables  #
#######################

resource "davinci_variable" "CodeSentMsg" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "CodeSentMsg"
  type           = "string"
}

resource "davinci_variable" "IsActionReg" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "IsActionReg"
  type           = "boolean"
}

resource "davinci_variable" "adminMessage" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "adminMessage"
  type           = "string"
}

resource "davinci_variable" "availableQuestions" {
  context        = "flowInstance"
  description    = "Available questions in JSON format for Q&A"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "availableQuestions"
  type           = "object"
}
/*
resource "davinci_variable" "availableQuestions_2" {
  context        = "company"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "availableQuestions"
  type           = "object"
  value          = "${var.davinci_variable_availableQuestions_2}"

}
*/
resource "davinci_variable" "buttonValueDeviceId" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "buttonValueDeviceId"
  type           = "string"
}

resource "davinci_variable" "canChangeDevice" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "canChangeDevice"
  type           = "boolean"
}

resource "davinci_variable" "companyName" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "companyName"
  type           = "string"
}

resource "davinci_variable" "deviceCount" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "deviceCount"
  type           = "number"
}

resource "davinci_variable" "gotoLogin" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gotoLogin"
  type           = "boolean"
}

resource "davinci_variable" "gv-QA-On" {
  context        = "company"
  description    = "Determines if KBA (Question and Answer) is turned on for Forgot password"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-QA-On"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-QA-On}"
}

resource "davinci_variable" "gv-allowPasswordless" {
  context        = "company"
  description    = "This shows both Password and passwordless button for sign in"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-allowPasswordless"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-allowPasswordless}"
}


resource "davinci_variable" "gv-mfaOnHighRisk" {
  context        = "company"
  description    = "MFA is run when PingOne Risk on High"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-mfaOnHighRisk"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-mfaOnHighRisk}"
}

resource "davinci_variable" "gv-riskScreenDisplay" {
  context        = "company"
  description    = "This shows a screen the scores returned by PingOne risk during authentication"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-riskScreenDisplay"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-riskScreenDisplay}"
}

resource "davinci_variable" "gv-fakeLevel" {
  context        = "company"
  description    = "This tells the flow to use the gv-riskLevel variable for its score."
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-fakeLevel"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-mfaOnHighRisk}"
}


resource "davinci_variable" "gv-runVerifyUserRegistration" {
  context        = "company"
  description    = "This allows you to run PingOne verify during the registration process"
  environment_id = pingone_environment.master_flow_environment.id
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
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-azureLogin"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-azureLogin}"
}

resource "davinci_variable" "gv-companyLogo" {
  context        = "company"
  description    = "URL for company logo, so easy to change on Sign in window"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-companyLogo"
  type           = "string"
  value          = "${var.davinci_variable_gv-companyLogo}"
}

resource "davinci_variable" "gv-companyName" {
  context        = "company"
  description    = "Used so you can easily change company Name on sign in window"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-companyName"
  type           = "string"
  value          = "${var.davinci_variable_gv-companyName}"
}

resource "davinci_variable" "gv-consent" {
  context        = "company"
  description    = "Consent (agreements in PingOne)"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-consent"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-consent}"
}

resource "davinci_variable" "gv-deviceManagement" {
  context        = "company"
  description    = "This adds a device management page to the flow, allowing you to delete/rename/set default for MFA devices"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-deviceManagement"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-deviceManagement}"
}

resource "davinci_variable" "gv-facebookLogin" {
  context        = "company"
  description    = "Determine if Facebook is available"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-facebookLogin"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-facebookLogin}"
}

resource "davinci_variable" "gv-facebookExternalIdpId" {

  context        = "company"
  description    = "The ID of the Facebook External IDP"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-facebookExternalIdpId"
  type           = "string"
  value          = var.davinci_variable_gv-facebookLogin == "true" ? "${pingone_identity_provider.facebook[0].id}" : "N/A"
}

resource "davinci_variable" "gv-forcePasswordless" {
  context        = "company"
  description    = "This will only allow you to login with Passwordless"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-forcePasswordless"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-forcePasswordless}"
}

resource "davinci_variable" "gv-forgotPasswordDisplay" {
  context        = "company"
  description    = "Determines if to show Forgot Password on sign in window"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "false"
  name           = "gv-forgotPasswordDisplay"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-forgotPasswordDisplay}"
}

resource "davinci_variable" "gv-forgotUsernameDisplay" {
  context        = "company"
  description    = "Determines if to show forgot username on sign in window"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "false"
  name           = "gv-forgotUsernameDisplay"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-forgotUsernameDisplay}"
}

resource "davinci_variable" "gv-githubLogin" {
  context        = "company"
  description    = "Determine if Github is available"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-githubLogin"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-githubLogin}"
}

resource "davinci_variable" "gv-googleLogin" {
  context        = "company"
  description    = "Determine if Google is available"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-googleLogin"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-googleLogin}"
}

resource "davinci_variable" "gv-googleExternalIdpId" {

  context        = "company"
  description    = "The ID of the Google External IDP"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-googleExternalIdpId"
  type           = "string"
  value          = var.davinci_variable_gv-googleLogin == "true" ? "${pingone_identity_provider.google[0].id}" : "N/A"
}

resource "davinci_variable" "gv-inlineMFAOn" {
  context        = "company"
  description    = "Determines if to run MFA for inline registration"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-inlineMFAOn"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-inlineMFAOn}"
}

resource "davinci_variable" "gv-mfa-on" {
  context        = "company"
  description    = "Turn on and off MFA, This is required for all P1MFA options"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-mfa-on"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-mfa-on}"
}

resource "davinci_variable" "gv-p1AgreementId" {
  context        = "company"
  description    = "PingOne Agreement Id"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-p1AgreementId"
  type           = "string"
  value          = pingone_agreement.master_flow_agreement.id
}

resource "davinci_variable" "gv-p1PasswordPolicy" {
  context        = "company"
  description    = "Password Policy, pulled from PingOne"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-p1PasswordPolicy"
  type           = "object"
  value          = replace(replace(replace(jsonencode({
                      "id": data.pingone_password_policy.standard_password_policy.id,
                      "environment": { "id": data.pingone_password_policy.standard_password_policy.environment_id },
                      "name": data.pingone_password_policy.standard_password_policy.name,
                      "description": data.pingone_password_policy.standard_password_policy.description,
                      "excludesProfileData": data.pingone_password_policy.standard_password_policy.exclude_profile_data,
                      "notSimilarToCurrent": data.pingone_password_policy.standard_password_policy.not_similar_to_current,
                      "excludesCommonlyUsed": data.pingone_password_policy.standard_password_policy.exclude_commonly_used_passwords,
                      "maxAgeDays": 22,
                      "history": { "count": data.pingone_password_policy.standard_password_policy.password_history[0].prior_password_count, "retentionDays": data.pingone_password_policy.standard_password_policy.password_history[0].retention_days },
                      "lockout": { "failureCount": data.pingone_password_policy.standard_password_policy.account_lockout[0].fail_count, "durationSeconds": data.pingone_password_policy.standard_password_policy.account_lockout[0].duration_seconds },
                      "length": { "min": data.pingone_password_policy.standard_password_policy.password_length[0].min, "max": data.pingone_password_policy.standard_password_policy.password_length[0].max },
                      "minCharacters": {
                        "~!@#$%^&*()-_=+[]{}|;:,.<>/?": data.pingone_password_policy.standard_password_policy.min_characters[0].special_characters,
                        "0123456789": data.pingone_password_policy.standard_password_policy.min_characters[0].numeric,
                        "ABCDEFGHIJKLMNOPQRSTUVWXYZ": data.pingone_password_policy.standard_password_policy.min_characters[0].alphabetical_uppercase,
                        "abcdefghijklmnopqrstuvwxyz": data.pingone_password_policy.standard_password_policy.min_characters[0].alphabetical_lowercase
                      },
                      "populationCount": data.pingone_password_policy.standard_password_policy.population_count,
                      "default": true
                    }), "\\u0026", "&"), "\\u003c", "<"), "\\u003e", ">")
}

resource "davinci_variable" "gv-p1PopulationId" {
  context        = "company"
  description    = "Population ID from PingOne"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-p1PopulationId"
  type           = "string"
  value          = data.pingone_population.default_population.id
}

resource "davinci_variable" "gv-passwordlessAllowedTypes" {
  context        = "company"
  description    = "JSON showing allowed types for Passwordless"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-passwordlessAllowedTypes"
  type           = "object"
  value          = "${var.davinci_variable_gv-passwordlessAllowedTypes}"
}

resource "davinci_variable" "gv-riskLevel" {
  context        = "company"
  description    = "Used to control the Risk Level for Demos"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-riskLevel"
  type           = "string"
  value          = "${var.davinci_variable_gv-riskLevel}"
}

resource "davinci_variable" "gv-runMFAforForgot" {
  context        = "company"
  description    = "MFA and OTP for forgot password (drop down)"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runMFAforForgot"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runMFAforForgot}"
}

resource "davinci_variable" "gv-runMFAforLogin" {
  context        = "company"
  description    = "Run PingOne MFA after username login"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runMFAforLogin"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runMFAforLogin}"
}

resource "davinci_variable" "gv-runMFAforSocial" {
  context        = "company"
  description    = "Decide to run MFA after social login"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "false"
  name           = "gv-runMFAforSocial"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runMFAforSocial}"
}

resource "davinci_variable" "gv-runPasswordExpire" {
  context        = "company"
  description    = "Determines if we should run Password Expiration flow "
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runPasswordExpire"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runPasswordExpire}"
}

resource "davinci_variable" "gv-runProtect" {
  context        = "company"
  description    = "Run PingOne Protect subflow"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runProtect"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runProtect}"
}

resource "davinci_variable" "gv-runVerifyforHighRisk" {
  context        = "company"
  description    = "If you want to run Verify when user is a High Risk"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runVerifyforHighRisk"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runVerifyforHighRisk}"
}

resource "davinci_variable" "gv-standardForgotPassword" {
  context        = "company"
  description    = "Turns on Standard forgot password - Just MFA"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-standardForgotPassword"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-standardForgotPassword}"
}

resource "davinci_variable" "gv-isDeviceManagement" {
  context        = "company"
  description    = "Turns on the new device management page, allowing dev management in the middle of the flow"
  environment_id = pingone_environment.master_flow_environment.id
  mutable        = "true"
  name           = "gv-isDeviceManagement"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-isDeviceManagement}"
}

resource "davinci_variable" "gv-webAuthnSupport" {
  context        = "company"
  description    = "Set webauthn to \"platform\" or \"cross-platform\""
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-webAuthnSupport"
  type           = "string"
  value          = "${var.davinci_variable_gv-webAuthnSupport}"
}

resource "davinci_variable" "origin" {
  context        = "company"
  description    = "FIDO2 origin"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "origin"
  type           = "string"
  value          = "${var.davinci_variable_origin}"
}

resource "davinci_variable" "p1AgreementId" {
  context        = "flowInstance"
  description    = "PingOne Agreement ID"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1AgreementId"
  type           = "string"
}

resource "davinci_variable" "p1AuthMethods" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1AuthMethods"
  type           = "string"
}

resource "davinci_variable" "p1AuthenticationMethods" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1AuthenticationMethods"
  type           = "string"
}

resource "davinci_variable" "p1DeviceAuthenticationId" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1DeviceAuthenticationId"
  type           = "string"
}

resource "davinci_variable" "p1DeviceId" {
  context        = "flowInstance"
  description    = "local device ID variable to manage the most current user device being used"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1DeviceId"
  type           = "string"
}

resource "davinci_variable" "p1UserId" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1UserId"
  type           = "string"
}

resource "davinci_variable" "populationId" {
  context        = "flowInstance"
  description    = "PingOne Population Id"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "populationId"
  type           = "string"
  value          = data.pingone_population.default_population.id
}

resource "davinci_variable" "preppedDevices" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "preppedDevices"
  type           = "object"
}

resource "davinci_variable" "publicKeyCredentialRequestOptions" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "publicKeyCredentialRequestOptions"
  type           = "string"
}

resource "davinci_variable" "relyingParty" {
  context        = "company"
  description    = "Relying Party for FIDO2"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "relyingParty"
  type           = "string"
  value          = "${var.davinci_variable_relyingParty}"
}

resource "davinci_variable" "relyingParty_2" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "relyingParty"
  type           = "string"
}

resource "davinci_variable" "rpid" {
  context        = "company"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "rpid"
  type           = "string"
  value          = "${var.davinci_variable_rpid}"
}

resource "davinci_variable" "rpid_2" {
  context        = "flowInstance"
  description    = "Relying Party ID"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "rpid"
  type           = "string"
}

resource "davinci_variable" "selectedDeviceId" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "selectedDeviceId"
  type           = "string"
}

resource "davinci_variable" "showCodeSentMsg" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "showCodeSentMsg"
  type           = "boolean"
}

resource "davinci_variable" "showRegButton" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "showRegButton"
  type           = "boolean"
  value          = "${var.davinci_variable_showRegButton}"
}

resource "davinci_variable" "showSettings" {
  context        = "flowInstance"
  description    = "Internal variable"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "showSettings"
  type           = "boolean"
}

resource "davinci_variable" "stopSign" {
  context        = "flowInstance"
  description    = "Stop sign Image"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "stopSign"
  type           = "string"
  value          = "${var.davinci_variable_stopSign}"
}

resource "davinci_variable" "gv-captchaThreshold" {
  context        = "company"
  description    = "reCAPTCHA v3 Threshold"
  environment_id = pingone_environment.master_flow_environment.id
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
  environment_id = pingone_environment.master_flow_environment.id
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
  environment_id = pingone_environment.master_flow_environment.id
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
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-autoEnrollEmailMFA"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-autoEnrollEmailMFA}"
}

resource "davinci_variable" "gv-agreement" {
  context        = "company"
  description    = "Consent (agreement in PingOne)"
  environment_id = pingone_environment.master_flow_environment.id
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
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-verifyPolicyId"
  type           = "string"
  value          = data.pingone_verify_policy.default_policy.id
}

resource "davinci_variable" "gv-progressiveProfilingAuthentication" {
  context        = "company"
  description    = "Turns on progressive profile during Authentication"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-progressiveProfilingAuthentication"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-progressiveProfilingAuthentication}"
}

resource "davinci_variable" "gv-progressiveProfilingRegistration" {
  context        = "company"
  description    = "Turns on progressive profile during Registration"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-progressiveProfilingRegistration"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-progressiveProfilingRegistration}"
}

resource "davinci_variable" "gv-magicLinkUserRegistration" {
  context        = "company"
  description    = "Use Magic link to confirm user during registration instead of PingOne OTP"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-magicLinkUserRegistration"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-magicLinkUserRegistration}"
}

resource "davinci_variable" "gv-notificationPolicyId" {
  context        = "company"
  description    = "PingOne Notification Policy Id"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-notificationPolicyId"
  type           = "string"
  value          = pingone_notification_policy.master_flow_notification_policy.id
}

resource "davinci_variable" "gv-pingOneAuthorize" {
  context        = "company"
  description    = "Turns on simple PingOne Authorize flow"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-pingOneAuthorize"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-pingOneAuthorize}"
}



#########################
#  DaVinci Application  #
#########################

resource "davinci_application" "PingOne-SSO-Connection" {
  api_key_enabled = "true"
  environment_id  = pingone_environment.master_flow_environment.id
  name            = "PingOne SSO Connection"

  oauth {
    enabled = "true"

    values {
      allowed_grants                = ["authorizationCode"]
      allowed_scopes                = ["openid", "profile"]
      enabled                       = "true"
      enforce_signed_request_openid = "false"
      redirect_uris                 = ["https://auth.pingone.com/${pingone_environment.master_flow_environment.id}/rp/callback/openid_connect"]
    }
  }
}

resource "davinci_application_flow_policy" "PingOne-SSO-Flow-Policy" {
  environment_id = pingone_environment.master_flow_environment.id
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
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Custom Security Question and Answer Registration subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Davinci-Custom-Magic-Link-registration-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Challenge.id
    name = davinci_connection.Challenge.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
  }

  connection_link {
    id   = davinci_connection.PingOne-Notifications.id
    name = davinci_connection.PingOne-Notifications.name
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Davinci Custom Magic Link registration subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Davinci-Custom-Magic-Link-Subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Challenge.id
    name = davinci_connection.Challenge.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne-Notifications.id
    name = davinci_connection.PingOne-Notifications.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }
  
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Davinci Custom Magic Link Subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-MFA-Authentication-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne MFA Authentication subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-Subflow.id
    name = davinci_flow.PingOne-Davinci-Custom-Magic-Link-Subflow.name
    replace_import_subflow_id = "58702ba5c9b10727b13a9788a3e653a0"
  }

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Management-Subflow.id
    name = davinci_flow.PingOne-MFA-Device-Management-Subflow.name
    replace_import_subflow_id = "34433ccb95ddf27eb63b65590abf6937"
  }

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
    name = davinci_flow.PingOne-MFA-Device-Registration-subflow.name
    replace_import_subflow_id = "c27a63e07297a1815df9e85ea86de0f9"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-MFA-Device-Management-Subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne MFA Device Management Subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
    name = davinci_flow.PingOne-MFA-Device-Registration-subflow.name
    replace_import_subflow_id = "c27a63e07297a1815df9e85ea86de0f9"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Protect-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.PingOne-Protect.id
    name = davinci_connection.PingOne-Protect.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Protect subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = davinci_flow.PingOne-MFA-Authentication-subflow.name
    replace_import_subflow_id = "49a3fbbfac4050f9c558aaae75bd2a36"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Verify-subflow.id
    name = davinci_flow.PingOne-Verify-subflow.name
    replace_import_subflow_id = "07e397931703b2dcd18a2e929dee0170"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Account-Verification-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Account Verification subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Authentication-MASTER" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne-Authentication.id
    name = davinci_connection.PingOne-Authentication.name
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Authentication MASTER.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = davinci_flow.PingOne-MFA-Authentication-subflow.name
    replace_import_subflow_id = "49a3fbbfac4050f9c558aaae75bd2a36"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-User-Registration-subflow.id
    name = davinci_flow.PingOne-SSO-User-Registration-subflow.name
    replace_import_subflow_id = "997164e38f8aeef0d9933aba811983a3"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-User-Registration-subflow.id
    name = davinci_flow.PingOne-SSO-User-Registration-subflow.name
    replace_import_subflow_id = "cbf38f8b255125cc7d82137a6c21b121"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Protect-subflow.id
    name = davinci_flow.PingOne-Protect-subflow.name
    replace_import_subflow_id = "2572ed744b282b38cd33051133f29a50"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Account-Verification-subflow.id
    name = davinci_flow.PingOne-SSO-Account-Verification-subflow.name
    replace_import_subflow_id = "e8c0944e0abc072db747d56275c58a0c"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Change-Password-subflow.id
    name = davinci_flow.PingOne-SSO-Change-Password-subflow.name
    replace_import_subflow_id = "e110a8dd7f48d210b0a9e39f85fe9e3f"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Forgot-Password-subflow.id
    name = davinci_flow.PingOne-SSO-Forgot-Password-subflow.name
    replace_import_subflow_id = "1b9081502aff301aaca80f54ffcb87bc"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Forgot-Username-subflow.id
    name = davinci_flow.PingOne-SSO-Forgot-Username-subflow.name
    replace_import_subflow_id = "af9278e3fddea4c033baf5e8cd24b647"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Password-Expiration-subflow.id
    name = davinci_flow.PingOne-SSO-Password-Expiration-subflow.name
    replace_import_subflow_id = "60cc69e9d92a86d35a31ad852fb9fffa"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.id
    name = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.name
    replace_import_subflow_id = "469b5d714ce9beae23c57c7a5d5ba99d"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Social-External-IdP-authentication-subflow.id
    name = davinci_flow.PingOne-SSO-Social-External-IdP-authentication-subflow.name
    replace_import_subflow_id = "21ffbecef7b49304333154108e0e0c18"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Authorize-subflow.id
    name = davinci_flow.PingOne-Authorize-subflow.name
    replace_import_subflow_id = "c9460be259af6db2bf03a021d2e8167e"
  }

  subflow_link {
    id   = davinci_flow.PingOne-reCAPTCHA-v3-subflow.id
    name = davinci_flow.PingOne-reCAPTCHA-v3-subflow.name
    replace_import_subflow_id = "cf93627a9eecea11e7ac9111c652a14e"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Change-Password-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Change Password subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Consent-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Consent subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Forgot-Password-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Forgot Password subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = davinci_flow.PingOne-MFA-Authentication-subflow.name
    replace_import_subflow_id = "49a3fbbfac4050f9c558aaae75bd2a36"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Security-Question-and-Answer-Validation-subflow.id
    name = davinci_flow.PingOne-Security-Question-and-Answer-Validation-subflow.name
    replace_import_subflow_id = "e74d2c58525a28834b4d828ce66d7294"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Forgot-Username-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.PingOne-Notifications.id
    name = davinci_connection.PingOne-Notifications.name
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Forgot Username subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Password-Expiration-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Password Expiration subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Progressive-Profiling-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Progressive Profiling subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Social-External-IdP-authentication-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
  }

  connection_link {
    id   = davinci_connection.PingOne-Authentication.id
    name = davinci_connection.PingOne-Authentication.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Social External IdP authentication subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = davinci_flow.PingOne-MFA-Authentication-subflow.name
    replace_import_subflow_id = "49a3fbbfac4050f9c558aaae75bd2a36"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Protect-subflow.id
    name = davinci_flow.PingOne-Protect-subflow.name
    replace_import_subflow_id = "20ed625295bdce54ea0c8868bc13ae57"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Consent-subflow.id
    name = davinci_flow.PingOne-SSO-Consent-subflow.name
    replace_import_subflow_id = "acabff5c7a1c870245600e440e9b9c2b"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-User-Registration-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO User Registration subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-Custom-Security-Question-and-Answer-Registration-subflow.id
    name = davinci_flow.PingOne-Custom-Security-Question-and-Answer-Registration-subflow.name
    replace_import_subflow_id = "4703368e87b0425c9fb0b61a040c3b13"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Protect-subflow.id
    name = davinci_flow.PingOne-Protect-subflow.name
    replace_import_subflow_id = "2572ed744b282b38cd33051133f29a50"
  }

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
    name = davinci_flow.PingOne-MFA-Device-Registration-subflow.name
    replace_import_subflow_id = "c27a63e07297a1815df9e85ea86de0f9"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Account-Verification-subflow.id
    name = davinci_flow.PingOne-SSO-Account-Verification-subflow.name
    replace_import_subflow_id = "e8c0944e0abc072db747d56275c58a0c"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Consent-subflow.id
    name = davinci_flow.PingOne-SSO-Consent-subflow.name
    replace_import_subflow_id = "acabff5c7a1c870245600e440e9b9c2b"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.id
    name = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.name
    replace_import_subflow_id = "469b5d714ce9beae23c57c7a5d5ba99d"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Verify-subflow.id
    name = davinci_flow.PingOne-Verify-subflow.name
    replace_import_subflow_id = "5290cf060e588661efaf5f052faedd9c"
  }

  subflow_link {
    id   = davinci_flow.PingOne-reCAPTCHA-v3-subflow.id
    name = davinci_flow.PingOne-reCAPTCHA-v3-subflow.name
    replace_import_subflow_id = "cf93627a9eecea11e7ac9111c652a14e"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.id
    name = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.name
    replace_import_subflow_id = "af65b0426d5e2d4d1ea93502d35f82ed"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}


resource "davinci_flow" "PingOne-Security-Question-and-Answer-Validation-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Security Question and Answer Validation subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

/*
resource "davinci_flow" "PingOne-Session-Main-Flow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne-Authentication.id
    name = davinci_connection.PingOne-Authentication.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Session Main Flow.json")}"
/*
  subflow_link {
    id   = davinci_flow.PingOne-Sign-On-with-Registration-Password-Reset-and-Recovery.id
    name = "PingOne Sign On with Registration, Password Reset and Recovery"
  }
* /
  depends_on = [
    data.davinci_connections.read_connections
  ]
}



resource "davinci_flow" "PingOne-Sign-On-with-Registration-Password-Reset-and-Recovery" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Sign On with Registration, Password Reset and Recovery.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}*/

resource "davinci_flow" "PingOne-Verify-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.PingOne-Verify.id
    name = davinci_connection.PingOne-Verify.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Verify subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-reCAPTCHA-v3-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne reCAPTCHA v3  subflow.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Authorize-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }
  
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
  }

  connection_link {
    id   = davinci_connection.PingOne-Authorize.id
    name = davinci_connection.PingOne-Authorize.name
  }

  connection_link {
    id   = davinci_connection.PingOne-Verify.id
    name = davinci_connection.PingOne-Verify.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Authorize Flow subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = davinci_flow.PingOne-MFA-Authentication-subflow.name
    replace_import_subflow_id = "49a3fbbfac4050f9c558aaae75bd2a36"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Auto-enroll-user-in-email" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Auto enroll user in email.json")}"

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-MFA-Device-Registration-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
  }

  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne MFA Device Registration subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.id
    name = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.name
    replace_import_subflow_id = "46ebc87053d586dbfabe6cb677162c6d"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
  #subflow_link {
  #  id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
  #  name = "PingOne MFA Authentication subflow"
  #}
}
