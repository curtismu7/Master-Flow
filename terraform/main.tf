terraform {
  required_providers {
    pingone = {
      source  = "pingidentity/pingone"
      version = "~> 0.26"
    }
    davinci = {
      source = "pingidentity/davinci"
    }
  }
}

provider "pingone" {
  client_id      = var.admin_client_id
  client_secret  = var.admin_client_secret
  environment_id = var.admin_environment_id
  region         = var.region

  force_delete_production_type = false
}

provider "davinci" {
  username       = var.dv_admin_username
  password       = var.dv_admin_password
  environment_id = var.admin_environment_id
  region         = var.region
}

resource "pingone_environment" "master_flow_environment" {         
  name        = var.environment_name
  description = var.environment_description
  type        = var.environment_type
  license_id  = data.pingone_licenses.internal_license.ids[0]
  service {
    type = "SSO"
  }
  service {
    type = "MFA"
  }
  service {
    type = "DaVinci"
    tags = ["DAVINCI_MINIMAL"]
  }
  service {
    type = "Verify"
  }
  service {
    type = "Risk"
  }
}

data "pingone_role" "environment_admin" {
  name = "Environment Admin"
}

data "pingone_role" "identity_data_admin" {
  name = "Identity Data Admin"
}

data "pingone_role" "client_application_developer" {
  name = "Client Application Developer"
}

resource "pingone_role_assignment_user" "id_admin" {
  environment_id = var.admin_environment_id
  user_id        = var.admin_user_id
  role_id        = data.pingone_role.identity_data_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id
}

resource "pingone_role_assignment_user" "app_dev" {
  environment_id = var.admin_environment_id
  user_id        = var.admin_user_id
  role_id        = data.pingone_role.client_application_developer.id

  scope_environment_id = pingone_environment.master_flow_environment.id
}

resource "pingone_population" "app" {
  environment_id = pingone_environment.master_flow_environment.id

  name        = "Application Users"
  description = "Population containing App Users"
}

/*
resource "time_sleep" "wait_20_seconds" {
  depends_on = [
    davinci_connection.Annotation,
    davinci_connection.Challenge,
    davinci_connection.Error-Message,
    davinci_connection.Flow-Connector,
    davinci_connection.Functions,
    davinci_connection.Http,
    davinci_connection.Node,
    davinci_connection.PingOne,
    davinci_connection.PingOne-Authentication,
    davinci_connection.PingOne-MFA,
    davinci_connection.PingOne-Notifications,
    davinci_connection.PingOne-Protect,
    davinci_connection.PingOne-Verify,
    davinci_connection.Token-Management,
    davinci_connection.User-Policy,
    davinci_connection.Variables,
  ]
  
  create_duration = local.deployment_type
}
*/

############
#  Locals  #
############

locals {
  widget   = var.deployment_type == "WIDGET" ? "20s" : ""
  redirect = var.deployment_type == "REDIRECT" ? "120s" : ""
  deployment_type = coalesce(local.widget, local.redirect)
}

##################
#  Data Sources  #
##################

data "pingone_licenses" "internal_license" {
  organization_id = var.organization_id

  data_filter {
    name   = "package"
    values = ["${var.license_name}"]
  }

  data_filter {
    name   = "status"
    values = ["ACTIVE"]
  }
}

data "pingone_population" "default_population" {
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Default"
}

data "pingone_password_policy" "standard_password_policy" {
  environment_id = pingone_environment.master_flow_environment.id
  name = "Standard"
}

############################
#  Social Login Providers  #
############################

resource "pingone_identity_provider" "google" {
  count = var.davinci_variable_gv-googleLogin_value == "true" ? 1 : 0
  environment_id = pingone_environment.master_flow_environment.id

  name    = "Google"
  enabled = true

  google {
    client_id     = var.google_client_id
    client_secret = var.google_client_secret
  }
  registration_population_id = data.pingone_population.default_population.id
}

