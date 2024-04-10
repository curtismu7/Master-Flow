variable "admin_client_id" {
    description = "Client Id"
    type = string
}
variable "admin_client_secret" {
    description = "Client Secret"
    type = string
    sensitive = true
}
variable "admin_environment_id" {
    description = "Environment Id"
    type = string
}
variable "region" {
    description = "Region"
    type = string
    default = "NorthAmerica"
}

variable "admin_user_id" {
  type        = string
  description = "P1 Administrator to assign Roles to"
  sensitive   = true
}

variable "dv_admin_username" {
    description = "PingOne DaVinci Admin Username"
    type = string
}

variable "dv_admin_password" {
    description = "PingOne DaVinci Admin Password"
    type = string
}

variable "license_name" {
  type        = string
  description = "Name of the P1 license you want to assign to the Environment"
}

variable "organization_id" {
  type        = string
  description = "Your P1 Organization ID"
}

variable "google_client_id" {
  type        = string
  description = "The Client ID from your Google OAuth application"
  default     = "This must be set in the Terraform config"
}

variable "google_client_secret" {
  type        = string
  description = "The Client Secret from your Google OAuth application"
  default     = "This must be set in the Terraform config"
}

variable "facebook_app_id" {
  type        = string
  description = "The Client ID from your Google OAuth application"
  default     = "This must be set in the Terraform config"
}

variable "facebook_app_secret" {
  type        = string
  description = "The Client Secret from your Google OAuth application"
  default     = "This must be set in the Terraform config"
}

#############
#  PingOne  #
#############

variable "environment_name" {
  type        = string
  description = "Name of the PingOne Environment"
}

variable "environment_description" {
  type        = string
  description = "Description of the PingOne Environment"
}

variable "environment_type" {
  type        = string
  description = "Type of the PingOne Environment. Allowed values: \"SANDBOX\", \"PRODUCTION\""

  validation {
    condition     = contains(["SANDBOX", "PRODUCTION"], var.environment_type)
    error_message = "Must be either \"SANDBOX\" or \"PRODUCTION\"."
  }
}

variable "pingone_agreement_localization_revision_master_flow_agreement_en_now_text" {
  type        = string
  description = "Agreement Text"
}

variable "master_flow_user_email" {
  type        = string
  description = "Sample user email"
}

variable "master_flow_user_username" {
  type        = string
  description = "Sample user username"
}

variable "master_flow_user_password" {
  type        = string
  description = "Sample user password"
}

variable "master_flow_user_password_force_change" {
  type        = bool
  description = "Whether the sample user must change their password on next login"
}

variable "master_flow_user_given_name" {
  type        = string
  description = "Sample user first name"
}

variable "master_flow_user_family_name" {
  type        = string
  description = "Sample user last name"
}

variable "master_flow_user_middle_name" {
  type        = string
  description = "Sample user middle name"
}

variable "master_flow_user_formatted_name" {
  type        = string
  description = "Sample user formatted name"
}

variable "master_flow_user_honorific_prefix" {
  type        = string
  description = "Sample user honorific prefix"
}

variable "master_flow_user_honorific_suffix" {
  type        = string
  description = "Sample user honorific suffix"
}

variable "master_flow_user_title" {
  type        = string
  description = "Sample user title"
}

variable "master_flow_user_nickname" {
  type        = string
  description = "Sample user nickname"
}

variable "master_flow_user_street_address" {
  type        = string
  description = "Sample user street address"
}

variable "master_flow_user_address_locality" {
  type        = string
  description = "Sample user address locality"
}

variable "master_flow_user_address_region" {
  type        = string
  description = "Sample user address region"
}

variable "master_flow_user_address_postal_code" {
  type        = string
  description = "Sample user address postal code"
}

variable "master_flow_user_address_country_code" {
  type        = string
  description = "Sample user address country code"
}

variable "master_flow_user_locale" {
  type        = string
  description = "Sample user locale"
}

variable "master_flow_user_preferred_language" {
  type        = string
  description = "Sample user preferred language"
}

