terraform {
  required_providers {
    pingone = {
      source  = "pingidentity/pingone"
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

resource "pingone_role_assignment_user" "id_admin" {
  environment_id = var.admin_environment_id
  user_id        = var.admin_user_id
  role_id        = data.pingone_role.identity_data_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_role_assignment_user" "app_dev" {
  environment_id = var.admin_environment_id
  user_id        = var.admin_user_id
  role_id        = data.pingone_role.client_application_developer.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}


#############
#  Modules  #
#############

module "davinci" {
  source = "./modules/davinci"

  # PingOne
  pingone_environment_master_flow_environment_id               = pingone_environment.master_flow_environment.id
  pingone_application_dv_worker_app_oidc_options_client_id     = pingone_application.dv_worker_app.oidc_options[0].client_id
  pingone_application_dv_worker_app_oidc_options_client_secret = pingone_application.dv_worker_app.oidc_options[0].client_secret
  pingone_identity_provider_facebook_id                        = var.davinci_variable_gv-facebookLogin_value == "true" ? pingone_identity_provider.facebook[0].id : "N/A"
  pingone_identity_provider_google_id                          = var.davinci_variable_gv-googleLogin_value == "true" ? pingone_identity_provider.google[0].id : "N/A"
  pingone_password_policy_standard_password_policy             = jsonencode(data.pingone_password_policy.standard_password_policy)
  pingone_population_default_population_id                     = data.pingone_population.default_population.id
  pingone_agreement_master_flow_agreement_id                   = pingone_agreement.master_flow_agreement.id
  pingone_verify_policy_default_id                             = data.pingone_verify_policy.default_policy.id

  # TFVars
  dv_admin_username                                  = var.dv_admin_username
  dv_admin_password                                  = var.dv_admin_password
  admin_environment_id                               = var.admin_environment_id
  region                                             = var.region
  davinci_connection_PingOne_region                  = var.davinci_connection_PingOne_region
  davinci_variable_availableQuestions_2_value        = var.davinci_variable_availableQuestions_2_value
  davinci_variable_gv-QA-On_value                    = var.davinci_variable_gv-QA-On_value
  davinci_variable_gv-protectAfterSocial             = var.davinci_variable_gv-protectAfterSocial
  davinci_variable_gv-fakeLevel                      = var.davinci_variable_gv-fakeLevel
  davinci_variable_gv-riskScreenDisplay              = var.davinci_variable_gv-riskScreenDisplay
  davinci_variable_gv-runVerifyUserRegistration      = var.davinci_variable_gv-runVerifyUserRegistration
  davinci_variable_gv-mfaOnHighRisk                  = var.davinci_variable_gv-mfaOnHighRisk
  davinci_variable_gv-autoEnrollEmail                = var.davinci_variable_gv-autoEnrollEmail
  davinci_variable_gv-registerAnotherDevice          = var.davinci_variable_gv-registerAnotherDevice
  davinci_variable_gv-verifyUserRegistration         = var.davinci_variable_gv-verifyUserRegistration
  davinci_variable_gv-isDeviceManagement             = var.davinci_variable_gv-isDeviceManagement
  davinci_variable_gv-allowPasswordless_value        = var.davinci_variable_gv-allowPasswordless_value
  davinci_variable_gv-azureLogin_value               = var.davinci_variable_gv-azureLogin_value
  davinci_variable_gv-companyLogo_value              = var.davinci_variable_gv-companyLogo_value
  davinci_variable_gv-companyName_value              = var.davinci_variable_gv-companyName_value
  davinci_variable_gv-consent_value                  = var.davinci_variable_gv-consent_value
  davinci_variable_gv-deviceManagement_value         = var.davinci_variable_gv-deviceManagement_value
  davinci_variable_gv-facebookLogin_value            = var.davinci_variable_gv-facebookLogin_value
  davinci_variable_gv-forcePasswordless_value        = var.davinci_variable_gv-forcePasswordless_value 
  davinci_variable_gv-forgotPasswordDisplay_value    = var.davinci_variable_gv-forgotPasswordDisplay_value
  davinci_variable_gv-forgotUsernameDisplay_value    = var.davinci_variable_gv-forgotUsernameDisplay_value
  davinci_variable_gv-githubLogin_value              = var.davinci_variable_gv-githubLogin_value
  davinci_variable_gv-googleLogin_value              = var.davinci_variable_gv-googleLogin_value
  davinci_variable_gv-inlineMFAOn_value              = var.davinci_variable_gv-inlineMFAOn_value
  davinci_variable_gv-mfa-on_value                   = var.davinci_variable_gv-mfa-on_value
  davinci_variable_gv-passwordlessAllowedTypes_value = var.davinci_variable_gv-passwordlessAllowedTypes_value
  davinci_variable_gv-progressiveProfiling_value     = var.davinci_variable_gv-progressiveProfiling_value
  davinci_variable_gv-riskLevel_value                = var.davinci_variable_gv-riskLevel_value
  davinci_variable_gv-runMFAforForgot_value          = var.davinci_variable_gv-runMFAforForgot_value
  davinci_variable_gv-runMFAforLogin_value           = var.davinci_variable_gv-runMFAforLogin_value
  davinci_variable_gv-runMFAforSocial_value          = var.davinci_variable_gv-runMFAforSocial_value
  davinci_variable_gv-runPasswordExpire_value        = var.davinci_variable_gv-runPasswordExpire_value
  davinci_variable_gv-runProtect_value               = var.davinci_variable_gv-runProtect_value
  davinci_variable_gv-runVerifyforHighRisk_value     = var.davinci_variable_gv-runVerifyforHighRisk_value
  davinci_variable_gv-standardForgotPassword_value   = var.davinci_variable_gv-standardForgotPassword_value
  davinci_variable_gv-webAuthnSupport_value          = var.davinci_variable_gv-webAuthnSupport_value
  davinci_variable_origin_2_value                    = var.davinci_variable_origin_2_value
  davinci_variable_origin_value                      = var.davinci_variable_origin_value
  davinci_variable_relyingParty_value                = var.davinci_variable_relyingParty_value
  davinci_variable_rpid_value                        = var.davinci_variable_rpid_value
  davinci_variable_showRegButton_value               = var.davinci_variable_showRegButton_value
  davinci_variable_stopSign_value                    = var.davinci_variable_stopSign_value
  davinci_variable_gv-captchaThreshold               = var.davinci_variable_gv-captchaThreshold
  davinci_variable_gv-reCaptcha                      = var.davinci_variable_gv-reCaptcha
  davinci_variable_gv-captchaV3SiteKey               = var.davinci_variable_gv-captchaV3SiteKey
  davinci_variable_gv-autoEnrollEmailMFA             = var.davinci_variable_gv-autoEnrollEmailMFA
  davinci_variable_gv-agreement                      = var.davinci_variable_gv-agreement
}

module "davinci_flows" {
  source = "./modules/davinci/flows"
  
  # PingOne
  pingone_environment_master_flow_environment_id               = pingone_environment.master_flow_environment.id

  # DaVinci
  davinci_connection_Annotation_id               = module.davinci.davinci_connection_Annotation_id
  davinci_connection_Error-Message_id            = module.davinci.davinci_connection_Error-Message_id
  davinci_connection_Functions_id                = module.davinci.davinci_connection_Functions_id
  davinci_connection_Http_id                     = module.davinci.davinci_connection_Http_id
  davinci_connection_Challenge_id                = module.davinci.davinci_connection_Challenge_id
  davinci_connection_Flow-Connector_id           = module.davinci.davinci_connection_Flow-Connector_id
  davinci_connection_Node_id                     = module.davinci.davinci_connection_Node_id
  davinci_connection_Variables_id                = module.davinci.davinci_connection_Variables_id
  davinci_connection_PingOne_id                  = module.davinci.davinci_connection_PingOne_id
  davinci_connection_PingOne-MFA_id              = module.davinci.davinci_connection_PingOne-MFA_id
  davinci_connection_PingOne-Authorize_id        = module.davinci.davinci_connection_PingOne-Authorize_id
  davinci_connection_PingOne-Notifications_id    = module.davinci.davinci_connection_PingOne-Notifications_id
  davinci_connection_PingOne-Verify_id           = module.davinci.davinci_connection_PingOne-Verify_id
  davinci_connection_PingOne-Protect_id          = module.davinci.davinci_connection_PingOne-Protect_id
  davinci_connection_PingOne-Authentication_id   = module.davinci.davinci_connection_PingOne-Authentication_id
  davinci_connections_read_connections           = module.davinci.davinci_connections_read_connections
  # TFVars
  dv_admin_username                                  = var.dv_admin_username
  dv_admin_password                                  = var.dv_admin_password
  admin_environment_id                               = var.admin_environment_id
  region                                             = var.region
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

data "pingone_role" "environment_admin" {
  name = "Environment Admin"
}

data "pingone_role" "identity_data_admin" {
  name = "Identity Data Admin"
}

data "pingone_role" "client_application_developer" {
  name = "Client Application Developer"
}

data "pingone_verify_policy" "default_policy" {
  environment_id = pingone_environment.master_flow_environment.id
  default        = true
}

#############
#  Outputs  #
#############

output "environment_name" {
  value = pingone_environment.master_flow_environment.name
}

output "initiate_flow_uri" {
  value = "https://apps.pingone.com/${pingone_environment.master_flow_environment.id}/myaccount/"
}

output "google_callback_url" {
  value = var.davinci_variable_gv-googleLogin_value == "true" ? "https://auth.pingone.com/${pingone_environment.master_flow_environment.id}/rp/callback/google" : "N/A"
}

output "facebook_callback_url" {
  value = var.davinci_variable_gv-facebookLogin_value == "true" ? "https://auth.pingone.com/${pingone_environment.master_flow_environment.id}/rp/callback/facebook" : "N/A"
}

output "facile_decoder_url" {
  value = "https://decoder.pingidentity.cloud/webhooks/${pingone_environment.master_flow_environment.id}"
}

###################
#  PingOne Users  #
###################

resource "pingone_user" "master_flow_user" {
  environment_id = pingone_environment.master_flow_environment.id

  population_id = data.pingone_population.default_population.id

  email    = var.master_flow_user_email
  username = var.master_flow_user_email
  password = {
    force_change  = var.master_flow_user_password_force_change == "" ? null : var.master_flow_user_password_force_change
    initial_value = var.master_flow_user_password == "" ? null : var.master_flow_user_password
  }
  name = {
    given            = var.master_flow_user_given_name == "" ? null : var.master_flow_user_given_name
    family           = var.master_flow_user_family_name == "" ? null : var.master_flow_user_family_name
    middle           = var.master_flow_user_middle_name == "" ? null : var.master_flow_user_middle_name
    formatted        = var.master_flow_user_formatted_name == "" ? null : var.master_flow_user_formatted_name
    honorific_prefix = var.master_flow_user_honorific_prefix == "" ? null : var.master_flow_user_honorific_prefix
    honorific_suffix = var.master_flow_user_honorific_suffix == "" ? null : var.master_flow_user_honorific_suffix
  }
  title         = var.master_flow_user_title == "" ? null : var.master_flow_user_title
  nickname      = var.master_flow_user_nickname == "" ? null : var.master_flow_user_nickname

  mobile_phone  = var.master_flow_user_mobile_phone == "" ? null : var.master_flow_user_mobile_phone
  primary_phone = var.master_flow_user_primary_phone == "" ? null : var.master_flow_user_primary_phone
  mfa_enabled   = var.master_flow_user_mfa_enabled == "" ? null : var.master_flow_user_mfa_enabled

  address = {
    street_address = var.master_flow_user_street_address == "" ? null : var.master_flow_user_street_address
    locality       = var.master_flow_user_address_locality == "" ? null : var.master_flow_user_address_locality
    region         = var.master_flow_user_address_region == "" ? null : var.master_flow_user_address_region
    postal_code    = var.master_flow_user_address_postal_code == "" ? null : var.master_flow_user_address_postal_code
    country_code   = var.master_flow_user_address_country_code == "" ? null : var.master_flow_user_address_country_code
  }
  locale  = var.master_flow_user_locale == "" ? null : var.master_flow_user_locale
  

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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
  
  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_identity_provider" "facebook" {
  count = var.davinci_variable_gv-facebookLogin_value == "true" ? 1 : 0
  environment_id = pingone_environment.master_flow_environment.id

  name    = "Facebook"
  enabled = true

  facebook {
    app_id     = var.facebook_app_id
    app_secret = var.facebook_app_secret
  }
  registration_population_id = data.pingone_population.default_population.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

#######################
#  PingOne Agreement  #
#######################

data "pingone_language" "en" {
  environment_id = pingone_environment.master_flow_environment.id
  locale = "en"

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_agreement" "master_flow_agreement" {
  environment_id = pingone_environment.master_flow_environment.id

  name        = "Terms and Conditions"
  description = "An agreement for general Terms and Conditions"

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_agreement_localization" "master_flow_agreement_en" {
  environment_id = pingone_environment.master_flow_environment.id
  agreement_id   = pingone_agreement.master_flow_agreement.id
  language_id    = data.pingone_language.en.id

  display_name = "Terms and Conditions - English Locale"

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_agreement_localization_revision" "master_flow_agreement_en_now" {
  environment_id            = pingone_environment.master_flow_environment.id
  agreement_id              = pingone_agreement.master_flow_agreement.id
  agreement_localization_id = pingone_agreement_localization.master_flow_agreement_en.id

  content_type      = "text/html"
  require_reconsent = true
  text              = var.pingone_agreement_localization_revision_master_flow_agreement_en_now_text

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_agreement_localization_enable" "master_flow_agreement_en_enable" {
  environment_id            = pingone_environment.master_flow_environment.id
  agreement_id              = pingone_agreement.master_flow_agreement.id
  agreement_localization_id = pingone_agreement_localization.master_flow_agreement_en.id

  enabled = true

  depends_on = [
    pingone_agreement_localization_revision.master_flow_agreement_en_now,
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_agreement_enable" "master_flow_agreement_enable" {
  environment_id = pingone_environment.master_flow_environment.id
  agreement_id   = pingone_agreement.master_flow_agreement.id

  enabled = true

  depends_on = [
    pingone_agreement_localization_enable.master_flow_agreement_en_enable,
    pingone_webhook.master_flow_webhook
  ]
}

#############
#  Webhook  #
#############

resource "pingone_webhook" "master_flow_webhook" {
  environment_id          = pingone_environment.master_flow_environment.id

  name                    = "Facile Decoder"
  enabled                 = true
  verify_tls_certificates = false

  http_endpoint_url       = "https://decoder.pingidentity.cloud/webhooks"

  format                  = "ACTIVITY"

  filter_options {
    included_action_types = ["ACCOUNT.LINKED", "ACCOUNT.UNLINKED", "ACTION.CREATED", "ACTION.DELETED", "ACTION.UPDATED", "ADVANCEDSERVICES_ORCHESTRATION.CREATION_COMPLETED", "ADVANCEDSERVICES_ORCHESTRATION.CREATION_FAILED", "ADVANCEDSERVICES_ORCHESTRATION.CREATION_STARTED", "ADVANCEDSERVICES_ORCHESTRATION.CREATION_START_FAILED", "ADVANCEDSERVICES_ORCHESTRATION.DELETION_COMPLETED", "ADVANCEDSERVICES_ORCHESTRATION.DELETION_FAILED", "ADVANCEDSERVICES_ORCHESTRATION.DELETION_STARTED", "ADVANCEDSERVICES_ORCHESTRATION.DELETION_START_FAILED", "AGREEMENT.CREATED", "AGREEMENT.DELETED", "AGREEMENT.UPDATED", "AGREEMENT_CONSENT.ACCEPTED", "AGREEMENT_CONSENT.REVOKED", "AGREEMENT_LANGUAGE.CREATED", "AGREEMENT_LANGUAGE.DELETED", "AGREEMENT_LANGUAGE.UPDATED", "AGREEMENT_LANGUAGE_REVISION.CREATED", "AGREEMENT_LANGUAGE_REVISION.DELETED", "AGREEMENT_LANGUAGE_REVISION.UPDATED", "API_ACCESS_LOG_ENTRY.HTTP_REQUEST_POLICY_EVALUATED", "API_ACCESS_LOG_ENTRY.HTTP_RESPONSE_POLICY_EVALUATED", "API_SERVER.CREATED", "API_SERVER.DELETED", "API_SERVER.POLICIES_DEPLOYED", "API_SERVER.UPDATED", "APPLICATION.CREATED", "APPLICATION.DELETED", "APPLICATION.PLAY_INTEGRITY_MISCONFIGURATION", "APPLICATION.UPDATED", "APPLICATION_PERMISSION.CREATED", "APPLICATION_PERMISSION.DELETED", "APPLICATION_ROLE.CREATED", "APPLICATION_ROLE_ENTRY.ADDED", "APPLICATION_ROLE_ENTRY.REMOVED", "ASSERTION.CHECK_FAILED", "ASSERTION.CHECK_SUCCESS", "AUTHENTICATION.CREATED", "AUTHENTICATION.UPDATED", "AUTHENTICATION_CODE.CREATED", "AUTHENTICATION_CODE.DELETED", "AUTHENTICATION_CODE.UPDATED", "AUTHORIZE_ATTRIBUTE.CREATED", "AUTHORIZE_ATTRIBUTE.DELETED", "AUTHORIZE_ATTRIBUTE.UPDATED", "AUTHORIZE_CONDITION.CREATED", "AUTHORIZE_CONDITION.DELETED", "AUTHORIZE_CONDITION.UPDATED", "AUTHORIZE_POLICY.CREATED", "AUTHORIZE_POLICY.DELETED", "AUTHORIZE_POLICY.UPDATED", "AUTHORIZE_PROCESSOR.CREATED", "AUTHORIZE_PROCESSOR.DELETED", "AUTHORIZE_PROCESSOR.UPDATED", "AUTHORIZE_SERVICE.CREATED", "AUTHORIZE_SERVICE.DELETED", "AUTHORIZE_SERVICE.UPDATED", "AUTHORIZE_SHARED_ADVICE.CREATED", "AUTHORIZE_SHARED_ADVICE.DELETED", "AUTHORIZE_SHARED_ADVICE.UPDATED", "AUTHORIZE_SHARED_RULE.CREATED", "AUTHORIZE_SHARED_RULE.DELETED", "AUTHORIZE_SHARED_RULE.UPDATED", "AUTHORIZE_TAG.DELETED", "AUTHORIZE_TAG.UPDATED", "BRANDING.DELETED", "BRANDING.UPDATED", "CERTIFICATE.CREATED", "CERTIFICATE.DELETED", "CERTIFICATE.READ", "CERTIFICATE.UPDATED", "CONTENT.CREATED", "CONTENT.DELETED", "CONTENT.UPDATED", "CONTENTS.DELETED", "CONTENTS.UPDATED", "CREDENTIAL_TYPE.CREATED", "CREDENTIAL_TYPE.DELETED", "CREDENTIAL_TYPE.UPDATED", "CUSTOM_DOMAIN.CREATED", "CUSTOM_DOMAIN.DELETED", "CUSTOM_DOMAIN.UPDATED", "DAVINCI_INTERACTION.CUSTOM_ANALYTICS", "DAVINCI_INTERACTION.RECEIVE_REQUEST", "DAVINCI_INTERACTION.SEND_ERROR_RESPONSE", "DAVINCI_INTERACTION.SEND_RESPONSE", "DAVINCI_INTERACTION.START_INTERACTION", "DECISION_ENDPOINT.CREATED", "DECISION_ENDPOINT.DECISION_REQUEST_EVALUATED", "DECISION_ENDPOINT.DELETED", "DECISION_ENDPOINT.UPDATED", "DEVICE.ACTIVATED", "DEVICE.ACTIVATION_FAILED", "DEVICE.ACTIVATION_OTP_FAILED", "DEVICE.ACTIVATION_OTP_INVALID", "DEVICE.BLOCKED", "DEVICE.CREATED", "DEVICE.DELETED", "DEVICE.FRAUD_REPORTED", "DEVICE.KEY_ROTATION_FAILED", "DEVICE.KEY_ROTATION_SUCCEEDED", "DEVICE.LOCKED", "DEVICE.LOGS_RECEIVED", "DEVICE.NICKNAME_UPDATED", "DEVICE.PAIRING_FAILED_COMPROMISED", "DEVICE.UNBLOCKED", "DEVICE.UNLOCKED", "DEVICE.UPDATED", "DEVICE.WEBAUTHN_UPDATED", "DEVICES.ORDER_CREATED", "DEVICES.ORDER_DELETED", "DEVICES.ORDER_UPDATED", "DEVICE_AUTHENTICATION_POLICY.CREATED", "DEVICE_AUTHENTICATION_POLICY.DELETED", "DEVICE_AUTHENTICATION_POLICY.UPDATED", "DIGITAL_WALLET.ACTIVE", "DIGITAL_WALLET.DELETED", "DIGITAL_WALLET.DISABLED", "DIGITAL_WALLET.EXPIRED", "DIGITAL_WALLET.PAIRING_REQUIRED", "DIGITAL_WALLET_APPLICATION.CREATED", "DIGITAL_WALLET_APPLICATION.DELETED", "DIGITAL_WALLET_APPLICATION.UPDATED", "EMAIL_DOMAIN.CREATED", "EMAIL_DOMAIN.DELETED", "ENVIRONMENT.CAPABILITIES", "ENVIRONMENT.CREATED", "ENVIRONMENT.DELETED", "ENVIRONMENT.DEMOTED", "ENVIRONMENT.PROMOTED", "ENVIRONMENT.UPDATED", "FIDO_METADATA.CREATED", "FIDO_METADATA.DELETED", "FIDO_POLICY.CREATED", "FIDO_POLICY.DELETED", "FIDO_POLICY.UPDATED", "FLOW.CREATED", "FLOW.DELETED", "FLOW.UPDATED", "FLOW_DEFINITION.CREATED", "FLOW_DEFINITION.DELETED", "FLOW_DEFINITION.UPDATED", "FLOW_EXECUTION.CREATED", "FLOW_EXECUTION.UPDATED", "FLOW_POLICY_ASSIGNMENT.CREATED", "FLOW_POLICY_ASSIGNMENT.DELETED", "FLOW_POLICY_ASSIGNMENT.UPDATED", "GATEWAY.CREATED", "GATEWAY.DELETED", "GATEWAY.UPDATED", "GATEWAY_INSTANCE.CREATED", "GATEWAY_INSTANCE.DELETED", "GATEWAY_INSTANCE.UPDATED", "GRANT.CREATED", "GRANT.DELETED", "GRANT.UPDATED", "GROUP.CREATED", "GROUP.DELETED", "GROUP.UPDATED", "IDENTITY_PROVIDER.CREATED", "IDENTITY_PROVIDER.DELETED", "IDENTITY_PROVIDER.UPDATED", "IDP_ATTRIBUTE.CREATED", "IDP_ATTRIBUTE.DELETED", "IDP_ATTRIBUTE.UPDATED", "IMAGE.ACTIVATED", "IMAGE.CREATED", "IMAGE.DELETED", "INSTANT_MESSAGING_DELIVERY_SETTINGS.CREATED", "INSTANT_MESSAGING_DELIVERY_SETTINGS.DELETED", "INSTANT_MESSAGING_DELIVERY_SETTINGS.UPDATED", "ISSUANCE.CREATED", "ISSUANCE_RULE.CREATED", "ISSUANCE_RULE.DELETED", "ISSUANCE_RULE.UPDATED", "KEY.CREATED", "KEY.DELETED", "KEY.READ", "KEY.UPDATED", "KRP.CREATED", "KRP.DELETED", "KRP.ROTATED", "KRP.UPDATED", "LICENSE.CREATED", "LICENSE.DELETED", "LICENSE.UPDATED", "MEMBER_OF_GROUP.CREATED", "MEMBER_OF_GROUP.DELETED", "MFA_SETTINGS.UPDATED", "NOTIFICATION.CREATED", "NOTIFICATION.REJECTED", "NOTIFICATION.UPDATED", "NOTIFICATIONS_SETTINGS.UPDATED", "NOTIFICATION_POLICY.CREATED", "NOTIFICATION_POLICY.DELETED", "NOTIFICATION_POLICY.UPDATED", "OAUTH_CONSENT.ACCEPTED", "OAUTH_CONSENT.DECLINED", "OAUTH_CONSENT.DELETED", "OAUTH_CONSENT.REVOKED", "ORGANIZATION.CAPABILITIES", "ORGANIZATION.CREATED", "ORGANIZATION.DELETED", "ORGANIZATION.UPDATED", "OTP.CHECK_FAILED", "OTP.CHECK_INVALID", "OTP.CHECK_SUCCESS", "PASSWORD.CHECK_FAILED", "PASSWORD.CHECK_SUCCEEDED", "PASSWORD.FORCE_CHANGE", "PASSWORD.RECOVERY", "PASSWORD.RESET", "PASSWORD.SET", "PASSWORD.UNLOCKED", "PASSWORD.UNSET", "PHONE_DELIVERY_SETTINGS.CREATED", "PHONE_DELIVERY_SETTINGS.DELETED", "PHONE_DELIVERY_SETTINGS.UPDATED", "POLICY.CREATED", "POLICY.DELETED", "POLICY.UPDATED", "POPULATION.CREATED", "POPULATION.DELETED", "POPULATION.UPDATED", "PROVISIONING_CONNECTION.CREATED", "PROVISIONING_CONNECTION.DELETED", "PROVISIONING_CONNECTION.UPDATED", "PROVISIONING_GROUP_MEMBERSHIP_SYNC.FAILURE", "PROVISIONING_GROUP_SYNC.FAILURE", "PROVISIONING_IDENTITY_SYNC.FAILURE", "PROVISIONING_MAPPING.CREATED", "PROVISIONING_MAPPING.DELETED", "PROVISIONING_MAPPING.UPDATED", "PROVISIONING_POLL.FAILURE", "PROVISIONING_RULE.CREATED", "PROVISIONING_RULE.DELETED", "PROVISIONING_RULE.UPDATED", "PROVISIONING_SYNC.FAILURE", "PROVISIONING_SYNC.STARTED", "PROVISION_CREDENTIAL.ACCEPTED", "PROVISION_CREDENTIAL.CREATED", "PROVISION_CREDENTIAL.DELETED", "PROVISION_CREDENTIAL.DELETED_FROM_WALLET", "PROVISION_CREDENTIAL.REJECTED", "PROVISION_CREDENTIAL.REVOKED", "PUSH_CREDENTIALS.CREATED", "PUSH_CREDENTIALS.DELETED", "PUSH_CREDENTIALS.UPDATED", "RADIUS_SESSION.CREATED", "RADIUS_SESSION.UPDATED", "RESCUE_IDENTITY.CREATED", "RESOURCE.CREATED", "RESOURCE.DELETED", "RESOURCE.UPDATED", "RESOURCE_ATTRIBUTE.CREATED", "RESOURCE_ATTRIBUTE.DELETED", "RESOURCE_ATTRIBUTE.UPDATED", "RISK_EVALUATION.CREATED", "RISK_EVALUATION.STAGING_CREATED", "RISK_EVALUATION.UPDATED", "RISK_POLICY_SET.CREATED", "RISK_POLICY_SET.DELETED", "RISK_POLICY_SET.UPDATED", "RISK_PREDICTOR.CREATED", "RISK_PREDICTOR.DELETED", "RISK_PREDICTOR.UPDATED", "ROLE_ASSIGNMENT.CREATED", "ROLE_ASSIGNMENT.DELETED", "SAML_ATTRIBUTE.CREATED", "SAML_ATTRIBUTE.DELETED", "SAML_ATTRIBUTE.UPDATED", "SCHEMA_ATTRIBUTE.CREATED", "SCHEMA_ATTRIBUTE.DELETED", "SCHEMA_ATTRIBUTE.UPDATED", "SCOPE.CREATED", "SCOPE.DELETED", "SCOPE.UPDATED", "SECRET.READ", "SECRET.UPDATED", "SEEN_DEVICE.CREATED", "SEEN_DEVICE.DELETED", "SEEN_DEVICE.UPDATED", "SESSION.CREATED", "SESSION.DELETED", "SESSION.UPDATED", "SETTINGS.CREATED", "SETTINGS.UPDATED", "SIGN_ON_POLICY_ASSIGNMENT.CREATED", "SIGN_ON_POLICY_ASSIGNMENT.DELETED", "SIGN_ON_POLICY_ASSIGNMENT.UPDATED", "SOLUTIONS_WORKFLOW.CREATION_SUCCESS", "SOLUTIONS_WORKFLOW.RETRIEVE_FAILED", "SOLUTIONS_WORKFLOW.RETRIEVE_SUCCESS", "SOLUTIONS_WORKFLOW.UPDATE_SUCCESS", "STAGED_CHANGE.COMPLETED", "STAGED_CHANGE.CREATED", "STAGED_CHANGE.DELETED", "STAGED_CHANGE.FAILED", "STAGED_CHANGE.UPDATED", "SUBSCRIPTION.CREATED", "SUBSCRIPTION.DELETED", "SUBSCRIPTION.UPDATED", "THEME.CREATED", "THEME.DELETED", "THEME.UPDATED", "TRUSTED_EMAIL.ACTIVE", "TRUSTED_EMAIL.CREATED", "TRUSTED_EMAIL.DELETED", "TRUSTED_EMAIL.SEND_CODE", "USER.ACCESS_ALLOWED", "USER.ACCESS_DENIED", "USER.CREATED", "USER.DELETED", "USER.LOCKED", "USER.MOVED", "USER.QUOTA_RESET", "USER.SLO_FAILURE", "USER.SLO_REQUESTED", "USER.SLO_SUCCESS", "USER.UNLOCKED", "USER.UPDATED", "USER_CREDENTIAL.DELETED", "USER_CREDENTIAL.ISSUED", "USER_CREDENTIAL.PENDING", "USER_CREDENTIAL.REVOKED", "USER_SEEN_DEVICE.CREATED", "USER_SEEN_DEVICE.DELETED", "USER_SEEN_DEVICE.UPDATED", "VALIDATION_TRANSACTION.CREATED", "VALIDATION_TRANSACTION.DELETED", "VALIDATION_TRANSACTION.UPDATED", "VERIFY_APPEVENT.CREATED", "VERIFY_METADATA.CREATED", "VERIFY_POLICY.CREATED", "VERIFY_POLICY.DELETED", "VERIFY_POLICY.UPDATED"]
  }
}

##################
#  Applications  #
##################

resource "pingone_application" "master_flow_webhook_link" {
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne Facile Decoder"
  enabled        = true

  external_link_options {
    home_page_url = "https://decoder.pingidentity.cloud/webhooks/${pingone_environment.master_flow_environment.id}"
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_application_role_assignment" "id_admin" {
  environment_id = pingone_environment.master_flow_environment.id
  application_id = pingone_application.dv_worker_app.id
  role_id        = data.pingone_role.identity_data_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_application_role_assignment" "env_admin" {
  environment_id = pingone_environment.master_flow_environment.id
  application_id = pingone_application.dv_worker_app.id
  role_id        = data.pingone_role.environment_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_application_flow_policy_assignment" "oidc_app" {
  environment_id = pingone_environment.master_flow_environment.id
  application_id = pingone_application.oidc_app.id

  flow_policy_id = davinci_application_flow_policy.PingOne-SSO-Flow-Policy.id

  priority = 1

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
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
    module.davinci.davinci_connections_read_connections
  ]
}

resource "davinci_application_flow_policy" "PingOne-SSO-Flow-Policy" {
  environment_id = pingone_environment.master_flow_environment.id
  application_id = davinci_application.PingOne-SSO-Connection.id
  name           = "PingOne SSO Connection"
  status         = "enabled"
  policy_flow {
    flow_id    = module.davinci_flows.davinci_flow_PingOne-SSO-Authentication-MASTER_id
    version_id = -1
    weight     = 100
  }

  depends_on = [
    module.davinci.davinci_connections_read_connections
  ]
}