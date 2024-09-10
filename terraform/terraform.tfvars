region                  = "NorthAmerica"     # Used in DV Provider
region_code             = "NA"               # Used in PingOne provider
pingone_environment_id  = "2e82aecc-ff12-41e1-9659-ac64cd404781" # Terraform DV Environment, probably need to rename
admin_user_id           = "d465c795-4b06-4e1d-9c74-74deb86e8284" # Terraform DV Admin, rename? | Switch to group Id
license_id              = "b0f833d2-d0cd-4d74-8df2-bf52bcf9f843" # Terraform DV Admin, rename?
worker_id               = "796fd336-579f-4e3c-9bc4-9bcad0afb891"
worker_secret           = "V9nZ_BD_WlFOFUaCKBRdUJzymAa3o~tnc7BiKYbBFSuasmqQe-_RzpivrTn0cor0"
admin_username          = "terraform.admin"                      # Terraform DV Admin, rename?
admin_password          = "Test123!"                             # Terraform DV Admin, rename?

# Names not hard requirement to keep as-is

organization_id         = "c12c18d0-b89a-4c11-aa4d-a9e5e2d0f720"

# New Vars
admin_environment_id    = "ce707d16-da7a-4391-81a8-13bae68a5ce9"
admin_group_id          = "4cb5799a-5830-42ab-998c-8cf39577a731"

# Not broken environment

# region                  = "NorthAmerica"     # Used in DV Provider
# region_code             = "NA"               # Used in PingOne provider
# pingone_environment_id  = "f4aa5738-dcce-4711-bdbc-273c46f1c527" # Terraform DV Environment, probably need to rename
# admin_user_id           = "bf5bfa15-6439-4a53-8855-b1068edcb1cd" # Terraform DV Admin, rename? | Switch to group Id
# license_id              = "2a23828e-6516-42aa-8b2e-6e818d35a5a8" # Terraform DV Admin, rename?
# worker_id               = "9a01dd16-fca1-493c-9681-3b39979d0c4a"
# worker_secret           = "OpY~YmZmSC_xtCmOdvDaHd~YBYVH5QnmN8u1Mc.9ddS1vhRqXZS3jgLOtf2q7L~W"
# admin_username          = "terraform.admin"                      # Terraform DV Admin, rename?
# admin_password          = "Test123!"                             # Terraform DV Admin, rename?

# # Names not hard requirement to keep as-is

# organization_id         = "2793a85b-b5ee-4a93-930a-2760252ed541"

# # New Vars
# admin_environment_id    = "1552b6c9-aa49-4645-ab3e-63d7ad8e13ad"
# admin_group_id          = "aa4c9b46-79fc-4ddd-90b5-5e5ed5945ad2"


#############
#  PingOne #
#############

# Change the name as needed for your P1 environment #

environment_name = "Kyle M - PingOne Master Flow - 2.0 - fd496e8e-0602-4a8b-8527-39ebb87a10d5"
environment_description = "[fd496e8e-0602-4a8b-8527-39ebb87a10d5] This environment is based on the PingOne Master Flow. https://github.com/curtismu7/Master-Flow/releases/tag/master \n\n\n This environment is created and maintained utilizing the PingOne Terraform provider."
environment_type = "SANDBOX"
pingone_agreement_localization_revision_master_flow_agreement_en_now_text = <<EOT
GDPR requires that organizations have a lawful basis for processing data. One such basis is consent, which according to the GDPR has to be explicit and freely given. This means that the mechanism for acquiring consent must be unambiguous and involve a clear affirmative action.

While you shouldn't ask for it if you're carrying out a core service or process personal data by law, you should ask for consent when you're offering a non-essential service, like sending marketing emails and newsletters.

Here's a breakdown of the most important things you must know about email consent under GDPR – with plenty of templates and examples of how to put them into action.
EOT

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
# davinci_variable_gv-azureLogin = "false"
# davinci_variable_gv-githubLogin = "false"

#############
#  DaVinci  #
#############


#  We have chosen some default behavior, please adjust as needed.   #
#  Link to documentation for variables: https://docs.google.com/document/d/19I_y2JPejllTn5xrugpn_CH2h_ig6X2bHt2XuQf2oO4/edit?usp=sharing   #

#deployment_type = "REDIRECT"
davinci_variable_origin = "https://auth.pingone.com"
davinci_variable_showRegButton = "false"
davinci_variable_disableButton = "false"
davinci_variable_cancelReturn = "true"
davinci_variable_stopSign = "https://cdn.glitch.global/2e56b165-f280-41c5-82c6-430c70bc9f97/Stop_sign.png?v=1703159103390"
davinci_variable_rpid = "pingone.com"
davinci_connection_PingOne_region = "NA"
davinci_variable_relyingParty = "auth.pingone.com"