variable "master_flow_user_mfa_enabled" {
  type        = bool
  description = "Whether the sample user has MFA enabled"
}

variable "master_flow_user_mobile_phone" {
  type        = string
  description = "Sample user mobile phone number"
}

variable "master_flow_user_primary_phone" {
  type        = string
  description = "Sample user primary phone number"
}

variable "master_flow_user_timezone" {
  type        = string
  description = "Sample user timezone"
}

variable "master_flow_user_type" {
  type        = string
  description = "Sample user type"
}

variable "master_flow_user_lifecycle_status" {
  type        = string
  description = "Sample user lifecycle status"
}

variable "master_flow_user_lifecycle_suppress_verification_code" {
  type        = string
  description = "Whether the sample user should be sent a verification code via email immediately"
}



#############
#  DaVinci  #
#############

variable "deployment_type" {
  type        = string
  description = "Type of deployment. Allowed values: \"WIDGET\", \"REDIRECT\""

  validation {
    condition     = contains(["WIDGET", "REDIRECT"], var.deployment_type)
    error_message = "Must be either \"WIDGET\" or \"REDIRECT\"."
  }
}

variable "davinci_connection_PingOne_region" {
  description = "Value for davinci_connection_PingOne_region variable"
}

variable "davinci_variable_availableQuestions_2_value" {
  description = "Value for davinci_variable_availableQuestions_2_value variable"
}

variable "davinci_variable_gv-QA-On_value" {
  description = "Value for davinci_variable_gv-QA-On_value variable"
}

variable "davinci_variable_gv-protectAfterSocial" {
  description = "Value for davinci_variable_gv-protectAfterSocial variable"
}

variable "davinci_variable_gv-fakeLevel" {
  description = "Value for davinci_variable_gv-fakeLevel variable"
}

variable "davinci_variable_gv-riskScreenDisplay" {
  description = "Value for davinci_variable_gv-riskScreenDisplay variable"
}

variable "davinci_variable_gv-runVerifyUserRegistration" {
  description = "Value for davinci_variable_gv-runVerifyUserRegistration variable"
}

variable "davinci_variable_gv-mfaOnHighRisk" {
  description = "Value for davinci_variable_gv-mfaOnHighRisk variable"
}

variable "davinci_variable_gv-autoEnrollEmail" {
  description = "Value for davinci_variable_gv-autoEnrollEmail variable"
}

variable "davinci_variable_gv-registerAnotherDevice" {
  description = "Value for davinci_variable_gv-registerAnotherDevice variable"
}

variable "davinci_variable_gv-verifyUserRegistration" {
  description = "Value for davinci_variable_gv-verifyUserRegistration variable"
}

variable "davinci_variable_gv-isDeviceManagement" {
  description = "Value for davinci_variable_gv-isDeviceManagement variable"
}

variable "davinci_variable_gv-allowPasswordless_value" {
  description = "Value for davinci_variable_gv-allowPasswordless_value variable"
}

variable "davinci_variable_gv-azureLogin_value" {
  description = "Value for davinci_variable_gv-azureLogin_value variable"
}

variable "davinci_variable_gv-companyLogo_value" {
  description = "Value for davinci_variable_gv-companyLogo_value variable"
}

variable "davinci_variable_gv-companyName_value" {
  description = "Value for davinci_variable_gv-companyName_value variable"
}

variable "davinci_variable_gv-consent_value" {
  description = "Value for davinci_variable_gv-consent_value variable"
}

variable "davinci_variable_gv-deviceManagement_value" {
  description = "Value for davinci_variable_gv-deviceManagement_value variable"
}

variable "davinci_variable_gv-facebookLogin_value" {
  description = "Value for davinci_variable_gv-facebookLogin_value variable"
}

variable "davinci_variable_gv-forcePasswordless_value" {
  description = "Value for davinci_variable_gv-forcePasswordless_value variable"
}

variable "davinci_variable_gv-forgotPasswordDisplay_value" {
  description = "Value for davinci_variable_gv-forgotPasswordDisplay_value variable"
}

variable "davinci_variable_gv-forgotUsernameDisplay_value" {
  description = "Value for davinci_variable_gv-forgotUsernameDisplay_value variable"
}

