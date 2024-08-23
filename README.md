<a href="https://github.com/camaraproject/CarrierBillingCheckOut/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/releases/latest" title="Latest Release"><img src="https://img.shields.io/github/release/camaraproject/CarrierBillingCheckOut?style=plastic"></a>

# CarrierBillingCheckOut
Repository to describe, develop, document and test the CarrierBilling API family

## Scope
* Service APIs for “CarrierBillingCheckOut” (see APIBacklog.md)  
* It provides the customer with the ability to: 
  * trigger carrier billing payment request (in one or two steps) 
  * follow up of payment processing using as Payment Method Carrier Billing, i.e.: the operator performs the billing of the goods.
  * NOTE: The scope of this API family should be limited (at least at a first stage) to 4G and 5G.
* Describe, develop, document and test the APIs (with 1-2 Telcos)  
  * Started: October 2022
  * Location: virtually  

## Release Information
<!-- Use/uncomment one or multiple the following options -->
<!-- Pre-releases of this sub project are available in https://github.com/camaraproject/§repo_name§/releases -->
<!-- The latest public release is available here: https://github.com/camaraproject/§repo_name§/releases/latest -->
<!-- For changes see [CHANGELOG.md](https://github.com/camaraproject/§repo_name§/blob/main/CHANGELOG.md) -->
* **The Release [r1.1 - rc](https://github.com/camaraproject/CarrierBillingCheckOut/blob/main/CHANGELOG.md#r1.1---rc) for the Carrier Billing APIs Family is available.**
<br>This is a release candidate. Until the public release there are bug fixes to be expected. The release candidate is suitable for implementors, but it is not recommended to use the API with customers in productive environments.
* The release **r1.1 - rc** is available in [r1.1](https://github.com/camaraproject/CarrierBillingCheckOut/tree/r1.1), and includes the following APIs:
- API name: Carrier Billing (Payment) - API Definition v0.3.0-rc.1 with inline documentation:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.1/code/API_definitions/carrier_billing.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.1/code/API_definitions/carrier_billing.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r1.1/code/API_definitions/carrier_billing.yaml)

- API name: Carrier Billing Refund - API Definition v0.1.0-rc.1 with inline documentation:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.1/code/API_definitions/carrier_billing_refund.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.1/code/API_definitions/carrier_billing_refund.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r1.1/code/API_definitions/carrier_billing_refund.yaml)

* For changes between r1.1 and v0.2.1 see the [CHANGELOG.md](https://github.com/camaraproject/CarrierBillingCheckOut/blob/main/CHANGELOG.md)

* **The latest available and released version 0.2.1 is available within the [release-0.2.1 branch](https://github.com/camaraproject/CarrierBillingCheckOut/tree/release-v0.2.1)**
  - API name: Carrier Billing (Payment) - API Definition v0.2.1 with inline documentation:
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/release-v0.2.1/code/API_definitions/carrier_billing.yaml&nocors)
    - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/release-v0.2.1/code/API_definitions/carrier_billing.yaml)
    - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/release-v0.2.1/code/API_definitions/carrier_billing.yaml)

## Contributing
* Meetings are held virtually <!-- for new API families request a meeting link from the LF admin team or replace the information with the existing meeting information (of the API family) -->
    * Schedule: Bi-weekly (odd weeks), Wednesday, 3 PM CET/CEST (13:00 UTC,21:00 Beijing)
    * [Registration / Join](https://zoom-lfx.platform.linuxfoundation.org/meeting/96513497117?password=ac26d34b-87d2-4d78-aa47-4de1ca14c882)
    * Minutes: Access [Meeting minutes](https://wiki.camaraproject.org/display/CAM/CarrierBillingCheckOut)
* Mailing List
    <!-- Note: the $sub-project-mailinglistname$ is either already existing or will be created by the CAMARA Admin Team  -->
    * Subscribe / Unsubscribe to the mailing list of this Sub Project <https://lists.camaraproject.org/g/sp-cbc>.
    * A message to the community of this Sub Project can be sent using <sp-cbc@lists.camaraproject.org>.