#######################
#  PingOne Agreement  #
#######################

data "pingone_language" "en" {
  environment_id = pingone_environment.master_flow_environment.id
  locale = "en"
}

resource "pingone_agreement" "master_flow_agreement" {
  environment_id = pingone_environment.master_flow_environment.id

  name        = "Terms and Conditions"
  description = "An agreement for general Terms and Conditions"
}

resource "pingone_agreement_localization" "master_flow_agreement_en" {
  environment_id = pingone_environment.master_flow_environment.id
  agreement_id   = pingone_agreement.master_flow_agreement.id
  language_id    = data.pingone_language.en.id

  display_name = "Terms and Conditions - English Locale"
}

resource "pingone_agreement_localization_revision" "master_flow_agreement_en_now" {
  environment_id            = pingone_environment.master_flow_environment.id
  agreement_id              = pingone_agreement.master_flow_agreement.id
  agreement_localization_id = pingone_agreement_localization.master_flow_agreement_en.id

  content_type      = "text/html"
  require_reconsent = true
  text              = var.pingone_agreement_localization_revision_master_flow_agreement_en_now_text
}

resource "pingone_agreement_localization_enable" "master_flow_agreement_en_enable" {
  environment_id            = pingone_environment.master_flow_environment.id
  agreement_id              = pingone_agreement.master_flow_agreement.id
  agreement_localization_id = pingone_agreement_localization.master_flow_agreement_en.id

  enabled = true

  depends_on = [
    pingone_agreement_localization_revision.master_flow_agreement_en_now
  ]
}

resource "pingone_agreement_enable" "master_flow_agreement_enable" {
  environment_id = pingone_environment.master_flow_environment.id
  agreement_id   = pingone_agreement.master_flow_agreement.id

  enabled = true

  depends_on = [
    pingone_agreement_localization_enable.master_flow_agreement_en_enable
  ]
}

##################
#  Applications  #
##################

resource "pingone_application" "dv_worker_app" {
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne DaVinci Connection"
  enabled        = true

  oidc_options {
    type                        = "WORKER"
    grant_types                 = ["CLIENT_CREDENTIALS"]
    token_endpoint_authn_method = "CLIENT_SECRET_BASIC"
  }

  icon {
    id   = "c6dbb456-0857-4fab-bfb0-909944233017"
    href = "https://assets.pingone.com/ux/ui-library/4.18.0/images/logo-pingidentity.png"
  }
}

resource "pingone_application_role_assignment" "id_admin" {
  environment_id = pingone_environment.master_flow_environment.id
  application_id = pingone_application.dv_worker_app.id
  role_id        = data.pingone_role.identity_data_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id
}

resource "pingone_application_role_assignment" "env_admin" {
  environment_id = pingone_environment.master_flow_environment.id
  application_id = pingone_application.dv_worker_app.id
  role_id        = data.pingone_role.environment_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id
}

resource "pingone_application" "oidc_app" {
  environment_id = pingone_environment.master_flow_environment.id
  enabled        = true
  name           = "Master Flow OIDC App"

  oidc_options {
    type                        = "WEB_APP"
    grant_types                 = ["AUTHORIZATION_CODE"]
    response_types              = ["CODE"]
    token_endpoint_authn_method = "NONE"
    redirect_uris               = ["https://auth.pingone.com/${pingone_environment.master_flow_environment.id}/rp/callback/openid_connect"]
  }

  icon {
    id   = "c6dbb456-0857-4fab-bfb0-909944233017"
    href = "https://assets.pingone.com/ux/ui-library/4.18.0/images/logo-pingidentity.png"
  }
}

resource "pingone_application_flow_policy_assignment" "oidc_app" {
  environment_id = pingone_environment.master_flow_environment.id
  application_id = pingone_application.oidc_app.id

  flow_policy_id = davinci_application_flow_policy.PingOne-SSO-Flow-Policy.id

  priority = 1
}