variable "davinci_variable_gv-githubLogin_value" {
  description = "Value for davinci_variable_gv-githubLogin_value variable"
}

variable "davinci_variable_gv-googleLogin_value" {
  description = "Value for davinci_variable_gv-googleLogin_value variable"
}

variable "davinci_variable_gv-inlineMFAOn_value" {
  description = "Value for davinci_variable_gv-inlineMFAOn_value variable"
}

variable "davinci_variable_gv-mfa-on_value" {
  description = "Value for davinci_variable_gv-mfa-on_value variable"
}

/*variable "davinci_variable_gv-p1AgreementId_value" {
  description = "Value for davinci_variable_gv-p1AgreementId_value variable"
}

variable "davinci_variable_gv-p1PasswordPolicy_value" {
  description = "Value for davinci_variable_gv-p1PasswordPolicy_value variable"
}

variable "davinci_variable_gv-p1PopulationId_value" {
  description = "Value for davinci_variable_gv-p1PopulationId_value variable"
}*/

variable "davinci_variable_gv-passwordlessAllowedTypes_value" {
  description = "Value for davinci_variable_gv-passwordlessAllowedTypes_value variable"
}

variable "davinci_variable_gv-progressiveProfiling_value" {
  description = "Value for davinci_variable_gv-progressiveProfiling_value variable"
}

variable "davinci_variable_gv-riskLevel_value" {
  description = "Value for davinci_variable_gv-riskLevel_value variable"
}

variable "davinci_variable_gv-runMFAforForgot_value" {
  description = "Value for davinci_variable_gv-runMFAforForgot_value variable"
}

variable "davinci_variable_gv-runMFAforLogin_value" {
  description = "Value for davinci_variable_gv-runMFAforLogin_value variable"
}

variable "davinci_variable_gv-runMFAforSocial_value" {
  description = "Value for davinci_variable_gv-runMFAforSocial_value variable"
}

variable "davinci_variable_gv-runPasswordExpire_value" {
  description = "Value for davinci_variable_gv-runPasswordExpire_value variable"
}

variable "davinci_variable_gv-runProtect_value" {
  description = "Value for davinci_variable_gv-runProtect_value variable"
}

variable "davinci_variable_gv-runVerifyforHighRisk_value" {
  description = "Value for davinci_variable_gv-runVerifyforHighRisk_value variable"
}

variable "davinci_variable_gv-standardForgotPassword_value" {
  description = "Value for davinci_variable_gv-standardForgotPassword_value variable"
}

variable "davinci_variable_gv-webAuthnSupport_value" {
  description = "Value for davinci_variable_gv-webAuthnSupport_value variable"
}

variable "davinci_variable_origin_2_value" {
  description = "Value for davinci_variable_origin_2_value variable"
}

variable "davinci_variable_origin_value" {
  description = "Value for davinci_variable_origin_value variable"
}

variable "davinci_variable_relyingParty_value" {
  description = "Value for davinci_variable_relyingParty_value variable"
}

variable "davinci_variable_rpid_value" {
  description = "Value for davinci_variable_rpid_value variable"
}

variable "davinci_variable_showRegButton_value" {
  description = "Value for davinci_variable_showRegButton_value variable"
}

variable "davinci_variable_stopSign_value" {
  description = "Value for davinci_variable_stopSign_value variable"
}

variable "davinci_variable_gv-captchaThreshold" {
  description = "Value for davinci_variable_gv-captchaThreshold variable"
}
variable "davinci_variable_gv-reCaptcha" {
  description = "Value for davinci_variable_gv-reCaptcha variable"
}
variable "davinci_variable_gv-captchaV3SiteKey" {
  description = "Value for davinci_variable_gv-captchaV3SiteKey variable"
}
variable "davinci_variable_gv-autoEnrollEmailMFA" {
  description = "Value for davinci_variable_gv-autoEnrollEmailMFA variable"
}
variable "davinci_variable_gv-agreement" {
  description = "Value for davinci_variable_gv-agreement variable"
}