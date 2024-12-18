## Table of Contents
- [Prerequisites](#prerequisites)
- [Install Terraform](#install-terraform)
- [Update the TFVars File](#update-the-tfvars-file)
- [Download and Extract the Lastest Release from Github](#download-and-extract-the-latest-release-from-github)
- [Apply the Terraform Configuration](#apply-the-terraform-configuration)

### Prerequisites

#### Configure PingOne

In your Administrators environment, create a new group. Name it whatever you would like. Suggestion: **PingOne Master Flow Administrators** \
Add your own admin account to this group. Do not provide it with any Roles. \
You will need the Group ID from this group and the Environment ID of the Administrators environment.
<img src="https://github.com/user-attachments/assets/28ea7018-f9dd-45d3-85cf-51b9c15319f0" width="300">
> [!WARNING]
> Terraform will reach back into the administrators environment and use this group to provide permissions to the environments it creates for Administrators. Once Terraform has added Roles to this group, you will no longer be able to add or remove yourself from the group. If this happens, you can still create another Administator account, sign into it and provide your initial account with access.

Create a new PingOne environment with the PingOne SSO and PingOne DaVinci services. Name it whatever you like. Suggestion: **Terrform Administration**. \
This environment will only be used to allow Terraform to create and manage new environments within PingOne.
<img src="https://github.com/curtismu7/Master-Flow/assets/117233001/81e61e41-df67-4c3a-ab42-2f9c6855a519" width="300">

In your new environment, create a worker application. Name it whatever you like. Suggestion: **Pingone Terrform Administration**. \
Enable it.\
Navigate to the Roles tab and provide it with the following permissions.
> [!WARNING]
> Do not assign Environment Admin permissions at the Organization level. The Terraform configuration will add any permissions needed to maintain the environments it creates moving forward. If you apply Environment Admin permissions at the Organization level, Terraform will error out with a message about duplicate permissions.
<img src="https://github.com/user-attachments/assets/c86b8175-ee5f-4a05-aca1-d4e2dcac2ab0" width="300"> 
<br />

In your new environment, create a user. Its email address must be reachable, but its username and all other attributes may be anything you desire. \
Navigate to the Roles tab and provide this user with the following permissions.
> [!WARNING]
> Do not apply DaVinci Admin rights at the Organization level. The Terraform configuration will add any permissions needed to maintain the environments it creates moving forward.
<img src="https://github.com/curtismu7/Master-Flow/assets/117233001/8ce0bd20-1e78-4389-9bad-cd58ee7d0ec9" width="300">
<br />

Navigate to Applications -> Applications, select "PingOne Self-Service - MyAccount", and then choose "Overview". Using the URL from "Home Page URL", sign in as this user and execute a password reset. Once the user's password has been reset, you can log out of the PingOne Dock. If you do not reset their password, you will see errors relating to the user's credentials later.

Keep this environment handy. We will need to get a number of IDs from it later.

### Install Terraform

[Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) from the linked documentation. Recommendation: Use Homebrew for macOS and Chocolatey for Windows.

### Download and extract the latest release from Github

```bash
mkdir -p ~/Terraform/master-flow && cd ~/Terraform/master-flow
curl -L https://github.com/curtismu7/Master-Flow/releases/download/2.1.0/tf-release.zip > tf-release.zip
unzip ./tf-release.zip && rm ./tf-release.zip
```

### Update the TFVars File
Update the `terraform.tfvars` file for your environment. For the default experience, you will not need to modify anything below the DaVinci header.

Variables from the *Terraform Administration* environment: \
`worker_id`      - The client id from the worker app in the **Terraform Administration** environment that you created. \
`worker_secret`  - The client secret from the worker the **Terraform Administration** environment that you created. \
`pingone_environment_id` - The environment ID of the **Terraform Administration** environment that you created. \
`region`               - Options are `AsiaPacific` `Canada` `Europe` and `NorthAmerica` \
`license_id`         - The license ID that you would like to use. If left blank, it will default to the license used for the environment that you created. \
`admin_user_id`        - The id of the user account that you created. This can be found on the API tab of your user. \
`admin_username`    - The username of the user account that you created. \
`admin_password`    - The password of the user account that you created. \
`organization_id`      - The id of your PingOne organization. \

Variables from the *Administrators* \
`admin_environment_id`  - The environment ID of the **Administrators** environment. \
`admin_group_id`          - The group ID of the group you created in the **Administrators** environment. \

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
