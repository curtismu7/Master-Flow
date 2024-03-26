
1.1

* Terraform installation: https://github.com/curtismu7/Master-Flow/tree/main/terraform
* Installation Instructions: https://docs.google.com/document/d/1BdTqAhruiwAqWrDyba7O8nsEG0L78qUOUIvAtEkkbtQ/edit?usp=sharing
* Documentation:  https://docs.google.com/document/d/19I_y2JPejllTn5xrugpn_CH2h_ig6X2bHt2XuQf2oO4/edit?usp=sharing
* Presentation Slides:  https://docs.google.com/presentation/d/1D2amCevTLONfaLGETLN1nqb47J_g7dDRvcHW7IcZFik/edit?usp=sharing



*** Short directions, please see Installation Instructions for complete document ***

* This is PingOne Master flow.  These are all the pieces that need to be installed for a complete demo.

* You need Feature Flag for Davinci named:
  *  dv-10022-import-flow
  *  This fixes an issue with import on large flows.  Do not try to install without it.
* * Davinci Export (19 flows total in JSON)

* Email Templates 

    * Device Pairing
       -Device Pairing
       -OTP
    * PingOne Verify Email Address and Phone Number Verification -
       PingOne Verify Email Address and Phone Number Verification
    * Email Address Verification (Admin) 
       - Email Address Verification (Admin)
    * Email Address Verification (User) 
       - Email Address Verification (User)
       OTP
    * General -
      - General (not used)
      - MagicLink
      - OTP
      - Forgot Username

    * New Device Paired 
       - New Device Paired
    * Password Recovery 
       - Password Recovery
    * Strong Authentication 
       - Strong Authentication
    * Verification Code 
       - Verification Code
* Custom PingOne Attribute 
  - dob type=STRING
  - securityQA type=JSON

* Need to pull the Password Policy 
    This is stored a JSON attribute pulled from PingOne
    Needs to be stored in Company Variable “gv-p1PasswordPolicy”
* Chrome extension for Branding
    https://library.pingidentity.com
    Sign in
    Search on “davinci Design Studio” its version 1.0 (old is 1.2)

* You will need the following products in your PingOne environment to take advantage of all the features:
  PingOne Davinci
  PingOne Protect
  PingOne Verify
  PingOne MFA
* Other things:
You will need to gather the following:
 * PopulationId 
    DV variable: populationId
* EnvironmentId
   DV variable: 
* AgreementId
  DV variable: gv-p1AgreementId
  
* If you have a custom domain 
  * Origin -
     DV variable: origin
  * relyingParty -
     DV variable: relyingParty
  * gv-companyLogo -
     Needs to be set to your Logo URL
  * gv-companyName -
     Needs to be set to your Company Name

