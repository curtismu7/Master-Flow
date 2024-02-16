# PingOne Master Flow - Terraform Configuration

## Table of Contents
- [Install Terraform](#install-terraform)
- [Update the TFVars File](#update-the-tfvars-file)

### Install Terraform

[Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) from the linked documentation. Recommendation: Use Homebrew for macOS and Chocolatey for Windows.

### Update the TFVars File
Update the `terraform.tfvars` file for your environment. For the default experience, you will not need to modify anything below the DaVinci header.

| Variable Name | Type | Description |
| --- | --- | --- |
| client_id | STRING | Default: |
| client_secret | STRING | Default: |
| environment_id | STRING | Default: |
| region | STRING | Default: |
| license_name | STRING | Default: |
| dv_admin_username | STRING | Default: |
| dv_admin_password | STRING | Default: |
| organization_id | STRING | Default: |
| pingone_agreement_localization_revision_master_flow_agreement_en_now_text | STRING | Default: |
| davinci_variable_origin_value | STRING | Default: |
| davinci_variable_gv-deviceManagement_value | STRING | Default: |
| davinci_variable_gv-azureLogin_value | STRING | Default: |
| davinci_variable_gv-mfa-on_value | STRING | Default: |
|  // davinci_variable_gv-p1AgreementId_value | STRING | Default: |
| davinci_variable_gv-runPasswordExpire_value | STRING | Default: |
| davinci_variable_gv-webAuthnSupport_value | STRING | Default: |
| davinci_variable_gv-forgotPasswordDisplay_value | STRING | Default: |
| davinci_variable_gv-standardForgotPassword_value | STRING | Default: |
| davinci_variable_gv-facebookLogin_value | STRING | Default: |
| davinci_variable_showRegButton_value | STRING | Default: |
| davinci_variable_gv-runVerifyforHighRisk_value | STRING | Default: |
| davinci_variable_gv-allowPasswordless_value | STRING | Default: |
| davinci_variable_maxMessage_value | STRING | Default: |
| davinci_variable_gv-forcePasswordless_value | STRING | Default: |
|  // davinci_variable_populationId_value | STRING | Default: |
| davinci_variable_disableReg_value | STRING | Default: |
| davinci_variable_mobile_value | STRING | Default: |
| davinci_variable_gv-p1PasswordPolicy_value | STRING | Default: |
| davinci_variable_gv-runMFAforLogin_value | STRING | Default: |
| davinci_variable_gv-googleLogin_value | STRING | Default: |
| davinci_variable_gv-consent_value | STRING | Default: |
| davinci_variable_userAuthenticated_value | STRING | Default: |
| davinci_variable_gv-inlineMFAOn_value | STRING | Default: |
| davinci_variable_gv-companyName_value | STRING | Default: |
| davinci_variable_stopSign_value | STRING | Default: |
|  // davinci_variable_testDeviceID_value | STRING | Default: |
| davinci_variable_rpid_value | STRING | Default: |
| davinci_variable_gv-runMFAforForgot_value | STRING | Default: |
| davinci_variable_gv-passwordlessAllowedTypes_value | STRING | Default: |
| davinci_variable_relyingParty_value | STRING | Default: |
|  //davinci_variable_gv-p1PopulationId_value | STRING | Default: |
| davinci_variable_availableQuestions_2_value | STRING | Default: |
| davinci_variable_gv-runProtect_value | STRING | Default: |
| davinci_variable_gv-runMFAforSocial_value | STRING | Default: |
| davinci_variable_disableButton_value | STRING | Default: |
| davinci_variable_forgotUsername_value | STRING | Default: |
| davinci_variable_regAuthN_value | STRING | Default: |
| davinci_variable_gv-QA-On_value | STRING | Default: |
| davinci_variable_gv-progressiveProfiling_value | STRING | Default: |
| davinci_variable_mustAuthN_value | STRING | Default: |
| davinci_variable_cancelReturn_value | STRING | Default: |
| davinci_variable_gv-riskLevel_value | STRING | Default: |
| davinci_variable_gv-forgotUsernameDisplay_value | STRING | Default: |
| davinci_variable_origin_2_value | STRING | Default: |
| davinci_variable_gv-companyLogo_value | STRING | Default: |
| davinci_variable_gv-githubLogin_value | STRING | Default: |
| davinci_connection_PingOne_region | STRING | Default: |
