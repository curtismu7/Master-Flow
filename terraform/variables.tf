variable "worker_id" {
    description = "Client Id"
    type = string
}
variable "worker_secret" {
    description = "Client Secret"
    type = string
    sensitive = true
}
variable "pingone_environment_id" {
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

variable "admin_username" {
    description = "PingOne DaVinci Admin Username"
    type = string
}

variable "admin_password" {
    description = "PingOne DaVinci Admin Password"
    type = string
}

variable "license_id" {
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

variable "davinci_variable_availableQuestions_2" {
  description = "Value for davinci_variable_availableQuestions_2 variable"
}

variable "davinci_variable_gv-QA-On" {
  description = "Value for davinci_variable_gv-QA-On variable"
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

variable "davinci_variable_gv-allowPasswordless" {
  description = "Value for davinci_variable_gv-allowPasswordless variable"
}

variable "davinci_variable_gv-azureLogin" {
  description = "Value for davinci_variable_gv-azureLogin variable"
}

variable "davinci_variable_gv-companyLogo" {
  description = "Value for davinci_variable_gv-companyLogo variable"
}

variable "davinci_variable_gv-companyName" {
  description = "Value for davinci_variable_gv-companyName variable"
}

variable "davinci_variable_gv-consent" {
  description = "Value for davinci_variable_gv-consent variable"
}

variable "davinci_variable_gv-deviceManagement" {
  description = "Value for davinci_variable_gv-deviceManagement variable"
}

variable "davinci_variable_gv-facebookLogin" {
  description = "Value for davinci_variable_gv-facebookLogin variable"
}

variable "davinci_variable_gv-forcePasswordless" {
  description = "Value for davinci_variable_gv-forcePasswordless variable"
}

variable "davinci_variable_gv-forgotPasswordDisplay" {
  description = "Value for davinci_variable_gv-forgotPasswordDisplay variable"
}

variable "davinci_variable_gv-forgotUsernameDisplay" {
  description = "Value for davinci_variable_gv-forgotUsernameDisplay variable"
}

variable "davinci_variable_gv-githubLogin" {
  description = "Value for davinci_variable_gv-githubLogin variable"
}

variable "davinci_variable_gv-googleLogin" {
  description = "Value for davinci_variable_gv-googleLogin variable"
}

variable "davinci_variable_gv-inlineMFAOn" {
  description = "Value for davinci_variable_gv-inlineMFAOn variable"
}

variable "davinci_variable_gv-mfa-on" {
  description = "Value for davinci_variable_gv-mfa-on variable"
}

/*variable "davinci_variable_gv-p1AgreementId" {
  description = "Value for davinci_variable_gv-p1AgreementId variable"
}

variable "davinci_variable_gv-p1PasswordPolicy" {
  description = "Value for davinci_variable_gv-p1PasswordPolicy variable"
}

variable "davinci_variable_gv-p1PopulationId" {
  description = "Value for davinci_variable_gv-p1PopulationId variable"
}*/

variable "davinci_variable_gv-passwordlessAllowedTypes" {
  description = "Value for davinci_variable_gv-passwordlessAllowedTypes variable"
}

variable "davinci_variable_gv-progressiveProfiling" {
  description = "Value for davinci_variable_gv-progressiveProfiling variable"
}

variable "davinci_variable_gv-riskLevel" {
  description = "Value for davinci_variable_gv-riskLevel variable"
}

variable "davinci_variable_gv-runMFAforForgot" {
  description = "Value for davinci_variable_gv-runMFAforForgot variable"
}

variable "davinci_variable_gv-runMFAforLogin" {
  description = "Value for davinci_variable_gv-runMFAforLogin variable"
}

variable "davinci_variable_gv-runMFAforSocial" {
  description = "Value for davinci_variable_gv-runMFAforSocial variable"
}

variable "davinci_variable_gv-runPasswordExpire" {
  description = "Value for davinci_variable_gv-runPasswordExpire variable"
}

variable "davinci_variable_gv-runProtect" {
  description = "Value for davinci_variable_gv-runProtect variable"
}

variable "davinci_variable_gv-runVerifyforHighRisk" {
  description = "Value for davinci_variable_gv-runVerifyforHighRisk variable"
}

variable "davinci_variable_gv-standardForgotPassword" {
  description = "Value for davinci_variable_gv-standardForgotPassword variable"
}

variable "davinci_variable_gv-webAuthnSupport" {
  description = "Value for davinci_variable_gv-webAuthnSupport variable"
}

variable "davinci_variable_origin_2" {
  description = "Value for davinci_variable_origin_2 variable"
}

variable "davinci_variable_origin" {
  description = "Value for davinci_variable_origin variable"
}

variable "davinci_variable_relyingParty" {
  description = "Value for davinci_variable_relyingParty variable"
}

variable "davinci_variable_rpid" {
  description = "Value for davinci_variable_rpid variable"
}

variable "davinci_variable_showRegButton" {
  description = "Value for davinci_variable_showRegButton variable"
}

variable "davinci_variable_stopSign" {
  description = "Value for davinci_variable_stopSign variable"
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
variable "davinci_variable_gv-magicLinkUserRegistration" {
  description = "Value for davinci_variable_gv-magicLinkUserRegistration variable"
}
variable "davinci_variable_gv-progressiveProfilingRegistration" {
  description = "Value for davinci_variable_gv-progressiveProfilingRegistration variable"
}
variable "davinci_variable_gv-progressiveProfilingAuthentication" {
  description = "Value for davinci_variable_gv-progressiveProfilingAuthentication variable"
}
variable "davinci_variable_gv-pingOneAuthorize" {
  description = "Value for davinci_variable_gv-pingOneAuthorize variable"
}

variable "davinci_variable_gv-FIDO2-deviceNickName" {
  description = "Value for davinci_variable_gv-FIDO2-deviceNickName variable"
}