# PingOne Master Flow - Terraform Configuration

## Table of Contents
- [Prerequisites](#prerequisites)
- [Install Terraform](#install-terraform)
- [Update the TFVars File](#update-the-tfvars-file)
- [Download and Extract the Lastest Release from Github](#download-and-extract-the-latest-release-from-github)
- [Apply the Terraform Configuration](#apply-the-terraform-configuration)

### Prerequisites

Within the Administrators environment of your PingOne organization, create a new Worker application. Name it as you see fit and optionally upload an icon. Enable your Worker application. Navigate to the Roles tab and select the permissions required to create and manage environments and their configurations, as shown in the below screenshot. \
<img src="https://github.com/kylemoorehead-pingidentity/Master-Flow/blob/main/terraform/images/pingone-console-application-roles.png?raw=true" width="250">

### Install Terraform

[Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) from the linked documentation. Recommendation: Use Homebrew for macOS and Chocolatey for Windows.

### Download and extract the latest release from Github

```bash
touch ~/Terraform/ && mkdir ~/Terraform/master-flow && cd ~/Terraform/master-flow
curl -L https://github.com/curtismu7/Master-Flow/releases/download/0.0.15/tf-release.zip > tf-release.zip
unzip ./tf-release.zip && rm ./tf-release.zip
```

### Update the TFVars File
Update the `terraform.tfvars` file for your environment. For the default experience, you will not need to modify anything below the DaVinci header.

The following variables must be set for your environment:

`admin_client_id`      - The client id from the worker app in your Administrators environment created in [Prerequisites](#prerequisites). \
`admin_client_secret`  - The client secret from the worker app in your Administrators environment created in [Prerequisites](#prerequisites). \
`admin_environment_id` - The environment ID of the Administrators environment. \
`region`               - Options are `AsiaPacific` `Canada` `Europe` and `NorthAmerica` \
`license_name`         - Likely `INTERNAL` \
`admin_user_id`        - The id of your admin account within the Administrators environment. This can be found on the API tab of your user. \
`dv_admin_username`    - The username of your admin account within the Administrators environment. \
`dv_admin_password`    - The password of your admin account within the Administrators environment. \
`organization_id`      - The id of your PingOne organization. \

<details>
<summary>Additional variables</summary>

| Variable Name | Type | Description |
| --- | --- | --- |
| admin_client_id | STRING | Required: **TRUE** Default: |
| admin_client_secret | STRING | Required: **TRUE** Default: |
| admin_environment_id | STRING | Required: **TRUE** Default: |
| region | STRING | Required: **TRUE** Default: |
| license_name | STRING | Required: **TRUE** Default: |
| admin_user_id | STRING | Required: **TRUE** Default: |
| dv_admin_username | STRING | Required: **TRUE** Default: |
| dv_admin_password | STRING | Required: **TRUE** Default: |
| organization_id | STRING | Required: **TRUE** Default: |
| pingone_agreement_localization_revision_master_flow_agreement_en_now_text | STRING | Default: |
| davinci_variable_origin_value | STRING | Default: |
| davinci_variable_gv-deviceManagement_value | STRING | Default: |
| davinci_variable_gv-azureLogin_value | STRING | Default: |
| davinci_variable_gv-mfa-on_value | STRING | Default: |
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
| davinci_variable_rpid_value | STRING | Default: |
| davinci_variable_gv-runMFAforForgot_value | STRING | Default: |
| davinci_variable_gv-passwordlessAllowedTypes_value | STRING | Default: |
| davinci_variable_relyingParty_value | STRING | Default: |
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

</details>

### Apply the Terraform Configuration

In the same directory as before, initialize your Terraform provider.
```bash
terraform init
```

Plan your Terraform deployment. This should provide you with a message about how many resources this configuration will create on your behalf. 
```bash
terraform plan
```

Apply your Terraform configuration, deploying all of the resources specified in your configuration.
```bash
terraform apply --auto-approve
```
NOTE: If you get any errors while deploying, run the same command again and it should deploy anything that failed the first time. If that does not work, run the `destroy` command below and re-run the `apply` command. We are currently working to make it more reliable.

Destroy your environment when you are done with it.
```bash
terraform destroy --auto-approve
```
