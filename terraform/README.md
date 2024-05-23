# PingOne Master Flow - Terraform Configuration

## Table of Contents
- [Prerequisites](#prerequisites)
- [Install Terraform](#install-terraform)
- [Update the TFVars File](#update-the-tfvars-file)
- [Download and Extract the Lastest Release from Github](#download-and-extract-the-latest-release-from-github)
- [Apply the Terraform Configuration](#apply-the-terraform-configuration)

### Prerequisites

#### Configure PingOne
Create a new PingOne environment with the PingOne SSO and PingOne DaVinci services. Name it whatever you like. Suggestion: **Terrform Administration**. \
This environment will only be used to allow Terraform to create and manage new environments within PingOne.
<img src="https://github.com/curtismu7/Master-Flow/assets/117233001/81e61e41-df67-4c3a-ab42-2f9c6855a519" width="300">

In your new environment, create a worker application. Name it whatever you like. Suggestion: **Pingone Terrform Administration**. \
Enable it.\
Navigate to the Roles tab and provide it with the following permissions at a minimum. Additional permissions can be provided, but are not necessary. 
> [!WARNING]
> The permissions are configured this way for the internal use case. For example, in a production environment, you would not want to apply Environment Administrator permissions at the Organization level, you would select only the environments which should be managed with Terraform and your Terraform Administration environment. 
<img src="https://github.com/curtismu7/Master-Flow/assets/117233001/4d0a62bc-3c7a-4352-922d-1dd2ca483785" width="300"> 
<br />

In your new environment, create a user. Its email address must be reachable, but its username and all other attributes may be anything you desire. \
Navigate to the Roles tab and provide this user with the following permissions.
> [!WARNING]
> Do not apply DaVinci Admin rights at the Organization level, you must select specific environments or you will not be able to SSO into DaVinci to create environment. For more information, see https://pingidentity.atlassian.net/browse/STAGING-22666
<img src="https://github.com/curtismu7/Master-Flow/assets/117233001/8ce0bd20-1e78-4389-9bad-cd58ee7d0ec9" width="300">

Navigate to Applications -> Applications, select "PingOne Self-Service - MyAccount", and then choose "Overview". Using the URL from "Home Page URL", sign in as this user and execute a password reset. Once the user's password has been reset, you can log out of the PingOne Dock. If you do not reset their password, you will see errors relating to the user's credentials later.

Keep this environment handy. We will need to get a number of IDs from it later.

### Install Terraform

[Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) from the linked documentation. Recommendation: Use Homebrew for macOS and Chocolatey for Windows.

### Download and extract the latest release from Github

```bash
touch ~/Terraform/ && mkdir ~/Terraform/master-flow && cd ~/Terraform/master-flow
curl -L https://github.com/curtismu7/Master-Flow/releases/download/1.1.7/tf-release.zip > tf-release.zip
unzip ./tf-release.zip && rm ./tf-release.zip
```

### Update the TFVars File
Update the `terraform.tfvars` file for your environment. For the default experience, you will not need to modify anything below the DaVinci header.

The following variables must be set for your environment:

`worker_id`      - The client id from the worker app in the **Terraform Administration** environment that you created. \
`worker_secret`  - The client secret from the worker the **Terraform Administration** environment that you created. \
`pingone_environment_id` - The environment ID of the **Terraform Administration** environment that you created. \
`region`               - Options are `AsiaPacific` `Canada` `Europe` and `NorthAmerica` \
`license_id`         - The license ID that you would like to use. If left blank, it will default to the license used for the environment that you created. \
`admin_user_id`        - The id of the user account that you created. This can be found on the API tab of your user. \
`admin_username`    - The username of the user account that you created. \
`admin_password`    - The password of the user account that you created. \
`organization_id`      - The id of your PingOne organization. \

<details>
<summary>Additional variables</summary>

| Variable Name | Type | Description |
| --- | --- | --- |
| worker_id | STRING | Required: **TRUE** Default: |
| worker_secret | STRING | Required: **TRUE** Default: |
| pingone_environment_id | STRING | Required: **TRUE** Default: |
| region | STRING | Required: **TRUE** Default: |
| license_name | STRING | Required: **TRUE** Default: |
| admin_user_id | STRING | Required: **TRUE** Default: |
| admin_username | STRING | Required: **TRUE** Default: |
| admin_password | STRING | Required: **TRUE** Default: |
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
