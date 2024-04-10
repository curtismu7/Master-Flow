admin_environment_id      = ""
admin_client_id           = ""
admin_client_secret       = ""
region                    = "NorthAmerica"
license_name              = "INTERNAL"
admin_user_id             = ""
dv_admin_username         = ""
dv_admin_password         = ""
organization_id           = ""
#############
#  PingOne  #
#############

environment_name = "PingOne Master Flow 1.1"
environment_description = "This environment is based on the PingOne Master Flow. https://github.com/curtismu7/Master-Flow/releases/tag/master \n\n\n This environment is created and maintained utilizing the PingOne Terraform provider."
environment_type = "SANDBOX"
pingone_agreement_localization_revision_master_flow_agreement_en_now_text = "<h1>END-USER LICENSE AGREEMENT</h1><p>GDPR requires that organizations have a lawful basis for processing data. One such basis is consent, which according to the GDPR has to be explicit and freely given. This means that the mechanism for acquiring consent must be unambiguous and involve a clear affirmative action.<br><br>While you shouldn't ask for it if you're carrying out a core service or process personal data by law, you should ask for consent when you're offering a non-essential service, like sending marketing emails and newsletters.<br><br>Here's a breakdown of the most important things you must know about email consent under GDPR – with plenty of templates and examples of how to put them into action.</p>"

master_flow_user_email                  = "master.flow@mailinator.com"
master_flow_user_username               = "master.flow@mailinator.com"
master_flow_user_password               = "2FederateM0re!"
master_flow_user_password_force_change  = false
master_flow_user_given_name             = "Master"
master_flow_user_family_name            = "Flow"
master_flow_user_middle_name            = ""
master_flow_user_formatted_name         = "Master Flow"
master_flow_user_honorific_prefix       = ""
master_flow_user_honorific_suffix       = ""
master_flow_user_title                  = "Grandmaster"
master_flow_user_nickname               = ""
master_flow_user_street_address         = "1001 17th St."
master_flow_user_address_locality       = "Denver"
master_flow_user_address_region         = "CO"
master_flow_user_address_postal_code    = "80202"
master_flow_user_address_country_code   = "US"
master_flow_user_locale                 = "en-US"
master_flow_user_preferred_language     = "en-US"
master_flow_user_mfa_enabled            = true
master_flow_user_mobile_phone           = "1234567890"
master_flow_user_primary_phone          = "0123456789"
master_flow_user_timezone               = "America/Denver"
master_flow_user_type                   = ""
master_flow_user_lifecycle_status       = "ACCOUNT_OK" #Accepted values: ACCOUNT_OK, VERIFICATION_REQUIRED
master_flow_user_lifecycle_suppress_verification_code = true

###################
#  External IDPs  #
###################
davinci_variable_gv-googleLogin_value = "false"
google_client_id=""
google_client_secret=""

davinci_variable_gv-facebookLogin_value = "false"
facebook_app_id=""
facebook_app_secret=""

# TODO: Implement additional external IDPs
davinci_variable_gv-azureLogin_value = "false"
davinci_variable_gv-githubLogin_value = "false"

#############
#  DaVinci  #
#############

deployment_type = "REDIRECT"
davinci_variable_origin_value = "https://auth.pingone.com"
davinci_variable_gv-deviceManagement_value = "false"
davinci_variable_gv-isDeviceManagement = "false"
davinci_variable_gv-mfa-on_value = "false"
davinci_variable_gv-runPasswordExpire_value = "false"
davinci_variable_gv-fakeLevel = "false"
davinci_variable_gv-riskScreenDisplay = "false"
davinci_variable_gv-webAuthnSupport_value = "cross-platform"
davinci_variable_gv-forgotPasswordDisplay_value = "false"
davinci_variable_gv-standardForgotPassword_value = "false"
davinci_variable_gv-mfaOnHighRisk = "false"
davinci_variable_gv-runVerifyUserRegistration = "false"
davinci_variable_gv-protectAfterSocial = "false"
davinci_variable_gv-autoEnrollEmail = "false"
davinci_variable_gv-registerAnotherDevice = "false"
davinci_variable_gv-verifyUserRegistration = "false"
davinci_variable_showRegButton_value = "false"
davinci_variable_gv-runVerifyforHighRisk_value = "false"
davinci_variable_gv-allowPasswordless_value = "false"
davinci_variable_gv-forcePasswordless_value = "false"
davinci_variable_gv-runMFAforLogin_value = "false"
davinci_variable_gv-consent_value = "false"
davinci_variable_gv-inlineMFAOn_value = "false"
davinci_variable_gv-companyName_value = "Ping Identity Master Flow"
davinci_variable_stopSign_value = "https://cdn.glitch.global/2e56b165-f280-41c5-82c6-430c70bc9f97/Stop_sign.png?v=1703159103390"
davinci_variable_rpid_value = "pingone.com"
davinci_variable_gv-runMFAforForgot_value = "false"
davinci_variable_gv-passwordlessAllowedTypes_value = "['FIDO2', 'PLATFORM', 'MOBILE', 'TOTP', 'SECURITY_KEY']"
davinci_variable_relyingParty_value = "auth.pingone.com"
davinci_variable_availableQuestions_2_value = "[         {           \"question\": \"In what city were you born?\"         },         {           \"question\": \"What was the model of your first car?\"         },         {           \"question\": \"What is the name of your first pet?\"         },     \t{                 \t  \"question\": \"What is the name of your favorite teacher?\"         },         {           \"question\": \"What is your mother's maiden name?\"         },          {           \"question\": \"What is the name of the street you grew up on?\"         },          {           \"question\": \"In which year did you graduate from high school?\"         }          ]"
davinci_variable_gv-runProtect_value = "false"
davinci_variable_gv-runMFAforSocial_value = "false"
davinci_variable_gv-QA-On_value = "false"
davinci_variable_gv-progressiveProfiling_value = "false"
davinci_variable_gv-riskLevel_value = "MEDIUM"
davinci_variable_gv-forgotUsernameDisplay_value = "false"
davinci_variable_origin_2_value = "https://auth.pingone.com"
davinci_variable_gv-companyLogo_value = "https://assets.pingone.com/ux/ui-library/5.0.2/images/logo-pingidentity.png"
davinci_connection_PingOne_region = "NA"
davinci_variable_gv-captchaThreshold  = "0.7"
davinci_variable_gv-reCaptcha         = "false"
davinci_variable_gv-captchaV3SiteKey  = "6LfdK6QpAAAAALcGPNmzzyK4Baigr2UWjnL57ZIr"
davinci_variable_gv-autoEnrollEmailMFA = "false"
davinci_variable_gv-agreement = "true"
