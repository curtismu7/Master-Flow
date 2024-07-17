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
    value = pingone_application.dv_worker_app.oidc_options.id
  }

  property {
    name  = "clientSecret"
    value = pingone_application_secret.dv_worker_app.secret
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
    value = pingone_application.dv_worker_app.oidc_options.id
  }

  property {
    name  = "clientSecret"
    value = pingone_application_secret.dv_worker_app.secret
  }

  property {
    name  = "envId"
    value = pingone_environment.master_flow_environment.id
  }

  property {
    name  = "region"
    value = var.davinci_connection_PingOne_region
  }

  property {
    name  = "policyId"
    value = pingone_mfa_device_policy.master_flow_mfa_device_policy.id
  }
}

resource "davinci_connection" "PingOne-Authorize" {
  connector_id   = "pingOneAuthorizeConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne Authorize"

  property {
    name  = "clientId"
    value = pingone_application.dv_worker_app.oidc_options.id
  }

  property {
    name  = "clientSecret"
    value = pingone_application_secret.dv_worker_app.secret
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
    value = pingone_application.dv_worker_app.oidc_options.id
  }

  property {
    name  = "clientSecret"
    value = pingone_application_secret.dv_worker_app.secret
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
    value = pingone_application.dv_worker_app.oidc_options.id
  }

  property {
    name  = "clientSecret"
    value = pingone_application_secret.dv_worker_app.secret
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

  property {
    name  = "clientId"
    value = pingone_application.dv_worker_app.oidc_options.id
  }

  property {
    name  = "clientSecret"
    value = pingone_application_secret.dv_worker_app.secret
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
  type           = "boolean"
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
  value = replace(replace(replace(jsonencode({
    "id" : data.pingone_password_policy.standard_password_policy.id,
    "environment" : { "id" : data.pingone_password_policy.standard_password_policy.environment_id },
    "name" : data.pingone_password_policy.standard_password_policy.name,
    "description" : data.pingone_password_policy.standard_password_policy.description,
    "excludesProfileData" : data.pingone_password_policy.standard_password_policy.excludes_profile_data,
    "notSimilarToCurrent" : data.pingone_password_policy.standard_password_policy.not_similar_to_current,
    "excludesCommonlyUsed" : data.pingone_password_policy.standard_password_policy.excludes_commonly_used_passwords,
    "maxAgeDays" : 22,
    "history" : { "count" : data.pingone_password_policy.standard_password_policy.history.count, "retentionDays" : data.pingone_password_policy.standard_password_policy.history.retention_days },
    "lockout" : { "failureCount" : data.pingone_password_policy.standard_password_policy.lockout.failure_count, "durationSeconds" : data.pingone_password_policy.standard_password_policy.lockout.duration_seconds },
    "length" : { "min" : data.pingone_password_policy.standard_password_policy.length.min, "max" : data.pingone_password_policy.standard_password_policy.length.max },
    "minCharacters" : {
      "~!@#$%^&*()-_=+[]{}|;:,.<>/?" : data.pingone_password_policy.standard_password_policy.min_characters.special_characters,
      "0123456789" : data.pingone_password_policy.standard_password_policy.min_characters.numeric,
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ" : data.pingone_password_policy.standard_password_policy.min_characters.alphabetical_uppercase,
      "abcdefghijklmnopqrstuvwxyz" : data.pingone_password_policy.standard_password_policy.min_characters.alphabetical_lowercase
    },
    "populationCount" : data.pingone_password_policy.standard_password_policy.population_count,
    "default" : true
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
  value          = pingone_population_default.default_population.id
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
resource "davinci_variable" "gv-registerAnotherDevice" {
  context        = "company"
  description    = "Tells the flow to allow the user to add another device at the end of the Registration - Set to false to see the screen"
  environment_id = pingone_environment.master_flow_environment.id
  mutable        = "true"
  name           = "gv-registerAnotherDevice"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-registerAnotherDevice}"
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
  value          = pingone_population_default.default_population.id
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

resource "davinci_variable" "gv-mfaPolicyId" {
  context        = "company"
  description    = "PingOne MFA Policy ID"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-mfaPolicyId"
  type           = "string"
  value          = pingone_mfa_device_policy.master_flow_mfa_device_policy.id
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

# Everything below this point is autogenerated with Github Actions.
# If you find an issue with something below here,
# please reach out to @Kyle Moorehead, @curtis or @CJ Muir on Slack.

###################
#  Davinci Flows  #
###################

resource "davinci_flow" "PingOne-Authorize-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Authorize Flow subflow.json")}"

  connection_link {
    id   = davinci_connection.PingOne-Authorize.id
    name = davinci_connection.PingOne-Authorize.name
    replace_import_connection_id = "7b2e39fb332e26e8a9035dc92e733ae3"
  }
  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = davinci_flow.PingOne-MFA-Authentication-subflow.name
    replace_import_subflow_id = "48bc5d1f074b32efc02f09dfe91f32cf"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Auto-enroll-user-in-email" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Auto enroll user in email.json")}"

  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Custom-Security-Question-and-Answer-Registration-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Custom Security Question and Answer Registration subflow.json")}"

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Davinci-Custom-Magic-Link-registration-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Davinci Custom Magic Link registration subflow.json")}"

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }
  connection_link {
    id   = davinci_connection.Challenge.id
    name = davinci_connection.Challenge.name
    replace_import_connection_id = "94cb18cc8ee6ddaf28e881b16637aec6"
  }
  connection_link {
    id   = davinci_connection.PingOne-Notifications.id
    name = davinci_connection.PingOne-Notifications.name
    replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Davinci-Custom-Magic-Link-Subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Davinci Custom Magic Link Subflow.json")}"

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }
  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
    name = davinci_flow.PingOne-MFA-Device-Registration-subflow.name
    replace_import_subflow_id = "b7e12799623b33e31e95c9e6217e2160"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-MFA-Authentication-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne MFA Authentication subflow.json")}"

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
    name = davinci_flow.PingOne-MFA-Device-Registration-subflow.name
    replace_import_subflow_id = "c27a63e07297a1815df9e85ea86de0f9"
  }
  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Management-Subflow.id
    name = davinci_flow.PingOne-MFA-Device-Management-Subflow.name
    replace_import_subflow_id = "34433ccb95ddf27eb63b65590abf6937"
  }
  subflow_link {
    id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-Subflow.id
    name = davinci_flow.PingOne-Davinci-Custom-Magic-Link-Subflow.name
    replace_import_subflow_id = "58702ba5c9b10727b13a9788a3e653a0"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-MFA-Device-Management-Subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne MFA Device Management Subflow.json")}"

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }
  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
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

resource "davinci_flow" "PingOne-MFA-Device-Registration-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne MFA Device Registration subflow.json")}"

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }

  /*subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = davinci_flow.PingOne-MFA-Authentication-subflow.name
    replace_import_subflow_id = "48bc5d1f074b32efc02f09dfe91f32cf"
  }*/
  subflow_link {
    id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.id
    name = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.name
    replace_import_subflow_id = "d3308b9803c90739050ec82f4cb60bae"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Protect-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Protect subflow.json")}"

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.PingOne-Protect.id
    name = davinci_connection.PingOne-Protect.name
    replace_import_connection_id = "292873d5ceea806d81373ed0341b5c88"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = davinci_flow.PingOne-MFA-Authentication-subflow.name
    replace_import_subflow_id = "48bc5d1f074b32efc02f09dfe91f32cf"
  }
  subflow_link {
    id   = davinci_flow.PingOne-Verify-subflow.id
    name = davinci_flow.PingOne-Verify-subflow.name
    replace_import_subflow_id = "c5876e0cf832ac128c4c23e8ffa4a57c"
  }
  subflow_link {
    id   = davinci_flow.PingOne-Verify-subflow.id
    name = davinci_flow.PingOne-Verify-subflow.name
    replace_import_subflow_id = "47a078fab415a28277aa766a2b22a8a5"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-reCAPTCHA-v3-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne reCAPTCHA v3 subflow.json")}"

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Security-Question-and-Answer-Validation-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Security Question and Answer Validation subflow.json")}"

  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Account-Verification-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Account Verification subflow.json")}"

  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Authentication-MASTER" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Authentication MASTER.json")}"

  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }
  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.PingOne-Authentication.id
    name = davinci_connection.PingOne-Authentication.name
    replace_import_connection_id = "c3e6a164bde107954e93f5c09f0c8bce"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Forgot-Password-subflow.id
    name = davinci_flow.PingOne-SSO-Forgot-Password-subflow.name
    replace_import_subflow_id = "603f36ab38f71c2f4486254bff0aa9f5"
  }
  subflow_link {
    id   = davinci_flow.PingOne-SSO-User-Registration-subflow.id
    name = davinci_flow.PingOne-SSO-User-Registration-subflow.name
    replace_import_subflow_id = "f632c91a1c87e301d5314fae164642bd"
  }
  subflow_link {
    id   = davinci_flow.PingOne-SSO-Forgot-Username-subflow.id
    name = davinci_flow.PingOne-SSO-Forgot-Username-subflow.name
    replace_import_subflow_id = "58cfc8965681a7ffb412898d0ef9183b"
  }
  subflow_link {
    id   = davinci_flow.PingOne-Protect-subflow.id
    name = davinci_flow.PingOne-Protect-subflow.name
    replace_import_subflow_id = "fb3ffbb66f7a24f215d3dcdba9a96f39"
  }
  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = davinci_flow.PingOne-MFA-Authentication-subflow.name
    replace_import_subflow_id = "a2814dbc43c63b8bf2e36581e2f482c2"
  }
  subflow_link {
    id   = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.id
    name = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.name
    replace_import_subflow_id = "c56cc4f0e745769dc01acf23a1350e2c"
  }
  subflow_link {
    id   = davinci_flow.PingOne-SSO-Social-External-IdP-authentication-subflow.id
    name = davinci_flow.PingOne-SSO-Social-External-IdP-authentication-subflow.name
    replace_import_subflow_id = "33cab583cb397452ea652f3364cee187"
  }
  subflow_link {
    id   = davinci_flow.PingOne-SSO-Change-Password-subflow.id
    name = davinci_flow.PingOne-SSO-Change-Password-subflow.name
    replace_import_subflow_id = "7353f7025fb710825d2f2506a2f2ccef"
  }
  subflow_link {
    id   = davinci_flow.PingOne-SSO-Account-Verification-subflow.id
    name = davinci_flow.PingOne-SSO-Account-Verification-subflow.name
    replace_import_subflow_id = "95da6eb847d0b9fa5329914322f95d65"
  }
  subflow_link {
    id   = davinci_flow.PingOne-reCAPTCHA-v3-subflow.id
    name = davinci_flow.PingOne-reCAPTCHA-v3-subflow.name
    replace_import_subflow_id = "66a015a1785eca4050e369eb8fce2ef9"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Change-Password-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Change Password subflow.json")}"

  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Consent-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Consent subflow.json")}"

  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Forgot-Password-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Forgot Password subflow.json")}"

  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }

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
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Forgot Username subflow.json")}"

  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }
  connection_link {
    id   = davinci_connection.PingOne-Notifications.id
    name = davinci_connection.PingOne-Notifications.name
    replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Password-Expiration-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Password Expiration subflow.json")}"

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Progressive-Profiling-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Progressive Profiling subflow.json")}"

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-Social-External-IdP-authentication-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Social External IdP authentication subflow.json")}"

  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.PingOne-Authentication.id
    name = davinci_connection.PingOne-Authentication.name
    replace_import_connection_id = "c3e6a164bde107954e93f5c09f0c8bce"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }
  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }

  subflow_link {
    id   = davinci_flow.PingOne-Protect-subflow.id
    name = davinci_flow.PingOne-Protect-subflow.name
    replace_import_subflow_id = "a4d75de5717184f389741fd808236995"
  }
  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = davinci_flow.PingOne-MFA-Authentication-subflow.name
    replace_import_subflow_id = "48bc5d1f074b32efc02f09dfe91f32cf"
  }
  subflow_link {
    id   = davinci_flow.PingOne-SSO-Consent-subflow.id
    name = davinci_flow.PingOne-SSO-Consent-subflow.name
    replace_import_subflow_id = "4811483307e608a793bbcd45f9a7ca31"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-SSO-User-Registration-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO User Registration subflow - With Magic Link.json")}"

  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Error-Message.id
    name = davinci_connection.Error-Message.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }
  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = davinci_connection.Flow-Connector.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }
  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = davinci_connection.PingOne-MFA.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }

  subflow_link {
    id   = davinci_flow.PingOne-SSO-Consent-subflow.id
    name = davinci_flow.PingOne-SSO-Consent-subflow.name
    replace_import_subflow_id = "ce99a39784dbea9d056da5cd4fcf8a03"
  }
  subflow_link {
    id   = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.id
    name = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.name
    replace_import_subflow_id = "a1cc3108c7ff4274ac460845ad41c187"
  }
  subflow_link {
    id   = davinci_flow.PingOne-Custom-Security-Question-and-Answer-Registration-subflow.id
    name = davinci_flow.PingOne-Custom-Security-Question-and-Answer-Registration-subflow.name
    replace_import_subflow_id = "626aa3702e06bb5ef7c4f92d8c50492a"
  }
  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
    name = davinci_flow.PingOne-MFA-Device-Registration-subflow.name
    replace_import_subflow_id = "7fd22ca59b2901b8cddf190e102d6f21"
  }
  subflow_link {
    id   = davinci_flow.PingOne-SSO-Account-Verification-subflow.id
    name = davinci_flow.PingOne-SSO-Account-Verification-subflow.name
    replace_import_subflow_id = "d4e10090d912fb7f7e8d69e088e71155"
  }
  subflow_link {
    id   = davinci_flow.PingOne-Verify-subflow.id
    name = davinci_flow.PingOne-Verify-subflow.name
    replace_import_subflow_id = "f4b43e585566ef388a0ce884c0708da5"
  }
  subflow_link {
    id   = davinci_flow.PingOne-reCAPTCHA-v3-subflow.id
    name = davinci_flow.PingOne-reCAPTCHA-v3-subflow.name
    replace_import_subflow_id = "8703ad5e60e1b4cceeacce057bb8995b"
  }
  subflow_link {
    id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.id
    name = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.name
    replace_import_subflow_id = "94c9c002b521f5ccf17e91c23770d538"
  }

  depends_on = [
    data.davinci_connections.read_connections
  ]
}

resource "davinci_flow" "PingOne-Verify-subflow" {
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Verify subflow.json")}"

  connection_link {
    id   = davinci_connection.Http.id
    name = davinci_connection.Http.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }
  connection_link {
    id   = davinci_connection.Functions.id
    name = davinci_connection.Functions.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }
  connection_link {
    id   = davinci_connection.PingOne-Verify.id
    name = davinci_connection.PingOne-Verify.name
    replace_import_connection_id = "aebcad93e7a1090d237676631e96f5ad"
  }
  connection_link {
    id   = davinci_connection.Variables.id
    name = davinci_connection.Variables.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
  connection_link {
    id   = davinci_connection.Annotation.id
    name = davinci_connection.Annotation.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }
  connection_link {
    id   = davinci_connection.Node.id
    name = davinci_connection.Node.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }
  connection_link {
    id   = davinci_connection.PingOne.id
    name = davinci_connection.PingOne.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }


  depends_on = [
    data.davinci_connections.read_connections
  ]
}