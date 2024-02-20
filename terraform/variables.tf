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

variable "pingone_agreement_localization_revision_master_flow_agreement_en_now_text" {
  type        = string
  description = "Agreement Text"
}

##########################################
#  DaVinci - Generated with Terraformer  #
##########################################

variable "davinci_connection_PingOne_region" {
  description = "Value for davinci_connection_PingOne_region variable"
}

variable "davinci_variable_availableQuestions_2_value" {
  description = "Value for davinci_variable_availableQuestions_2_value variable"
}

variable "davinci_variable_cancelReturn_value" {
  description = "Value for davinci_variable_cancelReturn_value variable"
}

variable "davinci_variable_disableButton_value" {
  description = "Value for davinci_variable_disableButton_value variable"
}

variable "davinci_variable_disableReg_value" {
  description = "Value for davinci_variable_disableReg_value variable"
}

variable "davinci_variable_forgotUsername_value" {
  description = "Value for davinci_variable_forgotUsername_value variable"
}

variable "davinci_variable_gv-QA-On_value" {
  description = "Value for davinci_variable_gv-QA-On_value variable"
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

variable "davinci_variable_maxMessage_value" {
  description = "Value for davinci_variable_maxMessage_value variable"
}

variable "davinci_variable_mobile_value" {
  description = "Value for davinci_variable_mobile_value variable"
}

variable "davinci_variable_mustAuthN_value" {
  description = "Value for davinci_variable_mustAuthN_value variable"
}

variable "davinci_variable_origin_2_value" {
  description = "Value for davinci_variable_origin_2_value variable"
}

variable "davinci_variable_origin_value" {
  description = "Value for davinci_variable_origin_value variable"
}

/*variable "davinci_variable_populationId_value" {
  description = "Value for davinci_variable_populationId_value variable"
}*/

variable "davinci_variable_regAuthN_value" {
  description = "Value for davinci_variable_regAuthN_value variable"
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

variable "davinci_variable_testDeviceID_value" {
  description = "Value for davinci_variable_testDeviceID_value variable"
}

variable "davinci_variable_userAuthenticated_value" {
  description = "Value for davinci_variable_userAuthenticated_value variable"
}