<a href="https://github.com/camaraproject/CarrierBillingCheckOut/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/releases/latest" title="Latest Release"><img src="https://img.shields.io/github/release/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/Governance/blob/main/ProjectStructureAndRoles.md" title="Sandbox API Repository"><img src="https://img.shields.io/badge/Sandbox%20API%20Repository-yellow?style=plastic"></a>

# CarrierBillingCheckOut

Sandbox API Repository to describe, develop, document, and test the CarrierBillingCheckOut Service API(s). The repository does not yet belong to a CAMARA Sub Project.

* API Repository [wiki page](https://lf-camaraproject.atlassian.net/wiki/x/CDDe)

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

* **The Release [r2.2](https://github.com/camaraproject/CarrierBillingCheckout/releases/tag/r2.2) of the Carrier Billing APIs is available.**
<br>This is a public release.

* The release **r2.2** is available in [r2.2](https://github.com/camaraproject/CarrierBillingCheckOut/tree/r2.2), and includes the following APIs:
- API name: Carrier Billing (Payment) - API Definition v0.4.0 with inline documentation:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r2.2/code/API_definitions/carrier-billing.yaml)

- API name: Carrier Billing Refund - API Definition v0.2.0 with inline documentation:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing-refund.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing-refund.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r2.2/code/API_definitions/carrier-billing-refund.yaml)

* Other releases of this sub project are available in [CarrierBillingCheckout Releases](https://github.com/camaraproject/CarrierBillingCheckout/releases)
* For changes see [CHANGELOG.md](https://github.com/camaraproject/CarrierBillingCheckout/blob/main/CHANGELOG.md)

## Mock Server

You can now try out the Carrier Billing API without any backend setup. Use a hosted mock server generated from the OpenAPI spec to simulate real-world interactions. This is useful for exploring the API structure, understanding expected request/response payloads, and testing integration flows before actual service provisioning.

Click below to launch a mock server instantly:

<a href="https://beeceptor.com/openapi-mock-server/?utm_source=github&utm_campaign=camaraproject-carrierbillingcheckout&url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/1fc73deae53bd98e337984b38a4c327057b49d7e/documentation/SupportingDocuments/carrier_billing_payment.yaml" target="_blank"><img src="https://cdn.beeceptor.com/assets/images/buttons/mock-openapi-with-beeceptor.png" alt="Mock These APIs Instantly" style="height: 60px;"></a>


## Contributing
* Meetings are held virtually 
    * Schedule: Bi-Weekly, Wednesdays 13:00 - 14:00 UTC
    * [Registration / Join](https://zoom-lfx.platform.linuxfoundation.org/meeting/96513497117?password=ac26d34b-87d2-4d78-aa47-4de1ca14c882)
    * Minutes: Access [Meeting minutes](https://lf-camaraproject.atlassian.net/wiki/x/CDDe)
* Mailing List
    * Subscribe / Unsubscribe to the mailing list of this Sub Project <https://lists.camaraproject.org/g/sp-cbc>.
    * A message to the community of this Sub Project can be sent using <sp-cbc@lists.camaraproject.org>.
