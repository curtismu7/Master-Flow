region                  = "NorthAmerica"
pingone_environment_id  = ""
admin_user_id           = ""
license_id              = ""
worker_id               = ""
worker_secret           = ""
admin_username          = ""
admin_password          = ""

organization_id           = ""


#############
#  PingOne #
#############

# Change the name as needed for your P1 environment #

environment_name = "PingOne Master Flow - 1.1.7"
environment_description = "This environment is based on the PingOne Master Flow. https://github.com/curtismu7/Master-Flow/releases/tag/master \n\n\n This environment is created and maintained utilizing the PingOne Terraform provider."
environment_type = "SANDBOX"
pingone_agreement_localization_revision_master_flow_agreement_en_now_text = "GDPR requires that organizations have a lawful basis for processing data. One such basis is consent, which according to the GDPR has to be explicit and freely given. This means that the mechanism for acquiring consent must be unambiguous and involve a clear affirmative action.<br><br>While you shouldn't ask for it if you're carrying out a core service or process personal data by law, you should ask for consent when you're offering a non-essential service, like sending marketing emails and newsletters.<br><br>Here's a breakdown of the most important things you must know about email consent under GDPR – with plenty of templates and examples of how to put them into action."

# This creates a new user in P1, change as needed #
master_flow_user_email                  = "pingone.flow@mailinator.com"
master_flow_user_username               = "pingone.flow@mailinator.com"
master_flow_user_password               = "2FederateM0re!"
master_flow_user_password_force_change  = false
master_flow_user_given_name             = "PingOne"
master_flow_user_family_name            = "Flow"
master_flow_user_middle_name            = "Master"
master_flow_user_formatted_name         = "PingOne Master Flow"
master_flow_user_honorific_prefix       = ""
master_flow_user_honorific_suffix       = ""
master_flow_user_title                  = ""
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

#  You must put a value in client_id and client_secret if you set to "true"                   #
#  If davinci_variable_gv-googleLogin = "true" and you do not specify valid credentials,      #
#  the buttons will still appear on the login screen, but they will not work.                 #
#  The redirect URI will be generated and shown in terminal for you to configure the ext IDP  #
#                                                                                             #
#  The flow will return a Redirect URI to add to the sevice provider.                         #
#  https://pingidentity.atlassian.net/wiki/spaces/ASA/pages/407765131/Set+Up+Social+Logins+for+PingOne  #
davinci_variable_gv-googleLogin = "true"
google_client_id=""
google_client_secret=""

davinci_variable_gv-facebookLogin = "true"
facebook_app_id=""
facebook_app_secret=""

# TODO: Implement additional external IDPs
davinci_variable_gv-azureLogin = "false"
davinci_variable_gv-githubLogin = "false"

#############
#  DaVinci  #
#############


#  We have chosen some default behavior, please adjust as needed.   #
#  Link to documentation for variables: https://docs.google.com/document/d/19I_y2JPejllTn5xrugpn_CH2h_ig6X2bHt2XuQf2oO4/edit?usp=sharing   #

deployment_type = "REDIRECT"
davinci_variable_origin = "https://auth.pingone.com"
davinci_variable_gv-deviceManagement = "true"
davinci_variable_gv-isDeviceManagement = "true"
davinci_variable_gv-mfa-on = "true"
davinci_variable_gv-runPasswordExpire = "false"
davinci_variable_gv-fakeLevel = "false"
davinci_variable_gv-riskScreenDisplay = "true"
davinci_variable_gv-webAuthnSupport = "cross-platform"
davinci_variable_gv-forgotPasswordDisplay = "true"
davinci_variable_gv-standardForgotPassword = "true"
davinci_variable_gv-mfaOnHighRisk = "false"
davinci_variable_gv-runVerifyUserRegistration = "false"
davinci_variable_gv-protectAfterSocial = "false"
davinci_variable_gv-autoEnrollEmail = "true"
davinci_variable_gv-registerAnotherDevice = "true"
davinci_variable_gv-verifyUserRegistration = "false"
davinci_variable_showRegButton = "false"
davinci_variable_gv-runVerifyforHighRisk = "false"
davinci_variable_gv-allowPasswordless = "true"
davinci_variable_gv-forcePasswordless = "false"
davinci_variable_gv-runMFAforLogin = "true"
davinci_variable_gv-consent = "true"
davinci_variable_gv-inlineMFAOn = "true"
davinci_variable_gv-companyName = "Ping Identity Master Flow"
davinci_variable_stopSign = "https://cdn.glitch.global/2e56b165-f280-41c5-82c6-430c70bc9f97/Stop_sign.png?v=1703159103390"
davinci_variable_rpid = "pingone.com"
davinci_variable_gv-runMFAforForgot = "true"
davinci_variable_gv-passwordlessAllowedTypes = "['FIDO2', 'PLATFORM', 'MOBILE', 'TOTP', 'SECURITY_KEY']"
davinci_variable_relyingParty = "auth.pingone.com"
davinci_variable_availableQuestions_2 = "[         {           \"question\": \"In what city were you born?\"         },         {           \"question\": \"What was the model of your first car?\"         },         {           \"question\": \"What is the name of your first pet?\"         },     \t{                 \t  \"question\": \"What is the name of your favorite teacher?\"         },         {           \"question\": \"What is your mother's maiden name?\"         },          {           \"question\": \"What is the name of the street you grew up on?\"         },          {           \"question\": \"In which year did you graduate from high school?\"         }          ]"
davinci_variable_gv-runProtect = "false"
davinci_variable_gv-runMFAforSocial = "false"
davinci_variable_gv-QA-On = "true"
davinci_variable_gv-progressiveProfiling = "true"
davinci_variable_gv-riskLevel = "MEDIUM"
davinci_variable_gv-forgotUsernameDisplay = "true"
davinci_variable_origin_2 = "https://auth.pingone.com"
davinci_variable_gv-companyLogo = "https://assets.pingone.com/ux/ui-library/5.0.2/images/logo-pingidentity.png"
davinci_connection_PingOne_region = "NA"
davinci_variable_gv-captchaThreshold  = "0.7"
davinci_variable_gv-reCaptcha         = "false"
davinci_variable_gv-captchaV3SiteKey  = "6LfdK6QpAAAAALcGPNmzzyK4Baigr2UWjnL57ZIr"
davinci_variable_gv-autoEnrollEmailMFA = "true"
davinci_variable_gv-agreement = "true"
davinci_variable_gv-progressiveProfilingAuthentication = "true"
davinci_variable_gv-progressiveProfilingRegistration = "true"
davinci_variable_gv-pingOneAuthorize = "false"
davinci_variable_gv-magicLinkUserRegistration = "true"
davinci_variable_gv-FIDO2-deviceNickName = "Passkey/FIDO2"
