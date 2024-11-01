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
	"pingOneCredentialsConnector",
    "notificationsConnector",
    "pingOneRiskConnector",
    "pingOneVerifyConnector",
    "pingOneAuthorizeConnector",
    "variablesConnector",
    "devicePolicyConnector",
    "stringsConnector",
	"analyticsConnector"
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

resource "davinci_connection" "Flow-Analytics" {
  connector_id   = "analyticsConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Flow Analytics"
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

resource "davinci_connection" "Strings" {
  connector_id   = "stringsConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Strings"
}

resource "davinci_connection" "Device-Policy" {
  connector_id   = "devicePolicyConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Device Policy"
}

resource "davinci_connection" "PingOne" {
  connector_id   = "pingOneSSOConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne"

  property {
    name  = "clientId"
    value = pingone_application.dv_worker_app.oidc_options.client_id
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
    value = pingone_application.dv_worker_app.oidc_options.client_id
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
    name = "policyId"
    value = pingone_mfa_device_policy.master_flow_mfa_policy.id
  }
}

resource "davinci_connection" "PingOne-MFA-Passwordless" {
  connector_id   = "pingOneMfaConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne MFA - Passwordless"

  property {
    name  = "clientId"
    value = pingone_application.dv_worker_app.oidc_options.client_id
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
    name = "policyId"
    value = pingone_mfa_device_policy.master_flow_passwordless_mfa_policy.id
  }
}

resource "davinci_connection" "PingOne-Authorize" {
  connector_id   = "pingOneAuthorizeConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne Authorize"

  property {
    name  = "clientId"
    value = pingone_application.dv_worker_app.oidc_options.client_id
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
    value = pingone_application.dv_worker_app.oidc_options.client_id
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
    value = pingone_application.dv_worker_app.oidc_options.client_id
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
    value = pingone_application.dv_worker_app.oidc_options.client_id
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

resource "davinci_connection" "PingOne-Credentials" {
  connector_id   = "pingOneCredentialsConnector"
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne Credentials"

  property {
    name  = "clientId"
    value = pingone_application.dv_worker_app.oidc_options.client_id
  }

  property {
    name  = "clientSecret"
    value = pingone_application_secret.dv_worker_app.secret
  }

  property {
    name  = "digitalWalletApplicationId"
    value = pingone_digital_wallet_application.pingone_neo_demo_wallet_app.id
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

resource "davinci_variable" "disableButton" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-allowPasswordless"
  type           = "boolean"
  value          = "${var.davinci_variable_disableButton}"
}

resource "davinci_variable" "mf-configObject" {
  context        = "company"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "mf-configObject"
  type           = "object"
  value          = replace(replace(replace(jsonencode(var.davinci_variable_mf-configObject), "\\u0026", "&"), "\\u003c", "<"), "\\u003e", ">")
}

resource "davinci_variable" "mf-str-p1PopulationId" {
  context        = "company"
  description    = "Population ID from PingOne"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "mf-str-p1PopulationId"
  type           = "string"
  value          = pingone_population_default.master_flow_default_population.id
}

resource "davinci_variable" "mf-str-p1AgreementId" {
  context        = "company"
  description    = "Population ID from PingOne"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "mf-str-p1AgreementId"
  type           = "string"
  value          = pingone_agreement.master_flow_agreement.id
}

resource "davinci_variable" "mf-str-p1AdminGroupId" {
  context        = "company"
  description    = "Admin Group ID from PingOne"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "mf-str-p1AdminGroupId"
  type           = "string"
  value          = pingone_group.pingone_admin_group.id
}

resource "davinci_variable" "mf-str-p1NeoMobileAppId" {
  context        = "company"
  description    = "PingOne Neo Mobile App ID from PingOne"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "mf-str-p1NeoMobileAppId"
  type           = "string"
  value          = pingone_application.pingone_neo_demo_native_app.id
}

resource "davinci_variable" "mf-str-p1WorkerClientId" {
  context        = "company"
  description    = "PingOne Worker App Client ID from PingOne"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "mf-str-p1WorkerClientId"
  type           = "string"
  value          = pingone_application.dv_worker_app.id
}

resource "davinci_variable" "mf-str-p1WorkerClientSecret" {
  context        = "company"
  description    = "PingOne Worker App Client Secret from PingOne"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "mf-str-p1WorkerClientSecret"
  type           = "string"
  value          = pingone_application_secret.dv_worker_app.secret
}

resource "davinci_variable" "mf-str-p1LivenessVerifyPolicyId" {
  context        = "company"
  description    = "PingOne Verify Liveness-only Policy ID"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "mf-str-p1LivenessVerifyPolicyId"
  type           = "string"
  value          = pingone_verify_policy.liveness_verify_policy.id
}

resource "davinci_variable" "mf-str-restDBAPIKey" {
  context        = "company"
  description    = "RestDB API Key"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "mf-str-restDBAPIKey"
  type           = "string"
  value          = "a0e694454e653eac17b1b3576f907980de492"
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

resource "davinci_variable" "populationId" {
  context        = "flowInstance"
  description    = "PingOne Population Id"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "populationId"
  type           = "string"
  value          = pingone_population_default.master_flow_default_population.id
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

resource "davinci_variable" "showRegButton" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "showRegButton"
  type           = "boolean"
  value          = "${var.davinci_variable_showRegButton}"
}

resource "davinci_variable" "cancelReturn" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "cancelReturn"
  type           = "boolean"
  value          = "${var.davinci_variable_showRegButton}"
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

resource "davinci_variable" "CAPTCHA_THRESHOLD" {
  context        = "flowInstance"
  description    = "reCAPTCHA v3 Threshold"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "CAPTCHA_THRESHOLD"
  type           = "number"
  value          = "0.7"
}

resource "davinci_variable" "mf-str-p1VerifyPolicyId" {
  context        = "company"
  description    = "PingOne Verify Policy ID"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "mf-str-p1VerifyPolicyId"
  type           = "string"
  value          = data.pingone_verify_policy.default_policy.id
}

resource "davinci_variable" "mf-str-p1MFAPolicyId" {
  context        = "company"
  description    = "PingOne MFA Policy ID"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "mf-str-p1MFAPolicyId"
  type           = "string"
  value          = pingone_mfa_device_policy.master_flow_mfa_policy.id
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
    flow_id    = davinci_flow.PingOne-SSO-Authentication-Sensei---MASTER.id
    version_id = -1
    weight     = 100
  }
}

###################
#  DaVinci Flows  #
###################

resource "davinci_flow" "PingOne-SSO-Authentication-Sensei---MASTER" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne SSO Authentication Sensei - MASTER.json")}"

	lifecycle {
	  ignore_changes = all
	}
	connection_link {
		id   = davinci_connection.PingOne.id
		name = davinci_connection.PingOne.name
		replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
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
		id   = davinci_connection.PingOne-Authentication.id
		name = davinci_connection.PingOne-Authentication.name
		replace_import_connection_id = "c3e6a164bde107954e93f5c09f0c8bce"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	subflow_link {
		id   = davinci_flow.PingOne-SSO-Forgot-Password-subflow.id
		name = davinci_flow.PingOne-SSO-Forgot-Password-subflow.name
		replace_import_subflow_id = "b6907b4f292a4a964bd09c58d9ce512a"
	}
	subflow_link {
		id   = davinci_flow.PingOne-SSO-User-Registration-subflow.id
		name = davinci_flow.PingOne-SSO-User-Registration-subflow.name
		replace_import_subflow_id = "c0e0d090b8cfbc7396193b4a343c142b"
	}
	subflow_link {
		id   = davinci_flow.PingOne-SSO-Forgot-Username-subflow.id
		name = davinci_flow.PingOne-SSO-Forgot-Username-subflow.name
		replace_import_subflow_id = "910770704e8721dab55d1bee8d87e2aa"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Protect-subflow.id
		name = davinci_flow.PingOne-Protect-subflow.name
		replace_import_subflow_id = "3a1bf218079b8a6c594c3a4beb29f1fa"
	}
	subflow_link {
		id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
		name = davinci_flow.PingOne-MFA-Authentication-subflow.name
		replace_import_subflow_id = "bed472b5706a7d61a781d81e483986a7"
	}
	subflow_link {
		id   = davinci_flow.PingOne-SSO-Password-Expiration-subflow.id
		name = davinci_flow.PingOne-SSO-Password-Expiration-subflow.name
		replace_import_subflow_id = "d82fed2701fb085d4a04bf41dba5b08c"
	}
	subflow_link {
		id   = davinci_flow.PingOne-SSO-Social-External-IdP-authentication-subflow.id
		name = davinci_flow.PingOne-SSO-Social-External-IdP-authentication-subflow.name
		replace_import_subflow_id = "4641da7f6ec347e86096d3735469962c"
	}
	subflow_link {
		id   = davinci_flow.PingOne-SSO-Change-Password-subflow.id
		name = davinci_flow.PingOne-SSO-Change-Password-subflow.name
		replace_import_subflow_id = "7276f25cd4048bea9262447d79d5af46"
	}
	subflow_link {
		id   = davinci_flow.PingOne-SSO-Account-Verification-subflow.id
		name = davinci_flow.PingOne-SSO-Account-Verification-subflow.name
		replace_import_subflow_id = "a1e8104de5adce520631bae3ce4cbd79"
	}
	subflow_link {
		id   = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.id
		name = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.name
		replace_import_subflow_id = "35d40c635dc3e3fa4f4c2b5ab9ccc343"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Authorize-Flow.id
		name = davinci_flow.PingOne-Authorize-Flow.name
		replace_import_subflow_id = "84f630ddcd6c5b948ce5ec77f6d0a7e4"
	}
	subflow_link {
		id   = davinci_flow.PingOne-reCAPTCHA-v3-subflow.id
		name = davinci_flow.PingOne-reCAPTCHA-v3-subflow.name
		replace_import_subflow_id = "c768a672b7fc67ab842110a8bbaf4e1f"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Neo-Starter-Flow---Verifiable-Credential-Presentation-Request-subflow.id
		name = davinci_flow.PingOne-Neo-Starter-Flow---Verifiable-Credential-Presentation-Request-subflow.name
		replace_import_subflow_id = "e180746be3582cfb3e9b8363961ad353"
	}
	subflow_link {
		id   = davinci_flow.PingOne-MFA-Usernameless-Passkeys---Subflow.id
		name = davinci_flow.PingOne-MFA-Usernameless-Passkeys---Subflow.name
		replace_import_subflow_id = "b871202c0a4efe087fe2a7fbdf81d91a"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-SSO-Forgot-Password-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne SSO Forgot Password subflow.json")}"

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
		replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
	}
	connection_link {
		id   = davinci_connection.Variables.id
		name = davinci_connection.Variables.name
		replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
	}
	connection_link {
		id   = davinci_connection.PingOne-Notifications.id
		name = davinci_connection.PingOne-Notifications.name
		replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
	}

	subflow_link {
		id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
		name = davinci_flow.PingOne-MFA-Authentication-subflow.name
		replace_import_subflow_id = "bed472b5706a7d61a781d81e483986a7"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Security-Question-and-Answer-Validation-subflow.id
		name = davinci_flow.PingOne-Security-Question-and-Answer-Validation-subflow.name
		replace_import_subflow_id = "b2f650594c34c50514349bc1e3227395"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-SSO-User-Registration-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne SSO User Registration subflow.json")}"

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
	connection_link {
		id   = davinci_connection.PingOne-Notifications.id
		name = davinci_connection.PingOne-Notifications.name
		replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	subflow_link {
		id   = davinci_flow.PingOne-SSO-Consent-subflow.id
		name = davinci_flow.PingOne-SSO-Consent-subflow.name
		replace_import_subflow_id = "f5e4badc15ad9cf204bc18c7c1a95a31"
	}
	subflow_link {
		id   = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.id
		name = davinci_flow.PingOne-SSO-Progressive-Profiling-subflow.name
		replace_import_subflow_id = "35d40c635dc3e3fa4f4c2b5ab9ccc343"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Custom-Security-Question-and-Answer-Registration-subflow.id
		name = davinci_flow.PingOne-Custom-Security-Question-and-Answer-Registration-subflow.name
		replace_import_subflow_id = "e7c4eca065591220b37b78c530459858"
	}
	subflow_link {
		id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
		name = davinci_flow.PingOne-MFA-Device-Registration-subflow.name
		replace_import_subflow_id = "55d7c7c02b0985934703055fbca259e7"
	}
	subflow_link {
		id   = davinci_flow.PingOne-SSO-Account-Verification-subflow.id
		name = davinci_flow.PingOne-SSO-Account-Verification-subflow.name
		replace_import_subflow_id = "a1e8104de5adce520631bae3ce4cbd79"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Verify-subflow.id
		name = davinci_flow.PingOne-Verify-subflow.name
		replace_import_subflow_id = "fa53f76dbec74a4c40040cf5cd6d5cea"
	}
	subflow_link {
		id   = davinci_flow.PingOne-reCAPTCHA-v3-subflow.id
		name = davinci_flow.PingOne-reCAPTCHA-v3-subflow.name
		replace_import_subflow_id = "c768a672b7fc67ab842110a8bbaf4e1f"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.id
		name = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.name
		replace_import_subflow_id = "05f765201fcd10df42222983c28e07f3"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Protect-subflow.id
		name = davinci_flow.PingOne-Protect-subflow.name
		replace_import_subflow_id = "3a1bf218079b8a6c594c3a4beb29f1fa"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Pair-a-Digital-Wallet-subflow.id
		name = davinci_flow.PingOne-Pair-a-Digital-Wallet-subflow.name
		replace_import_subflow_id = "69e63998defbbd9f7dd3e32fd3cc54c0"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-SSO-Forgot-Username-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne SSO Forgot Username subflow.json")}"

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
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-SSO-Password-Expiration-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne SSO Password Expiration subflow.json")}"

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
	connection_link {
		id   = davinci_connection.PingOne.id
		name = davinci_connection.PingOne.name
		replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-SSO-Social-External-IdP-authentication-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne SSO Social External IdP authentication subflow.json")}"

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
		id   = davinci_connection.Variables.id
		name = davinci_connection.Variables.name
		replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	subflow_link {
		id   = davinci_flow.PingOne-SSO-Consent-subflow.id
		name = davinci_flow.PingOne-SSO-Consent-subflow.name
		replace_import_subflow_id = "f5e4badc15ad9cf204bc18c7c1a95a31"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Auto-enroll-user-in-email.id
		name = davinci_flow.PingOne-Auto-enroll-user-in-email.name
		replace_import_subflow_id = "b871202c0a4efe087fe2a7fbdf81d91a"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-SSO-Change-Password-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne SSO Change Password subflow.json")}"

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
	connection_link {
		id   = davinci_connection.Node.id
		name = davinci_connection.Node.name
		replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
	}
	connection_link {
		id   = davinci_connection.PingOne-Notifications.id
		name = davinci_connection.PingOne-Notifications.name
		replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Authorize-Flow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Authorize Flow.json")}"

	connection_link {
		id   = davinci_connection.PingOne-Authorize.id
		name = davinci_connection.PingOne-Authorize.name
		replace_import_connection_id = "7b2e39fb332e26e8a9035dc92e733ae3"
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
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	subflow_link {
		id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
		name = davinci_flow.PingOne-MFA-Authentication-subflow.name
		replace_import_subflow_id = "bed472b5706a7d61a781d81e483986a7"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Neo-Starter-Flow---Verifiable-Credential-Presentation-Request-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Neo Starter Flow - Verifiable Credential Presentation Request subflow.json")}"

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
		id   = davinci_connection.Node.id
		name = davinci_connection.Node.name
		replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	subflow_link {
		id   = davinci_flow.PingOne-Validate-a-Verifiable-Credential-Subflow.id
		name = davinci_flow.PingOne-Validate-a-Verifiable-Credential-Subflow.name
		replace_import_subflow_id = "6a492f757100ac4eff49f595220f30e1"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Identity-Verification-and-Managed-Credential-Issuance-with-Biometric-Binding-subflow.id
		name = davinci_flow.PingOne-Identity-Verification-and-Managed-Credential-Issuance-with-Biometric-Binding-subflow.name
		replace_import_subflow_id = "c9099ef0128af3a279cd33fe5ee8d942"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-MFA-Usernameless-Passkeys---Subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne MFA Usernameless Passkeys - Subflow.json")}"

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
		id   = davinci_connection.Functions.id
		name = davinci_connection.Functions.name
		replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
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
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

    subflow_link {
		id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
		name = davinci_flow.PingOne-MFA-Device-Registration-subflow.name
		replace_import_subflow_id = "55d7c7c02b0985934703055fbca259e7"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Validate-a-Verifiable-Credential-Subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Validate a Verifiable Credential Subflow.json")}"

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
		id   = davinci_connection.PingOne-Credentials.id
		name = davinci_connection.PingOne-Credentials.name
		replace_import_connection_id = "b249494cebd3035d7e9da053c34bc52f"
	}
	connection_link {
		id   = davinci_connection.Device-Policy.id
		name = davinci_connection.Device-Policy.name
		replace_import_connection_id = "79a1f68f5a2fc72e92ada3cee8ada8be"
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
		id   = davinci_connection.PingOne.id
		name = davinci_connection.PingOne.name
		replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
	}
	connection_link {
		id   = davinci_connection.Flow-Connector.id
		name = davinci_connection.Flow-Connector.name
		replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
	}
	connection_link {
		id   = davinci_connection.PingOne-Verify.id
		name = davinci_connection.PingOne-Verify.name
		replace_import_connection_id = "aebcad93e7a1090d237676631e96f5ad"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	subflow_link {
		id   = davinci_flow.PingOne-Protect-subflow.id
		name = davinci_flow.PingOne-Protect-subflow.name
		replace_import_subflow_id = "3a1bf218079b8a6c594c3a4beb29f1fa"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Identity-Verification-and-Managed-Credential-Issuance-with-Biometric-Binding-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Identity Verification and Managed Credential Issuance with Biometric Binding subflow.json")}"

	connection_link {
		id   = davinci_connection.PingOne-Verify.id
		name = davinci_connection.PingOne-Verify.name
		replace_import_connection_id = "aebcad93e7a1090d237676631e96f5ad"
	}
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
		id   = davinci_connection.Strings.id
		name = davinci_connection.Strings.name
		replace_import_connection_id = "843f85a3cd3c8ff97906d4502e238317"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	subflow_link {
		id   = davinci_flow.PingOne-Pair-a-Digital-Wallet-subflow.id
		name = davinci_flow.PingOne-Pair-a-Digital-Wallet-subflow.name
		replace_import_subflow_id = "69e63998defbbd9f7dd3e32fd3cc54c0"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Auto-enroll-user-in-mobile-SMS" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Auto enroll user in mobile SMS.json")}"

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
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Auto-enroll-user-in-email" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Auto enroll user in email.json")}"

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
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-MFA-Device-Management-Subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne MFA Device Management Subflow.json")}"

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
	connection_link {
		id   = davinci_connection.PingOne-Notifications.id
		name = davinci_connection.PingOne-Notifications.name
		replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
	}
	connection_link {
		id   = davinci_connection.PingOne.id
		name = davinci_connection.PingOne.name
		replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	subflow_link {
		id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
		name = davinci_flow.PingOne-MFA-Device-Registration-subflow.name
		replace_import_subflow_id = "7fc6f71c9d96ea625d90f5e2675520e4"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Davinci-Custom-Magic-Link-Subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Davinci Custom Magic Link Subflow.json")}"

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
		id   = davinci_connection.Error-Message.id
		name = davinci_connection.Error-Message.name
		replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Custom-Security-Question-and-Answer-Registration-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Custom Security Question and Answer Registration subflow.json")}"

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
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Security-Question-and-Answer-Validation-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Security Question and Answer Validation subflow.json")}"

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
	connection_link {
		id   = davinci_connection.Variables.id
		name = davinci_connection.Variables.name
		replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Protect-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Protect subflow.json")}"

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
		id   = davinci_connection.Flow-Connector.id
		name = davinci_connection.Flow-Connector.name
		replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
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
		id   = davinci_connection.Strings.id
		name = davinci_connection.Strings.name
		replace_import_connection_id = "843f85a3cd3c8ff97906d4502e238317"
	}
	connection_link {
		id   = davinci_connection.PingOne-MFA.id
		name = davinci_connection.PingOne-MFA.name
		replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	subflow_link {
		id   = davinci_flow.PingOne-Verify-subflow.id
		name = davinci_flow.PingOne-Verify-subflow.name
		replace_import_subflow_id = "fa53f76dbec74a4c40040cf5cd6d5cea"
	}
	subflow_link {
		id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
		name = davinci_flow.PingOne-MFA-Authentication-subflow.name
		replace_import_subflow_id = "bed472b5706a7d61a781d81e483986a7"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-MFA-Authentication-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne MFA Authentication Subflow.json")}"

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
		replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
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
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}
	connection_link {
		id   = davinci_connection.PingOne.id
		name = davinci_connection.PingOne.name
		replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
	}

	subflow_link {
		id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
		name = davinci_flow.PingOne-MFA-Device-Registration-subflow.name
		replace_import_subflow_id = "55d7c7c02b0985934703055fbca259e7"
	}
	subflow_link {
		id   = davinci_flow.PingOne-MFA-Device-Management-Subflow.id
		name = davinci_flow.PingOne-MFA-Device-Management-Subflow.name
		replace_import_subflow_id = "1f52f5f9eeb123b76069cb24cc5c2e90"
	}
	subflow_link {
		id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-Subflow.id
		name = davinci_flow.PingOne-Davinci-Custom-Magic-Link-Subflow.name
		replace_import_subflow_id = "caab30786105b2f2c4f62678b15cae46"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-MFA-Device-Registration-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne MFA Device Registration subflow.json")}"

	connection_link {
		id   = davinci_connection.PingOne-MFA.id
		name = davinci_connection.PingOne-MFA.name
		replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
	}
	connection_link {
		id   = davinci_connection.PingOne-MFA-Passwordless.id
		name = davinci_connection.PingOne-MFA-Passwordless.name
		replace_import_connection_id = "1b4f92e473d6ece11dc6556365350da6"
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
	connection_link {
		id   = davinci_connection.PingOne-Notifications.id
		name = davinci_connection.PingOne-Notifications.name
		replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}
	# subflow_link {
	# 	id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
	# 	name = davinci_flow.PingOne-MFA-Authentication-subflow.name
	# 	replace_import_subflow_id = "7c644cd45b6271a1bc5a5e548005435e"
	# }
	subflow_link {
		id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.id
		name = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.name
		replace_import_subflow_id = "05f765201fcd10df42222983c28e07f3"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Pair-a-Digital-Wallet-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Pair a Digital Wallet subflow.json")}"

	connection_link {
		id   = davinci_connection.Annotation.id
		name = davinci_connection.Annotation.name
		replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
	}
	connection_link {
		id   = davinci_connection.PingOne-Credentials.id
		name = davinci_connection.PingOne-Credentials.name
		replace_import_connection_id = "b249494cebd3035d7e9da053c34bc52f"
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
		id   = davinci_connection.Functions.id
		name = davinci_connection.Functions.name
		replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
	}
	connection_link {
		id   = davinci_connection.Device-Policy.id
		name = davinci_connection.Device-Policy.name
		replace_import_connection_id = "79a1f68f5a2fc72e92ada3cee8ada8be"
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
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-SSO-Consent-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne SSO Consent subflow.json")}"

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
	connection_link {
		id   = davinci_connection.Error-Message.id
		name = davinci_connection.Error-Message.name
		replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-SSO-Progressive-Profiling-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne SSO Progressive Profiling subflow.json")}"

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
	connection_link {
		id   = davinci_connection.Variables.id
		name = davinci_connection.Variables.name
		replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
	}
	connection_link {
		id   = davinci_connection.Node.id
		name = davinci_connection.Node.name
		replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
	}
	connection_link {
		id   = davinci_connection.PingOne-Notifications.id
		name = davinci_connection.PingOne-Notifications.name
		replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
	}
	connection_link {
		id   = davinci_connection.Flow-Connector.id
		name = davinci_connection.Flow-Connector.name
		replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	subflow_link {
		id   = davinci_flow.PingOne-Auto-enroll-user-in-mobile-SMS.id
		name = davinci_flow.PingOne-Auto-enroll-user-in-mobile-SMS.name
		replace_import_subflow_id = "5ab50bf97e1dadebb540d59a536cab14"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-SSO-Account-Verification-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne SSO Account Verification subflow.json")}"

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
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Verify-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Verify subflow.json")}"

	connection_link {
		id   = davinci_connection.PingOne-Verify.id
		name = davinci_connection.PingOne-Verify.name
		replace_import_connection_id = "aebcad93e7a1090d237676631e96f5ad"
	}
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
		id   = davinci_connection.Device-Policy.id
		name = davinci_connection.Device-Policy.name
		replace_import_connection_id = "79a1f68f5a2fc72e92ada3cee8ada8be"
	}
	connection_link {
		id   = davinci_connection.Variables.id
		name = davinci_connection.Variables.name
		replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
	}
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
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
	connection_link {
		id   = davinci_connection.Error-Message.id
		name = davinci_connection.Error-Message.name
		replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
	}

	subflow_link {
		id   = davinci_flow.PingOne-Pair-a-Digital-Wallet-subflow.id
		name = davinci_flow.PingOne-Pair-a-Digital-Wallet-subflow.name
		replace_import_subflow_id = "69e63998defbbd9f7dd3e32fd3cc54c0"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-reCAPTCHA-v3-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne reCAPTCHA v3 subflow.json")}"

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
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}

resource "davinci_flow" "PingOne-Davinci-Custom-Magic-Link-registration-subflow" {
	environment_id = pingone_environment.master_flow_environment.id
	flow_json = "${file("${path.module}/data/flows/PingOne Davinci Custom Magic Link registration subflow.json")}"

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
		id   = davinci_connection.Functions.id
		name = davinci_connection.Functions.name
		replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
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
	connection_link {
		id   = davinci_connection.Flow-Analytics.id
		name = davinci_connection.Flow-Analytics.name
		replace_import_connection_id = "78f6209abfff297bca70010581d074b1"
	}

	depends_on = [
		data.davinci_connections.read_connections
	]
}