resource "pingone_system_application" "pingone_portal" {
  environment_id = pingone_environment.master_flow_environment.id

  type    = "PING_ONE_PORTAL"
  enabled = true
}

resource "pingone_system_application" "pingone_self_service" {
  environment_id = pingone_environment.master_flow_environment.id

  type    = "PING_ONE_SELF_SERVICE"
  enabled = true

  apply_default_theme         = true
  enable_default_theme_footer = true
}

resource "pingone_application_flow_policy_assignment" "my_account" {
  environment_id = pingone_environment.master_flow_environment.id
  application_id = pingone_system_application.pingone_self_service.id

  flow_policy_id = davinci_application_flow_policy.PingOne-SSO-Flow-Policy.id

  priority = 1
}

resource "pingone_application_flow_policy_assignment" "my_apps" {
  environment_id = pingone_environment.master_flow_environment.id
  application_id = pingone_system_application.pingone_portal.id

  flow_policy_id = davinci_application_flow_policy.PingOne-SSO-Flow-Policy.id

  priority = 1
}

#############
#  Outputs  #
#############

output "initiate_flow_uri" {
  value = "https://apps.pingone.com/${pingone_environment.master_flow_environment.id}/myaccount/"
}

output "google_callback_url" {
  value = var.davinci_variable_gv-googleLogin_value == "true" ? "https://auth.pingone.com/${pingone_environment.master_flow_environment.id}/rp/callback/google" : "N/A"
}

############################
#  Notification Templates  #
############################

resource "pingone_notification_template_content" "device_pairing" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "device_pairing"
  locale         = "en"
  variant        = "OTP"

  email {
    body          = "${file("${path.module}/data/notification_templates/devicePairing OTP.html")}"
    subject       = "Device Pairing OTP"
    content_type  = "text/html"
    character_set = "UTF-8"

    from {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }
}

resource "pingone_notification_template_content" "email_verification_user" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "email_verification_user"
  locale         = "en"

  email {
    body          = "${file("${path.module}/data/notification_templates/Email Address Verification (User) - OTP.html")}"
    subject       = "Email Verification (User)"
    content_type  = "text/html"
    character_set = "UTF-8"

    from {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }
}

resource "pingone_notification_template_content" "magic_link" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "general"
  locale         = "en"
  variant        = "MagicLink"

  email {
    body          = "${file("${path.module}/data/notification_templates/magiclink.html")}"
    subject       = "Magic Link"
    content_type  = "text/html"
    character_set = "UTF-8"

    from {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }
}

resource "pingone_notification_template_content" "new_device_paired" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "new_device_paired"
  locale         = "en"

  email {
    body          = "${file("${path.module}/data/notification_templates/newDevicePaired.html")}"
    subject       = "New Device Paired"
    content_type  = "text/html"
    character_set = "UTF-8"

    from {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }
}

resource "pingone_notification_template_content" "forgot_username" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "general"
  locale         = "en"
  variant        = "Forgot Username"

  email {
    body          = "${file("${path.module}/data/notification_templates/forgotusername.html")}"
    subject       = "Forgot Username"
    content_type  = "text/html"
    character_set = "UTF-8"

    from {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }
}

resource "pingone_notification_template_content" "general_otp" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "general"
  locale         = "en"
  variant        = "OTP"

  email {
    body          = "${file("${path.module}/data/notification_templates/general-otp.html")}"
    subject       = "General OTP"
    content_type  = "text/html"
    character_set = "UTF-8"

    from {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }
}

resource "pingone_notification_template_content" "pairing_otp" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "device_pairing"
  locale         = "en"

  email {
    body          = "${file("${path.module}/data/notification_templates/Pairing OTP.html")}"
    subject       = "Device Pairing OTP"
    content_type  = "text/html"
    character_set = "UTF-8"

    from {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }
}