davinci_variable_mf-configObject = {
    "config": {
        "mf-bool-webauthnBrowserSupport": true,
        "mf-obj-p1MFAPasswordlessAllowedTypes": [
            "FIDO2",
            "PLATFORM",
            "MOBILE",
            "TOTP",
            "SECURITY_KEY"
        ],
        "mf-obj-passwordPolicy": {
            "length": {
                "max": 255,
                "min": 8
            },
            "maxRepeatedCharacters": 2,
            "minCharacters": {
                "0123456789": 1,
                "ABCDEFGHIJKLMNOPQRSTUVWXYZ": 1,
                "abcdefghijklmnopqrstuvwxyz": 1,
                "~!@#$%^&*()-_=+[]{}|;:,.<>/?": 1
            },
            "minUniqueCharacters": 5
        },
        "mf-str-availableQuestions": [
            {
                "question": "In what city were you born?"
            },
            {
                "question": "What was the model of your first car?"
            },
            {
                "question": "What is the name of your first pet?"
            },
            {
                "question": "What is the name of your favorite teacher?"
            },
            {
                "question": "What is your mother's maiden name?"
            },
            {
                "question": "What is the name of the street you grew up on?"
            },
            {
                "question": "In which year did you graduate from high school?"
            }
        ],
        "mf-str-azureExternalIdPId": " ",
        "mf-str-browserVersion": 128,
        "mf-str-captchaThreshold": "0.7",
        "mf-str-captchaV3SecretKey": "6LfdK6QpAAAAAMsuy-7ezPCyLIAAQoP8eDBoSclF",
        "mf-str-captchaV3SiteKey": "6LfdK6QpAAAAALcGPNmzzyK4Baigr2UWjnL57ZIr",
        "mf-str-companyLogo": "https://avatars.githubusercontent.com/u/93611276?v=4",
        "mf-str-companyName": "Davinci Demo Company",
        "mf-str-facebookExternalIdPId": "",
        "mf-str-fidoDeviceNickname": "Passkeys",
        "mf-str-fidoOrigin": "https://auth.pingone.com",
        "mf-str-fidoRPID": "pingone.com",
        "mf-str-githubExternalIdPId": "",
        "mf-str-googleExternalIdPId": "21ad062f-bbce-4365-b0ed-8c98f9e7f4f2",
        "mf-str-passwordExpiredDays": 30,
        "mf-str-webAuthnSupport": "cross-platform"
    },
    "p1Authorize": {
        "mf-bool-runAuthorize": false
    },
    "p1MFA": {
        "mf-bool-allowForgotPassword": true,
        "mf-bool-allowHybridPasswordless": true,
        "mf-bool-allowRegisterAnotherDevice": true,
        "mf-bool-runAfterSocialLogin": false,
        "mf-bool-runAutoEnrollEmail": true,
        "mf-bool-runDeviceManagement": true,
        "mf-bool-runInlineMFA": true,
        "mf-bool-runOnlyPasswordless": false,
        "mf-bool-runP1MFA": true,
        "mf-bool-sendEmailConfirmation": true,
        "mf-bool-sendEmailDeleteDeviceConfirmation": true
    },
    "p1Protect": {
        "mf-bool-runAfterSocialLogin": false,
        "mf-bool-runBrowserVersionAuthentication": false,
        "mf-bool-runBrowserVersionRegistration": true,
        "mf-bool-runFakeRiskLevel": true,
        "mf-bool-runMFAOnHigh": false,
        "mf-bool-runNotificationForNewDevice": true,
        "mf-bool-runPassiveMode": false,
        "mf-bool-runProtect": true,
        "mf-bool-runStopOnHighRiskLevel": false,
        "mf-bool-showDetailScreenDisplay": true,
        "mf-bool-showProgressScreenDisplay": true,
        "mf-bool-userDeleteOnTempEmail": false,
        "mf-bool-userLockedOnTempEmail": true,
        "mf-str-fakeRiskLevel": "MEDIUM",
        "mf-str-fakeRiskScore": 50
    },
    "p1Verify": {
        "mf-bool-allowVerifyUserRegistration": true,
        "mf-bool-runVerifyFakeSuccess": false,
        "mf-bool-runVerifyOnHigh": true
    },
    "pingone": {
        "mf-bool-allowForgotPassword": true,
        "mf-bool-allowForgotUsername": true,
        "mf-bool-allowKBAforForgotPassword": true,
        "mf-bool-allowMagicLinkUserRegistration": true,
        "mf-bool-allowOTPForgotPassword": true,
        "mf-bool-allowreCaptcha": false,
        "mf-bool-displayProfileUpdateQuestion": true,
        "mf-bool-runAgreement": false,
        "mf-bool-runAzureLogin": true,
        "mf-bool-runConsent": true,
        "mf-bool-runFacebookLogin": false,
        "mf-bool-runGithubLogin": false,
        "mf-bool-runGoogleLogin": true,
        "mf-bool-runMFAOnAccountUnlock": true,
        "mf-bool-runPasswordExpireCheck": true,
        "mf-bool-runProgressiveProfileAuthN": true,
        "mf-bool-runProgressiveProfileRegstration": true,
        "mf-bool-runTimeBasedProgressiveProfile": true,
        "mf-bool-showAzureButton": true,
        "mf-bool-showFacebookButton": false,
        "mf-bool-showGithubButton": false,
        "mf-bool-showGoogleButton": true,
        "mf-string-daysUntilProgressiveProfile": 30
    }
}