admin_environment_id      = "875e9c7d-a69d-4402-861b-1cc4ca24e7e9"
admin_client_id           = "281bb27a-2c37-43d4-ab3e-2b2829a3295f"
admin_client_secret       = "5j.LkqOVACaxl9KTU610nlF1eOdE~wMxJ74.3TTXVTXYEaGZko5G9SpgilXh33lD"
region                    = "NorthAmerica"
license_name              = "INTERNAL"
admin_user_id             = "0af3abf8-51c7-4f4a-9232-265faef8795a"
dv_admin_username         = "kylemoorehead@pingidentity.com"
dv_admin_password         = "Temporary098@"
organization_id           = "953388fc-2a02-447e-b0df-fcfa5842dfbe"

#############
#  PingOne  #
#############

environment_name = "PingOne Master Flow"
environment_description = "This environment is based on the PingOne Master Flow. https://github.com/curtismu7/Master-Flow/releases/tag/master \n\n\n This environment is created and maintained utilizing the PingOne Terraform provider."
environment_type = "SANDBOX"
pingone_agreement_localization_revision_master_flow_agreement_en_now_text = "<h1>END-USER LICENSE AGREEMENT</h1><p>GDPR requires that organizations have a lawful basis for processing data. One such basis is consent, which according to the GDPR has to be explicit and freely given. This means that the mechanism for acquiring consent must be unambiguous and involve a clear affirmative action.<br><br>While you shouldn't ask for it if you're carrying out a core service or process personal data by law, you should ask for consent when you're offering a non-essential service, like sending marketing emails and newsletters.<br><br>Here's a breakdown of the most important things you must know about email consent under GDPR – with plenty of templates and examples of how to put them into action.</p>"

###################
#  External IDPs  #
###################
davinci_variable_gv-googleLogin_value = "true"
google_client_id="820425897162-lt76vhbtfc5cilmpun6e64334f4kckl7.apps.googleusercontent.com"
google_client_secret="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"

# TODO: Implement additional external IDPs
davinci_variable_gv-facebookLogin_value = "false"
davinci_variable_gv-azureLogin_value = "false"
davinci_variable_gv-githubLogin_value = "false"

#############
#  DaVinci  #
#############

deployment_type = "REDIRECT"
davinci_variable_origin_value = "https://auth.pingone.com"
davinci_variable_gv-deviceManagement_value = "false"
davinci_variable_gv-mfa-on_value = "false"
davinci_variable_gv-runPasswordExpire_value = "false"
davinci_variable_gv-webAuthnSupport_value = "cross-platform"
davinci_variable_gv-forgotPasswordDisplay_value = "true"
davinci_variable_gv-standardForgotPassword_value = "false"
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