resource "pingone_notification_template_content" "strong_authentication" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "strong_authentication"
  locale         = "en"

  email {
    body          = "${file("${path.module}/data/notification_templates/strongAuthentication.html")}"
    subject       = "Strong Authentication"
    content_type  = "text/html"
    character_set = "UTF-8"

    from {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }
}

resource "pingone_notification_template_content" "verification_code" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "verification_code_template"
  locale         = "en"

  email {
    body          = "${file("${path.module}/data/notification_templates/verification code.html")}"
    subject       = "Verification Code"
    content_type  = "text/html"
    character_set = "UTF-8"

    from {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }
}

resource "pingone_notification_template_content" "password_recovery" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "recovery_code_template"
  locale         = "en"

  email {
    body          = "${file("${path.module}/data/notification_templates/Password Recovery.html")}"
    subject       = "Verification Code"
    content_type  = "text/html"
    character_set = "UTF-8"

    from {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }
}

#######################
#  Custom Attributes  #
#######################

resource "pingone_schema_attribute" "dob_attribute" {
  environment_id = pingone_environment.master_flow_environment.id

  name         = "dob"
  display_name = "Date of Birth"

  type        = "STRING"
  unique      = false
  multivalued = false

  lifecycle {
    prevent_destroy = false
  }
}

resource "pingone_schema_attribute" "security_qa_attribute" {
  environment_id = pingone_environment.master_flow_environment.id

  name         = "securityQA"
  display_name = "Security Questions - Answers"

  type        = "JSON"
  unique      = false
  multivalued = false

  lifecycle {
    prevent_destroy = false
  }
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

  saml {
    values {
      enabled                = "false"
      enforce_signed_request = "false"
    }
  }
  depends_on = [
    data.davinci_connections.read_all
  ]
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

  depends_on = [
    data.davinci_connections.read_all
  ]
}

#########################
#  DaVinci Connections  #
#########################

data "davinci_connections" "read_all" {
  environment_id = pingone_environment.master_flow_environment.id
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
  name           = "Node"
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

###################
#  Davinci Flows  #
###################

resource "davinci_flow" "PingOne-Custom-Security-Question-and-Answer-Registration-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Custom Security Question and Answer Registration subflow.json")}"
  
  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-Davinci-Custom-Magic-Link-registration-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Challenge.id
    name = "Challenge"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = "Flow Connector"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = "PingOne MFA"
  }

  connection_link {
    id   = davinci_connection.PingOne-Notifications.id
    name = "PingOne Notifications"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Davinci Custom Magic Link registration subflow.json")}"

  depends_on = [
    data.davinci_connections.read_all  ]
}

resource "davinci_flow" "PingOne-Davinci-Custom-Magic-Link-Subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Challenge.id
    name = "Challenge"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = "Flow Connector"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne-Notifications.id
    name = "PingOne Notifications"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }
  
  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Davinci Custom Magic Link Subflow.json")}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-MFA-Authentication-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = "Flow Connector"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = "PingOne MFA"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
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
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-MFA-Device-Management-Subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = "Flow Connector"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = "PingOne MFA"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne MFA Device Management Subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Device-Registration-subflow.id
    name = "PingOne MFA Device Registration subflow"
  }

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-MFA-Device-Registration-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = "Flow Connector"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = "PingOne MFA"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne MFA Device Registration subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-Davinci-Custom-Magic-Link-registration-subflow.id
    name = "PingOne Davinci Custom Magic Link registration subflow"
  }

  depends_on = [
    data.davinci_connections.read_all
  ]
#  subflow_link {
#    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
#    name = "PingOne MFA Authentication subflow"
#  }
}

