resource "pingone_environment" "master_flow_environment" {         
  name        = var.environment_name
  description = var.environment_description
  type        = var.environment_type
  license_id  = var.license_id != "" ? var.license_id : data.pingone_licenses.internal_license.ids[0]

  services = [
    {
      type = "SSO"
    },
    {
      type = "MFA"
    },
    {
      type = "DaVinci",
      tags  = ["DAVINCI_MINIMAL"]
    },
      {
      type = "Verify"
    },    
    {
      type = "Risk"
    },
    {
      type = "Credentials"
    }
  ]
}

resource "pingone_user_role_assignment" "id_admin" {
  environment_id = var.pingone_environment_id != "" ? var.pingone_environment_id : var.pingone_environment_id
  user_id        = var.admin_user_id
  role_id        = data.pingone_role.identity_data_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_user_role_assignment" "app_dev" {
  environment_id = var.pingone_environment_id != "" ? var.pingone_environment_id : var.pingone_environment_id
  user_id        = var.admin_user_id
  role_id        = data.pingone_role.client_application_developer.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_user_role_assignment" "env_admin" {
  environment_id = var.pingone_environment_id != "" ? var.pingone_environment_id : var.pingone_environment_id
  user_id        = var.admin_user_id
  role_id        = data.pingone_role.environment_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_user_role_assignment" "davinci_admin" {
  environment_id = var.pingone_environment_id != "" ? var.pingone_environment_id : var.pingone_environment_id
  user_id        = var.admin_user_id
  role_id        = data.pingone_role.davinci_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_group_role_assignment" "id_admin" {
  environment_id = var.admin_environment_id != "" ? var.admin_environment_id : var.admin_environment_id
  group_id        = var.admin_group_id
  role_id        = data.pingone_role.identity_data_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_group_role_assignment" "app_dev" {
  environment_id = var.admin_environment_id != "" ? var.admin_environment_id : var.admin_environment_id
  group_id        = var.admin_group_id
  role_id        = data.pingone_role.client_application_developer.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_group_role_assignment" "env_admin" {
  environment_id = var.admin_environment_id != "" ? var.admin_environment_id : var.admin_environment_id
  group_id        = var.admin_group_id
  role_id        = data.pingone_role.environment_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_group_role_assignment" "davinci_admin" {
  environment_id = var.admin_environment_id != "" ? var.admin_environment_id : var.admin_environment_id
  group_id        = var.admin_group_id
  role_id        = data.pingone_role.davinci_admin.id

  scope_environment_id = pingone_environment.master_flow_environment.id

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

#################
#  Populations  #
#################

resource "pingone_population_default" "master_flow_default_population" {
  environment_id = pingone_environment.master_flow_environment.id

  name        = "My default population"
  description = "A resource that overwrites the default population"
}

resource "pingone_population" "ciam_population" {
  environment_id = pingone_environment.master_flow_environment.id
  
  name        = "CIAM"
  description = "A population for CIAM users"
}

##################
#  Data Sources  #
##################

data "pingone_licenses" "internal_license" {
  organization_id = var.organization_id
  # If the license ID is empty, grab the license ID from the TF environment. If the license ID is present, we don't really care, we'll use var.license_id elsewhere. 
  scim_filter     = var.license_id != "" ? "(status eq \"active\")" : "(status eq \"active\") and (envId eq \"${var.pingone_environment_id}\")"
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

data "pingone_role" "davinci_admin" {
  name = "DaVinci Admin"
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
  value = var.davinci_variable_gv-googleLogin == "true" ? "https://auth.pingone.com/${pingone_environment.master_flow_environment.id}/rp/callback/google" : null
}

output "facebook_callback_url" {
  value = var.davinci_variable_gv-facebookLogin == "true" ? "https://auth.pingone.com/${pingone_environment.master_flow_environment.id}/rp/callback/facebook" : null
}

output "webhook_decoder_url" {
  value = "https://decoder.pingidentity.cloud/webhooks/${pingone_environment.master_flow_environment.id}"
}

###################
#  PingOne Users  #
###################

resource "pingone_user" "master_flow_user" {
  environment_id = pingone_environment.master_flow_environment.id

  population_id = pingone_population_default.master_flow_default_population.id

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

#########################
#  PingOne User Groups  #
#########################

resource "pingone_group" "pingone_admin_group" {
  environment_id = pingone_environment.master_flow_environment.id

  name        = "Admin Group"
  description = "Group used for Authorize Policy, filter to add all enabled users as they are created."

  user_filter = "enabled eq true"
}

########################
#  PingOne MFA Policy  #
########################

resource "pingone_mfa_device_policy" "master_flow_mfa_policy" {
  environment_id          = pingone_environment.master_flow_environment.id
  name                    = "Master Flow MFA Policy"
  new_device_notification = "EMAIL_THEN_SMS"

  authentication = {
    device_selection        = "ALWAYS_DISPLAY_DEVICES"
  }

  mobile = {
    enabled = false
  }

  totp = {
    enabled = true
  }

  fido2 = {
    enabled = true
  }

  sms = {
    enabled = true
  }

  voice = {
    enabled = true
  }

  email = {
    enabled = true
  }
}

resource "pingone_mfa_settings" "mfa_settings" {
  environment_id = pingone_environment.master_flow_environment.id

  pairing = {
    max_allowed_devices = 10
    pairing_key_format  = "ALPHANUMERIC"
  }

  users = {
    mfa_enabled = true
  }
}

resource "pingone_mfa_device_policy" "master_flow_passwordless_mfa_policy" {
  environment_id          = pingone_environment.master_flow_environment.id
  name                    = "Master Flow Passwordless Policy"
  new_device_notification = "EMAIL_THEN_SMS"
  authentication = {
    device_selection        = "DEFAULT_TO_FIRST"
  }

  mobile = {
    enabled = false
  }

  totp = {
    enabled = true
  }

  fido2 = {
    enabled = true
  }

  sms = {
    enabled = true
  }

  voice = {
    enabled = true
  }

  email = {
    enabled = true
  }
}

###########################
#  PingOne Verify Policy  #
###########################

resource "pingone_verify_policy" "liveness_verify_policy" {
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Liveness"
  description    = "Liveness Only"

  facial_comparison = {
    verify    = "REQUIRED"
    threshold = "MEDIUM"
  }

  liveness = {
    verify    = "REQUIRED"
    threshold = "MEDIUM"
  }

  transaction = {
    timeout = {
      duration  = "30"
      time_unit = "MINUTES"
    }

    data_collection = {
      timeout = {
        duration  = "15"
        time_unit = "MINUTES"
      }
    }

    data_collection_only = false
  }
}

############################
#  Social Login Providers  #
############################

resource "pingone_identity_provider" "google" {
  count = var.davinci_variable_gv-googleLogin == "true" ? 1 : 0
  environment_id = pingone_environment.master_flow_environment.id

  name    = "Google"
  enabled = true

  google = {
    client_id     = var.google_client_id == "" ? "client-id" : var.google_client_id
    client_secret = var.google_client_secret == "" ? "client-secret" : var.google_client_secret
  }
  registration_population_id = pingone_population_default.master_flow_default_population.id
  
  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_identity_provider" "facebook" {
  count = var.davinci_variable_gv-facebookLogin == "true" ? 1 : 0
  environment_id = pingone_environment.master_flow_environment.id

  name    = "Facebook"
  enabled = true

  facebook = {
    app_id     = var.facebook_app_id == "" ? "app-id" : var.facebook_app_id
    app_secret = var.facebook_app_secret  == "" ? "app-secret" : var.facebook_app_secret
  }
  registration_population_id = pingone_population_default.master_flow_default_population.id

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

  # This allows you to rename your environment and do things like that without triggering a re-create on this, which errors because we need a localization
  lifecycle {
    ignore_changes = all
  }
}

resource "pingone_agreement_localization_revision" "master_flow_agreement_en_now" {
  environment_id            = pingone_environment.master_flow_environment.id
  agreement_id              = pingone_agreement.master_flow_agreement.id
  agreement_localization_id = pingone_agreement_localization.master_flow_agreement_en.id

  content_type      = "text/plain"
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

  filter_options = {
    included_action_types = ["ACCOUNT.LINKED", "ACCOUNT.UNLINKED", "ACTION.CREATED", "ACTION.DELETED", "ACTION.UPDATED", "ADVANCEDSERVICES_ORCHESTRATION.CREATION_COMPLETED", "ADVANCEDSERVICES_ORCHESTRATION.CREATION_FAILED", "ADVANCEDSERVICES_ORCHESTRATION.CREATION_STARTED", "ADVANCEDSERVICES_ORCHESTRATION.CREATION_START_FAILED", "ADVANCEDSERVICES_ORCHESTRATION.DELETION_COMPLETED", "ADVANCEDSERVICES_ORCHESTRATION.DELETION_FAILED", "ADVANCEDSERVICES_ORCHESTRATION.DELETION_STARTED", "ADVANCEDSERVICES_ORCHESTRATION.DELETION_START_FAILED", "AGREEMENT.CREATED", "AGREEMENT.DELETED", "AGREEMENT.UPDATED", "AGREEMENT_CONSENT.ACCEPTED", "AGREEMENT_CONSENT.REVOKED", "AGREEMENT_LANGUAGE.CREATED", "AGREEMENT_LANGUAGE.DELETED", "AGREEMENT_LANGUAGE.UPDATED", "AGREEMENT_LANGUAGE_REVISION.CREATED", "AGREEMENT_LANGUAGE_REVISION.DELETED", "AGREEMENT_LANGUAGE_REVISION.UPDATED", "API_ACCESS_LOG_ENTRY.HTTP_REQUEST_POLICY_EVALUATED", "API_ACCESS_LOG_ENTRY.HTTP_RESPONSE_POLICY_EVALUATED", "API_SERVER.CREATED", "API_SERVER.DELETED", "API_SERVER.POLICIES_DEPLOYED", "API_SERVER.UPDATED", "APPLICATION.CREATED", "APPLICATION.DELETED", "APPLICATION.PLAY_INTEGRITY_MISCONFIGURATION", "APPLICATION.UPDATED", "APPLICATION_PERMISSION.CREATED", "APPLICATION_PERMISSION.DELETED", "APPLICATION_ROLE.CREATED", "APPLICATION_ROLE_ENTRY.ADDED", "APPLICATION_ROLE_ENTRY.REMOVED", "ASSERTION.CHECK_FAILED", "ASSERTION.CHECK_SUCCESS", "AUTHENTICATION.CREATED", "AUTHENTICATION.UPDATED", "AUTHENTICATION_CODE.CREATED", "AUTHENTICATION_CODE.DELETED", "AUTHENTICATION_CODE.UPDATED", "AUTHORIZE_ATTRIBUTE.CREATED", "AUTHORIZE_ATTRIBUTE.DELETED", "AUTHORIZE_ATTRIBUTE.UPDATED", "AUTHORIZE_CONDITION.CREATED", "AUTHORIZE_CONDITION.DELETED", "AUTHORIZE_CONDITION.UPDATED", "AUTHORIZE_POLICY.CREATED", "AUTHORIZE_POLICY.DELETED", "AUTHORIZE_POLICY.UPDATED", "AUTHORIZE_PROCESSOR.CREATED", "AUTHORIZE_PROCESSOR.DELETED", "AUTHORIZE_PROCESSOR.UPDATED", "AUTHORIZE_SERVICE.CREATED", "AUTHORIZE_SERVICE.DELETED", "AUTHORIZE_SERVICE.UPDATED", "AUTHORIZE_SHARED_ADVICE.CREATED", "AUTHORIZE_SHARED_ADVICE.DELETED", "AUTHORIZE_SHARED_ADVICE.UPDATED", "AUTHORIZE_SHARED_RULE.CREATED", "AUTHORIZE_SHARED_RULE.DELETED", "AUTHORIZE_SHARED_RULE.UPDATED", "AUTHORIZE_TAG.DELETED", "AUTHORIZE_TAG.UPDATED", "BRANDING.DELETED", "BRANDING.UPDATED", "CERTIFICATE.CREATED", "CERTIFICATE.DELETED", "CERTIFICATE.READ", "CERTIFICATE.UPDATED", "CONTENT.CREATED", "CONTENT.DELETED", "CONTENT.UPDATED", "CONTENTS.DELETED", "CONTENTS.UPDATED", "CREDENTIAL_TYPE.CREATED", "CREDENTIAL_TYPE.DELETED", "CREDENTIAL_TYPE.UPDATED", "CUSTOM_DOMAIN.CREATED", "CUSTOM_DOMAIN.DELETED", "CUSTOM_DOMAIN.UPDATED", "DAVINCI_INTERACTION.CUSTOM_ANALYTICS", "DAVINCI_INTERACTION.RECEIVE_REQUEST", "DAVINCI_INTERACTION.SEND_ERROR_RESPONSE", "DAVINCI_INTERACTION.SEND_RESPONSE", "DAVINCI_INTERACTION.START_INTERACTION", "DECISION_ENDPOINT.CREATED", "DECISION_ENDPOINT.DECISION_REQUEST_EVALUATED", "DECISION_ENDPOINT.DELETED", "DECISION_ENDPOINT.UPDATED", "DEVICE.ACTIVATED", "DEVICE.ACTIVATION_FAILED", "DEVICE.ACTIVATION_OTP_FAILED", "DEVICE.ACTIVATION_OTP_INVALID", "DEVICE.BLOCKED", "DEVICE.CREATED", "DEVICE.DELETED", "DEVICE.FRAUD_REPORTED", "DEVICE.KEY_ROTATION_FAILED", "DEVICE.KEY_ROTATION_SUCCEEDED", "DEVICE.LOCKED", "DEVICE.LOGS_RECEIVED", "DEVICE.NICKNAME_UPDATED", "DEVICE.PAIRING_FAILED_COMPROMISED", "DEVICE.UNBLOCKED", "DEVICE.UNLOCKED", "DEVICE.UPDATED", "DEVICE.WEBAUTHN_UPDATED", "DEVICES.ORDER_CREATED", "DEVICES.ORDER_DELETED", "DEVICES.ORDER_UPDATED", "DEVICE_AUTHENTICATION_POLICY.CREATED", "DEVICE_AUTHENTICATION_POLICY.DELETED", "DEVICE_AUTHENTICATION_POLICY.UPDATED", "DIGITAL_WALLET.ACTIVE", "DIGITAL_WALLET.DELETED", "DIGITAL_WALLET.DISABLED", "DIGITAL_WALLET.EXPIRED", "DIGITAL_WALLET.PAIRING_REQUIRED", "DIGITAL_WALLET_APPLICATION.CREATED", "DIGITAL_WALLET_APPLICATION.DELETED", "DIGITAL_WALLET_APPLICATION.UPDATED", "EMAIL_DOMAIN.CREATED", "EMAIL_DOMAIN.DELETED", "ENVIRONMENT.CAPABILITIES", "ENVIRONMENT.CREATED", "ENVIRONMENT.DELETED", "ENVIRONMENT.DEMOTED", "ENVIRONMENT.PROMOTED", "ENVIRONMENT.UPDATED", "FIDO_METADATA.CREATED", "FIDO_METADATA.DELETED", "FIDO_POLICY.CREATED", "FIDO_POLICY.DELETED", "FIDO_POLICY.UPDATED", "FLOW.CREATED", "FLOW.DELETED", "FLOW.UPDATED", "FLOW_DEFINITION.CREATED", "FLOW_DEFINITION.DELETED", "FLOW_DEFINITION.UPDATED", "FLOW_EXECUTION.CREATED", "FLOW_EXECUTION.UPDATED", "FLOW_POLICY_ASSIGNMENT.CREATED", "FLOW_POLICY_ASSIGNMENT.DELETED", "FLOW_POLICY_ASSIGNMENT.UPDATED", "GATEWAY.CREATED", "GATEWAY.DELETED", "GATEWAY.UPDATED", "GATEWAY_INSTANCE.CREATED", "GATEWAY_INSTANCE.DELETED", "GATEWAY_INSTANCE.UPDATED", "GRANT.CREATED", "GRANT.DELETED", "GRANT.UPDATED", "GROUP.CREATED", "GROUP.DELETED", "GROUP.UPDATED", "IDENTITY_PROVIDER.CREATED", "IDENTITY_PROVIDER.DELETED", "IDENTITY_PROVIDER.UPDATED", "IDP_ATTRIBUTE.CREATED", "IDP_ATTRIBUTE.DELETED", "IDP_ATTRIBUTE.UPDATED", "IMAGE.ACTIVATED", "IMAGE.CREATED", "IMAGE.DELETED", "INSTANT_MESSAGING_DELIVERY_SETTINGS.CREATED", "INSTANT_MESSAGING_DELIVERY_SETTINGS.DELETED", "INSTANT_MESSAGING_DELIVERY_SETTINGS.UPDATED", "ISSUANCE.CREATED", "ISSUANCE_RULE.CREATED", "ISSUANCE_RULE.DELETED", "ISSUANCE_RULE.UPDATED", "KEY.CREATED", "KEY.DELETED", "KEY.READ", "KEY.UPDATED", "KRP.CREATED", "KRP.DELETED", "KRP.ROTATED", "KRP.UPDATED", "LICENSE.CREATED", "LICENSE.DELETED", "LICENSE.UPDATED", "MEMBER_OF_GROUP.CREATED", "MEMBER_OF_GROUP.DELETED", "MFA_SETTINGS.UPDATED", "NOTIFICATION.CREATED", "NOTIFICATION.REJECTED", "NOTIFICATION.UPDATED", "NOTIFICATIONS_SETTINGS.UPDATED", "NOTIFICATION_POLICY.CREATED", "NOTIFICATION_POLICY.DELETED", "NOTIFICATION_POLICY.UPDATED", "OAUTH_CONSENT.ACCEPTED", "OAUTH_CONSENT.DECLINED", "OAUTH_CONSENT.DELETED", "OAUTH_CONSENT.REVOKED", "ORGANIZATION.CAPABILITIES", "ORGANIZATION.CREATED", "ORGANIZATION.DELETED", "ORGANIZATION.UPDATED", "OTP.CHECK_FAILED", "OTP.CHECK_INVALID", "OTP.CHECK_SUCCESS", "PASSWORD.CHECK_FAILED", "PASSWORD.CHECK_SUCCEEDED", "PASSWORD.FORCE_CHANGE", "PASSWORD.RECOVERY", "PASSWORD.RESET", "PASSWORD.SET", "PASSWORD.UNLOCKED", "PASSWORD.UNSET", "PHONE_DELIVERY_SETTINGS.CREATED", "PHONE_DELIVERY_SETTINGS.DELETED", "PHONE_DELIVERY_SETTINGS.UPDATED", "POLICY.CREATED", "POLICY.DELETED", "POLICY.UPDATED", "POPULATION.CREATED", "POPULATION.DELETED", "POPULATION.UPDATED", "PROVISIONING_CONNECTION.CREATED", "PROVISIONING_CONNECTION.DELETED", "PROVISIONING_CONNECTION.UPDATED", "PROVISIONING_GROUP_MEMBERSHIP_SYNC.FAILURE", "PROVISIONING_GROUP_SYNC.FAILURE", "PROVISIONING_IDENTITY_SYNC.FAILURE", "PROVISIONING_MAPPING.CREATED", "PROVISIONING_MAPPING.DELETED", "PROVISIONING_MAPPING.UPDATED", "PROVISIONING_POLL.FAILURE", "PROVISIONING_RULE.CREATED", "PROVISIONING_RULE.DELETED", "PROVISIONING_RULE.UPDATED", "PROVISIONING_SYNC.FAILURE", "PROVISIONING_SYNC.STARTED", "PROVISION_CREDENTIAL.ACCEPTED", "PROVISION_CREDENTIAL.CREATED", "PROVISION_CREDENTIAL.DELETED", "PROVISION_CREDENTIAL.DELETED_FROM_WALLET", "PROVISION_CREDENTIAL.REJECTED", "PROVISION_CREDENTIAL.REVOKED", "PUSH_CREDENTIALS.CREATED", "PUSH_CREDENTIALS.DELETED", "PUSH_CREDENTIALS.UPDATED", "RADIUS_SESSION.CREATED", "RADIUS_SESSION.UPDATED", "RESCUE_IDENTITY.CREATED", "RESOURCE.CREATED", "RESOURCE.DELETED", "RESOURCE.UPDATED", "RESOURCE_ATTRIBUTE.CREATED", "RESOURCE_ATTRIBUTE.DELETED", "RESOURCE_ATTRIBUTE.UPDATED", "RISK_EVALUATION.CREATED", "RISK_EVALUATION.STAGING_CREATED", "RISK_EVALUATION.UPDATED", "RISK_POLICY_SET.CREATED", "RISK_POLICY_SET.DELETED", "RISK_POLICY_SET.UPDATED", "RISK_PREDICTOR.CREATED", "RISK_PREDICTOR.DELETED", "RISK_PREDICTOR.UPDATED", "ROLE_ASSIGNMENT.CREATED", "ROLE_ASSIGNMENT.DELETED", "SAML_ATTRIBUTE.CREATED", "SAML_ATTRIBUTE.DELETED", "SAML_ATTRIBUTE.UPDATED", "SCHEMA_ATTRIBUTE.CREATED", "SCHEMA_ATTRIBUTE.DELETED", "SCHEMA_ATTRIBUTE.UPDATED", "SCOPE.CREATED", "SCOPE.DELETED", "SCOPE.UPDATED", "SECRET.READ", "SECRET.UPDATED", "SESSION.CREATED", "SESSION.DELETED", "SESSION.UPDATED", "SETTINGS.CREATED", "SETTINGS.UPDATED", "SIGN_ON_POLICY_ASSIGNMENT.CREATED", "SIGN_ON_POLICY_ASSIGNMENT.DELETED", "SIGN_ON_POLICY_ASSIGNMENT.UPDATED", "SOLUTIONS_WORKFLOW.CREATION_SUCCESS", "SOLUTIONS_WORKFLOW.RETRIEVE_FAILED", "SOLUTIONS_WORKFLOW.RETRIEVE_SUCCESS", "SOLUTIONS_WORKFLOW.UPDATE_SUCCESS", "STAGED_CHANGE.COMPLETED", "STAGED_CHANGE.CREATED", "STAGED_CHANGE.DELETED", "STAGED_CHANGE.FAILED", "STAGED_CHANGE.UPDATED", "SUBSCRIPTION.CREATED", "SUBSCRIPTION.DELETED", "SUBSCRIPTION.UPDATED", "THEME.CREATED", "THEME.DELETED", "THEME.UPDATED", "TRUSTED_EMAIL.ACTIVE", "TRUSTED_EMAIL.CREATED", "TRUSTED_EMAIL.DELETED", "TRUSTED_EMAIL.SEND_CODE", "USER.ACCESS_ALLOWED", "USER.ACCESS_DENIED", "USER.CREATED", "USER.DELETED", "USER.LOCKED", "USER.MOVED", "USER.QUOTA_RESET", "USER.SLO_FAILURE", "USER.SLO_REQUESTED", "USER.SLO_SUCCESS", "USER.UNLOCKED", "USER.UPDATED", "USER_CREDENTIAL.DELETED", "USER_CREDENTIAL.ISSUED", "USER_CREDENTIAL.PENDING", "USER_CREDENTIAL.REVOKED", "VALIDATION_TRANSACTION.CREATED", "VALIDATION_TRANSACTION.DELETED", "VALIDATION_TRANSACTION.UPDATED", "VERIFY_APPEVENT.CREATED", "VERIFY_METADATA.CREATED", "VERIFY_POLICY.CREATED", "VERIFY_POLICY.DELETED", "VERIFY_POLICY.UPDATED"]
  }
}

##################
#  Applications  #
##################

resource "pingone_application" "master_flow_webhook_link" {
  environment_id = pingone_environment.master_flow_environment.id
  name           = "PingOne Facile Decoder"
  enabled        = true

  external_link_options = {
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

  oidc_options = {
    type                        = "WORKER"
    grant_types                 = ["CLIENT_CREDENTIALS"]
    token_endpoint_auth_method = "CLIENT_SECRET_BASIC"
  }

  icon = {
    id   = "c6dbb456-0857-4fab-bfb0-909944233017"
    href = "https://assets.pingone.com/ux/ui-library/4.18.0/images/logo-pingidentity.png"
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_application_secret" "dv_worker_app" {
  environment_id = pingone_environment.master_flow_environment.id
  application_id = pingone_application.dv_worker_app.id
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

# resource "pingone_application" "neo_worker_app" {
#   environment_id = pingone_environment.master_flow_environment.id
#   name           = "PingOne Neo Worker App"
#   enabled        = true

#   oidc_options = {
#     type                        = "WORKER"
#     grant_types                 = ["CLIENT_CREDENTIALS"]
#     token_endpoint_auth_method = "CLIENT_SECRET_BASIC"
#   }

#   icon = {
#     id   = "c6dbb456-0857-4fab-bfb0-909944233017"
#     href = "https://assets.pingone.com/ux/ui-library/4.18.0/images/logo-pingidentity.png"
#   }

#   depends_on = [
#     pingone_webhook.master_flow_webhook
#   ]
# }

# resource "pingone_application_role_assignment" "neo_id_admin" {
#   environment_id = pingone_environment.master_flow_environment.id
#   application_id = pingone_application.neo_worker_app.id
#   role_id        = data.pingone_role.identity_data_admin.id

#   scope_environment_id = pingone_environment.master_flow_environment.id

#   depends_on = [
#     pingone_webhook.master_flow_webhook
#   ]
# }

# resource "pingone_application_role_assignment" "neo_env_admin" {
#   environment_id = pingone_environment.master_flow_environment.id
#   application_id = pingone_application.neo_worker_app.id
#   role_id        = data.pingone_role.environment_admin.id

#   scope_environment_id = pingone_environment.master_flow_environment.id

#   depends_on = [
#     pingone_webhook.master_flow_webhook
#   ]
# }

resource "pingone_application" "oidc_app" {
  environment_id = pingone_environment.master_flow_environment.id
  enabled        = true
  name           = "Master Flow OIDC App"

  oidc_options = {
    type                        = "WEB_APP"
    grant_types                 = ["AUTHORIZATION_CODE"]
    response_types              = ["CODE"]
    token_endpoint_auth_method = "NONE"
    redirect_uris               = ["https://auth.pingone.com/${pingone_environment.master_flow_environment.id}/rp/callback/openid_connect"]
  }

  icon = {
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
  variant        = "Master Flow Device Pairing"


  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow Device Pairing.html")}"
    subject       = "PingOne: Finish pairing your device"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
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
  variant        = "Master Flow Email Verification User"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow Email Verification User.html")}"
    subject       = "PingOne: Verify your email address"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
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
  variant        = "Master Flow Magic Link"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow Magic Link.html")}"
    subject       = "PingOne: Magic Link MFA"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
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
  template_name  = "general"
  locale         = "en"
  variant        = "Master Flow New Device"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow New Device.html")}"
    subject       = "PingOne: New Device used to Authenticate"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
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
  variant        = "Master Flow Forgot Username"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow Forgot Username.html")}"
    subject       = "PingOne: Forgot Username"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

# resource "pingone_notification_template_content" "general_otp" {
#   environment_id = pingone_environment.master_flow_environment.id
#   template_name  = "general"
#   locale         = "en"
#   variant        = "OTP"

#   email = {
#     body          = "${file("${path.module}/data/notification_templates/general-otp.html")}"
#     subject       = "General OTP"
#     content_type  = "text/html"
#     character_set = "UTF-8"

#     from = {
#       name    = "PingOne"
#       address = "noreply@pingidentity.com"
#     }
    
#     reply_to = {
#       name    = "PingOne"
#       address = "noreply@pingidentity.com"
#     }
#   }

#   depends_on = [
#     pingone_webhook.master_flow_webhook
#   ]
# }

resource "pingone_notification_template_content" "strong_authentication" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "strong_authentication"
  locale         = "en"
  email = {
    body          = "${file("${path.module}/data/notification_templates/Strong Authentication.html")}"
    subject       = "Strong Authentication"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
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

  email = {
    body          = "${file("${path.module}/data/notification_templates/Verification Code.html")}"
    subject       = "PingOne: Verification Code"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

# resource "pingone_notification_template_content" "password_recovery_code_template" {
#   environment_id = pingone_environment.master_flow_environment.id
#   template_name  = "recovery_code_template"
#   locale         = "en"
#   variant        = "Password Recovery"

#   email = {
#     body          = "${file("${path.module}/data/notification_templates/Password Recovery.html")}"
#     subject       = "Password Recovery"
#     content_type  = "text/html"
#     character_set = "UTF-8"

#     from = {
#       name    = "PingOne"
#       address = "noreply@pingidentity.com"
#     }
    
#     reply_to = {
#       name    = "PingOne"
#       address = "noreply@pingidentity.com"
#     }
#   }

#   depends_on = [
#     pingone_webhook.master_flow_webhook
#   ]
# }

resource "pingone_notification_template_content" "common_device_email" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "general"
  locale         = "en"
  variant        = "Master Flow Common Device Email"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow Common Device Email.html")}"
    subject       = "PingOne: Device Registration confirmation"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_notification_template_content" "delete_device" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "general"
  locale         = "en"
  variant        = "Master Flow Delete Device"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow Delete Device.html")}"
    subject       = "PingOne: Device Deleted"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

# resource "pingone_notification_template_content" "password_recovery" {
#   environment_id = pingone_environment.master_flow_environment.id
#   template_name  = "recovery_code_template"
#   locale         = "en"
#   # variant        = "Password Recovery"

#   email = {
#     body          = "${file("${path.module}/data/notification_templates/Password Recovery.html")}"
#     subject       = "Password Recovery"
#     content_type  = "text/html"
#     character_set = "UTF-8"

#     from = {
#       name    = "PingOne"
#       address = "noreply@pingidentity.com"
#     }
    
#     reply_to = {
#       name    = "PingOne"
#       address = "noreply@pingidentity.com"
#     }
#   }

#   depends_on = [
#     pingone_webhook.master_flow_webhook
#   ]
# }

resource "pingone_notification_template_content" "email_verification_admin" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "email_verification_admin"
  locale         = "en"
  variant        = "Master Flow Email Verification Admin"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow Email Verification Admin.html")}"
    subject       = "Email Verification (Email)"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_notification_template_content" "forgot_password" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "general"
  locale         = "en"
  variant        = "Master Flow Forgot Password"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow Forgot Password.html")}"
    subject       = "PingOne: Password Reset"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

# resource "pingone_notification_template_content" "new_device" {
#   environment_id = pingone_environment.master_flow_environment.id
#   template_name  = "general"
#   locale         = "en"
#   variant        = "newDevice"

#   email = {
#     body          = "${file("${path.module}/data/notification_templates/newDevice.html")}"
#     subject       = "New Device"
#     content_type  = "text/html"
#     character_set = "UTF-8"

#     from = {
#       name    = "PingOne"
#       address = "noreply@pingidentity.com"
#     }
    
#     reply_to = {
#       name    = "PingOne"
#       address = "noreply@pingidentity.com"
#     }
#   }

#   depends_on = [
#     pingone_webhook.master_flow_webhook
#   ]
# }

resource "pingone_notification_template_content" "new_ping_device_paired" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "general"
  locale         = "en"
  variant        = "Master Flow New Ping Device Paired"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow New Ping Device Paired.html")}"
    subject       = "PingOne: New MFA Device Paired"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_notification_template_content" "verify_id_verification" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "id_verification"
  locale         = "en"

  email = {
    body          = "${file("${path.module}/data/notification_templates/PingOne Verify ID Verification.html")}"
    subject       = "PingOne: Finish your PingOne Verify ID verification"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_notification_template_content" "new_device" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "new_device_paired"
  locale         = "en"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Device Paired.html")}"
    subject       = "PingOne: New MFA Device Paired"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_notification_template_content" "id_verification" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "id_verification"
  locale         = "en"
  variant        = "Master Flow Identity Verification"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow Identity Verification.html")}"
    subject       = "PingOne: Finish your ID verification"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_notification_template_content" "transaction" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "transaction"
  locale         = "en"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow Transaction.html")}"
    subject       = "PingOne: Transaction Request"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_notification_template_content" "progressive_profiling" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "general"
  locale         = "en"
  variant        = "Master Flow Progressive Profile"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Master Flow Progressive Profile.html")}"
    subject       = "PingOne: Your user information has been updated"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

#1234
resource "pingone_notification_template_content" "credential_issued" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "credential_issued"
  locale         = "en"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Credential Issued.html")}"
    subject       = "PingOne: New Credential Issued"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_notification_template_content" "credential_revoked" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "credential_revoked"
  locale         = "en"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Credential revoked.html")}"
    subject       = "PingOne: Credential Revoked"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

resource "pingone_notification_template_content" "credential_updated" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "credential_updated"
  locale         = "en"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Credential Updated.html")}"
    subject       = "PingOne: Credntial Updated"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
  }

  depends_on = [
    pingone_webhook.master_flow_webhook
  ]
}

# resource "pingone_notification_template_content" "credential_verification" {
#   environment_id = pingone_environment.master_flow_environment.id
#   template_name  = "credential_verification"
#   locale         = "en"

#   email = {
#     body          = "${file("${path.module}/data/notification_templates/Credential Verification.html")}"
#     subject       = "PingOne: Credential Verification"
#     content_type  = "text/html"
#     character_set = "UTF-8"

#     from = {
#       name    = "PingOne"
#       address = "noreply@pingidentity.com"
#     }
    
#     reply_to = {
#       name    = "PingOne"
#       address = "noreply@pingidentity.com"
#     }
#   }

#   depends_on = [
#     pingone_webhook.master_flow_webhook
#   ]
# }

resource "pingone_notification_template_content" "digital_wallet_pairing" {
  environment_id = pingone_environment.master_flow_environment.id
  template_name  = "digital_wallet_pairing"
  locale         = "en"

  email = {
    body          = "${file("${path.module}/data/notification_templates/Digital Wallet Pairing.html")}"
    subject       = "PingOne: Setup your Digital Wallet"
    content_type  = "text/html"
    character_set = "UTF-8"

    from = {
      name    = "PingOne"
      address = "noreply@pingidentity.com"
    }
    
    reply_to = {
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

resource "pingone_schema_attribute" "locked_attribute" {
  environment_id = pingone_environment.master_flow_environment.id

  name         = "userLocked"
  display_name = "User Locked"

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

resource "pingone_schema_attribute" "enabled_attribute" {
  environment_id = pingone_environment.master_flow_environment.id

  name         = "userEnabled"
  display_name = "User Enabled"

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

resource "pingone_schema_attribute" "security_qa_registered_attribute" {
  environment_id = pingone_environment.master_flow_environment.id

  name         = "securityQARegistered"
  display_name = "Security Questions and Answers - Registered"

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

#################################
#  PingOne Notification Policy  #
#################################

resource "pingone_notification_policy" "master_flow_notification_policy" {
  environment_id = pingone_environment.master_flow_environment.id

  name = "Master Flow Notification Policy"
}

#####################
#  PingOne Protect  #
#####################

resource "pingone_risk_predictor" "chrome_version" {
  environment_id = pingone_environment.master_flow_environment.id
  name           = "Chrome Version"
  compact_name   = "chromeVersion"

  default = {
    result = {
      level = "MEDIUM"
    }
  }

  predictor_custom_map = {
    contains = "$${event.customAttributes.chromeVersion}"

    string_list = {
      high = {
        values = ["BLOCK"]
      }

      medium = {
        values = ["MEDIUM"]
      }

      low = {
        values = ["ALLOW"]
      }
    }
  }
}

#########################
#  PingOne Credentials  #
#########################

resource "pingone_application" "pingone_neo_demo_native_app" {
  environment_id = pingone_environment.master_flow_environment.id
  name = "Neo Demo Wallet"
  enabled        = true

  icon = {
    id   = "c6dbb456-0857-4fab-bfb0-909944233017"
    href = "https://www.pingidentity.com/content/dam/picr/ico/250x250/Ico-IdentityVerification-250x250.svg"
  }

  oidc_options = {
    type                       = "NATIVE_APP"
    grant_types                = ["AUTHORIZATION_CODE", "IMPLICIT"]
    response_types             = ["CODE", "ID_TOKEN", "TOKEN"]
    token_endpoint_auth_method = "NONE"

    mobile_app = {
      bundle_id           = "com.pingidentity.pingonewallet.sample" # iOS
      package_name        = "com.pingidentity.pingonewallet.sample" # Android

      universal_app_link = "https://neowallet.ping-eng.com/appopen"

      passcode_refresh_seconds = 30

      integrity_detection = {
        enabled = false
      }
    }
  }
}

resource "pingone_digital_wallet_application" "pingone_neo_demo_wallet_app" {
  environment_id = pingone_environment.master_flow_environment.id
  application_id = pingone_application.pingone_neo_demo_native_app.id
  app_open_url = "https://neowallet.ping-eng.com/appopen"
  name = "Neo Demo Wallet"
}

resource "pingone_credential_type" "pingone_neo_demo_credential" {
  environment_id = pingone_environment.master_flow_environment.id
  title            = "Company Credential"
  description      = "Unified Digital ID"
  card_type        = "Company Credential"
  revoke_on_delete = false
  management_mode  = "MANAGED" 

  card_design_template = <<-EOT
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 740 480">
<rect fill="none" width="736" height="476" stroke="#CACED3" stroke-width="3" rx="10" ry="10" x="2" y="2">
</rect><rect fill="$${cardColor}" height="476" rx="10" ry="10" width="736" x="2" y="2"></rect>
<image href="$${backgroundImage}" style="opacity:31%" height="476" rx="10" ry="10" width="736" x="2" y="2"></image>
<image href="$${logoImage}" x="42" y="43" height="90px" width="90px"></image>
<line y2="160" x2="695" y1="160" x1="42.5" stroke="$${textColor}"></line>
<text fill="$${textColor}" font-weight="450" font-size="30" x="160" y="90">$${cardTitle}</text>
<text fill="$${textColor}" font-size="25" font-weight="300" x="160" y="130">$${cardSubtitle}</text>
<text fill="$${textColor}" font-weight="600" font-size="30" x="50" y="228">$${fields[0].value} $${fields[3].value}</text>
<text fill="$${textColor}" font-weight="500" font-size="20" x="50" y="278">$${fields[1].value}</text>
<text fill="$${textColor}" font-weight="500" font-size="15" x="50" y="450">$${fields[2].title}: $${fields[2].value}</text>
<image href="data:image/jpeg;base64,$${fields[4].value}" x="590" y="30" height="120px" width="120px"></image>
</svg>
EOT

  metadata = {
    name               = "Company Credentials"
    description        = "Unified Digital ID"
    bg_opacity_percent = 30

    logo_image       = "https://cdn-assets-us.frontify.com/s3/frontify-enterprise-files-us/eyJwYXRoIjoicGluZ2lkZW50aXR5XC9hY2NvdW50c1wvM2FcLzQwMDA5NDdcL3Byb2plY3RzXC8xNVwvYXNzZXRzXC82YlwvMTYzMVwvMWQ1N2U0YTU0MTIxMjIzZmVhOTE3YmE2Y2Q2NjlkMjEtMTY0NDg3NjYxMS5haSJ9:pingidentity:eFdxYWEvOdgfuSU4lqfqMcA4mYTNfww8WwOLnwTo4zk"
    background_image = "https://cdn-assets-us.frontify.com/s3/frontify-enterprise-files-us/eyJwYXRoIjoicGluZ2lkZW50aXR5XC9maWxlXC9XeXF1akVRdkV5N3BjcFJ5VTRTUy5haSJ9:pingidentity:OBbQxgFuORCSy5aFaYgdu27T4G0Vp_4ymEZHqC2FxMY"

    card_color = "#000000"
    text_color = "#f8f8f7"

    fields = [
      {
        type       = "Directory Attribute"
        title      = "Given"
        attribute  = "name.given"
        is_visible = true
      },
      {
        type       = "Directory Attribute"
        title      = "Email"
        attribute  = "email"
        is_visible = true
      },
      {
        type       = "Issued Timestamp"
        title      = "Issued"
        is_visible = true
      },
      {
        type       = "Directory Attribute"
        title      = "Family"
        attribute  = "name.family"
        is_visible = true
      },
      {
        type       = "Alphanumeric Text"
        title      = "selfie"
        is_visible = true
      },
      {
        type       = "Directory Attribute"
        title      = "unique_identifier"
        attribute  = "id"
        is_visible = false
      }
    ]
  }
}

# resource "pingone_credential_issuance_rule" "my_credential_issuance_rule" {
#   environment_id                = pingone_environment.master_flow_environment.id
#   digital_wallet_application_id = pingone_digital_wallet_application.pingone_neo_demo_wallet_app.id
#   credential_type_id            = pingone_credential_type.pingone_neo_demo_credential.id

#   status = "ACTIVE"

#   filter = {
#     group_ids = [ "${pingone_group.pingone_admin_group.id}" ]
#   }

#   automation = {
#     issue  = "ON_DEMAND"
#     revoke = "ON_DEMAND"
#     update = "ON_DEMAND"
#   }

#   notification = {
#     methods = ["EMAIL", "SMS"]
#     template = {
#       locale  = "en"
#       variant = "credential_issued_template_B"
#     }
#   }
# }