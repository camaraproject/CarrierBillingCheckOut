<a href="https://github.com/camaraproject/CarrierBillingCheckOut/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/releases/latest" title="Latest Release"><img src="https://img.shields.io/github/release/camaraproject/CarrierBillingCheckOut?style=plastic"></a>

# CarrierBillingCheckOut
Repository to describe, develop, document and test the CarrierBilling APIs

## Scope
* Service APIs for “CarrierBillingCheckOut” (see APIBacklog.md)  
* It provides the API consumer with the ability to: 
  * Trigger carrier billing payment request (in one or two steps), which is a process that allows API consumers to make purchases by charging payments against Telco Operator Billing Systems.
    * Follow up of payment, by means of query endpoints to get information about a list of payments or a specific payment.
  * Trigger carrier billing refund request, which is a process that allows API consumers to ask for a `total` or `partial` return of the amount associated to a previous performed payment.
    * Follow up of refund, by means of query endpoints to get information about a list of refunds or a specific refund.
  * NOTE: The scope of these APIs should be limited (at least at a first stage) to 4G and 5G.
* Describe, develop, document and test the APIs (with 1-2 Telcos)  
  * Started: October 2022 

## Release Information
<!-- Use/uncomment one or multiple the following options -->
<!-- Pre-releases of this sub project are available in https://github.com/camaraproject/§repo_name§/releases -->
<!-- The latest public release is available here: https://github.com/camaraproject/§repo_name§/releases/latest -->
<!-- For changes see [CHANGELOG.md](https://github.com/camaraproject/§repo_name§/blob/main/CHANGELOG.md) -->
* Note: Please be aware that the project will have updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until a new release is created. For example, changes may be reverted before a release is created. **For best results, use the latest available release**.

* **The Release [r2.2](https://github.com/camaraproject/CarrierBillingCheckout/releases/tag/r2.2) for the Carrier Billing APIs Family is available.**
<br>This is a public release.

* The release **r2.2** is available in [r2.2](https://github.com/camaraproject/CarrierBillingCheckOut/tree/r2.2), and includes the following APIs:
- API name: Carrier Billing (Payment) - API Definition v0.4.0 with inline documentation:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r2.2/code/API_definitions/carrier-billing.yaml)

- API name: Carrier Billing Refund - API Definition v0.2.0 with inline documentation:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing-refund.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing-refund.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r2.2/code/API_definitions/carrier-billing-refund.yaml)

* Other releases of this sub project are available in [CarrierBillingCheckout Releases](https://github.com/camaraproject/CarrierBillingCheckout/releases)
* For changes see [CHANGELOG.md](https://github.com/camaraproject/CarrierBillingCheckout/blob/main/CHANGELOG.md)

## Contributing
* Meetings are held virtually <!-- for new API families request a meeting link from the LF admin team or replace the information with the existing meeting information (of the API family) -->
    * Schedule: Bi-Weekly, Wednesdays 13:00 - 14:00 UTC
    * [Registration / Join](https://zoom-lfx.platform.linuxfoundation.org/meeting/96513497117?password=ac26d34b-87d2-4d78-aa47-4de1ca14c882)
    * Minutes: Access [Meeting minutes](https://lf-camaraproject.atlassian.net/wiki/x/CDDe)
* Mailing List
    <!-- Note: the $sub-project-mailinglistname$ is either already existing or will be created by the CAMARA Admin Team  -->
    * Subscribe / Unsubscribe to the mailing list of this Sub Project <https://lists.camaraproject.org/g/sp-cbc>.
    * A message to the community of this Sub Project can be sent using <sp-cbc@lists.camaraproject.org>.