resource "davinci_flow" "PingOne-Protect-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = "Flow Connector"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  connection_link {
    id   = davinci_connection.PingOne-Protect.id
    name = "PingOne Protect"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
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
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-SSO-Account-Verification-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Account Verification subflow.json")}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-SSO-Authentication-MASTER" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = "Flow Connector"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne-Authentication.id
    name = "PingOne Authentication"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Authentication MASTER.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = "PingOne MFA Authentication subflow"
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
    id   = davinci_flow.PingOne-SSO-User-Registration-subflow.id
    name = "PingOne SSO User Registration subflow"
  }

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-SSO-Change-Password-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Change Password subflow.json")}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-SSO-Consent-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Consent subflow.json")}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-SSO-Forgot-Password-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = "Flow Connector"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
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
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-SSO-Forgot-Username-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.PingOne-Notifications.id
    name = "PingOne Notifications"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Forgot Username subflow.json")}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-SSO-Password-Expiration-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Password Expiration subflow.json")}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-SSO-Progressive-Profiling-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Progressive Profiling subflow.json")}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-SSO-Social-External-IdP-authentication-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = "Flow Connector"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne-Authentication.id
    name = "PingOne Authentication"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne SSO Social External IdP authentication subflow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-MFA-Authentication-subflow.id
    name = "PingOne MFA Authentication subflow"
  }

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-SSO-User-Registration-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = "Flow Connector"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  connection_link {
    id   = davinci_connection.PingOne-MFA.id
    name = "PingOne MFA"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
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

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-Security-Question-and-Answer-Validation-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Security Question and Answer Validation subflow.json")}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-Session-Main-Flow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Flow-Connector.id
    name = "Flow Connector"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne-Authentication.id
    name = "PingOne Authentication"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Session Main Flow.json")}"

  subflow_link {
    id   = davinci_flow.PingOne-Sign-On-with-Registration-Password-Reset-and-Recovery.id
    name = "PingOne Sign On with Registration, Password Reset and Recovery"
  }

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-Sign-On-with-Registration-Password-Reset-and-Recovery" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Error-Message.id
    name = "Error Message"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.Node.id
    name = "Node"
  }

  connection_link {
    id   = davinci_connection.PingOne.id
    name = "PingOne"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Sign On with Registration, Password Reset and Recovery.json")}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_flow" "PingOne-Verify-subflow" {
  connection_link {
    id   = davinci_connection.Annotation.id
    name = "Annotation"
  }

  connection_link {
    id   = davinci_connection.Functions.id
    name = "Functions"
  }

  connection_link {
    id   = davinci_connection.Http.id
    name = "Http"
  }

  connection_link {
    id   = davinci_connection.PingOne-Verify.id
    name = "PingOne Verify"
  }

  connection_link {
    id   = davinci_connection.Variables.id
    name = "Variables"
  }

  deploy         = "true"
  environment_id = pingone_environment.master_flow_environment.id
  flow_json      = "${file("${path.module}/data/flows/flow_PingOne Verify subflow.json")}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

#######################
#  DaVinci Variables  #
#######################

resource "davinci_variable" "CodeSentMsg" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "CodeSentMsg"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "IsActionReg" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "IsActionReg"
  type           = "boolean"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "adminMessage" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "adminMessage"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "availableQuestions" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "availableQuestions"
  type           = "object"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "availableQuestions_2" {
  context        = "company"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "availableQuestions"
  type           = "object"
  value          = "${var.davinci_variable_availableQuestions_2_value}"


  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "buttonValueDeviceId" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "buttonValueDeviceId"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "canChangeDevice" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "canChangeDevice"
  type           = "boolean"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "companyName" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "companyName"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "deviceCount" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "deviceCount"
  type           = "number"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "gotoLogin" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gotoLogin"
  type           = "boolean"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-QA-On_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-allowPasswordless_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-azureLogin_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-companyLogo_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-companyName_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-consent_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "gv-deviceManagement" {
  context        = "company"
  description    = "Determine if device management  is available"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-deviceManagement"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-deviceManagement_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-facebookLogin_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-forcePasswordless_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "gv-forgotPasswordDisplay" {
  context        = "company"
  description    = "determines if to show Forgot Password on sign in window"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "false"
  name           = "gv-forgotPasswordDisplay"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-forgotPasswordDisplay_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "gv-forgotUsernameDisplay" {
  context        = "company"
  description    = "determines if to show forgot username on sign in window"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "false"
  name           = "gv-forgotUsernameDisplay"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-forgotUsernameDisplay_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-githubLogin_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-googleLogin_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = var.davinci_variable_gv-googleLogin_value == "true" ? "${pingone_identity_provider.google[0].id}" : "N/A"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "gv-inlineMFAOn" {
  context        = "company"
  description    = "Determines if to run MFA inline"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-inlineMFAOn"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-inlineMFAOn_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "gv-mfa-on" {
  context        = "company"
  description    = "Turn on and off MFA"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-mfa-on"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-mfa-on_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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

  depends_on = [
    data.davinci_connections.read_all
  ]
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

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "gv-p1PopulationId" {
  context        = "company"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-p1PopulationId"
  type           = "string"
  value          = data.pingone_population.default_population.id

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-passwordlessAllowedTypes_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "gv-progressiveProfiling" {
  context        = "company"
  description    = "Turn on Progressive profiling"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-progressiveProfiling"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-progressiveProfiling_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-riskLevel_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-runMFAforForgot_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-runMFAforLogin_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-runMFAforSocial_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-runPasswordExpire_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-runProtect_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "gv-runVerifyforHighRisk" {
  context        = "company"
  description    = "If you want to run Verify when user is High Risk"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-runVerifyforHighRisk"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-runVerifyforHighRisk_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "gv-standardForgotPassword" {
  context        = "company"
  description    = "turn on Standard forgot password - Just MFA"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "gv-standardForgotPassword"
  type           = "boolean"
  value          = "${var.davinci_variable_gv-standardForgotPassword_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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
  value          = "${var.davinci_variable_gv-webAuthnSupport_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "origin" {
  context        = "company"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "origin"
  type           = "string"
  value          = "${var.davinci_variable_origin_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "origin_2" {
  context        = "flowInstance"
  description    = "FIDO2 origin"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "origin"
  type           = "string"
  value          = "${var.davinci_variable_origin_2_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "p1AgreementId" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1AgreementId"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "p1AuthMethods" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1AuthMethods"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "p1AuthenticationMethods" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1AuthenticationMethods"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "p1DeviceAuthenticationId" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1DeviceAuthenticationId"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
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

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "p1UserId" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "p1UserId"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "populationId" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "populationId"
  type           = "string"
  value          = data.pingone_population.default_population.id

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "preppedDevices" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "preppedDevices"
  type           = "object"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "publicKeyCredentialRequestOptions" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "publicKeyCredentialRequestOptions"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "relyingParty" {
  context        = "company"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "relyingParty"
  type           = "string"
  value          = "${var.davinci_variable_relyingParty_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "relyingParty_2" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "relyingParty"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "rpid" {
  context        = "company"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "rpid"
  type           = "string"
  value          = "${var.davinci_variable_rpid_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
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

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "selectedDeviceId" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "selectedDeviceId"
  type           = "string"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "showCodeSentMsg" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "showCodeSentMsg"
  type           = "boolean"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "showRegButton" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "showRegButton"
  type           = "boolean"
  value          = "${var.davinci_variable_showRegButton_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "showSettings" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "showSettings"
  type           = "boolean"

  depends_on = [
    data.davinci_connections.read_all
  ]
}

resource "davinci_variable" "stopSign" {
  context        = "flowInstance"
  environment_id = pingone_environment.master_flow_environment.id
  max            = "2000"
  min            = "0"
  mutable        = "true"
  name           = "stopSign"
  type           = "string"
  value          = "${var.davinci_variable_stopSign_value}"

  depends_on = [
    data.davinci_connections.read_all
  ]
}
