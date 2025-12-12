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

<!-- CAMARA:RELEASE-INFO:START -->
<!-- This section is automatically maintained by the CAMARA project-administration tooling: https://github.com/camaraproject/project-administration -->

## Release Information

> [!NOTE]
> Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until a new release is created. For example, changes may be reverted before a release is created. **For best results, use the latest available release**.

* **NEW**: The latest public release is [r3.2](https://github.com/camaraproject/CarrierBillingCheckOut/releases/tag/r3.2) (Fall25), with the following API versions:
  * **carrier-billing-refund v0.3.0**
  [[YAML]](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r3.2/code/API_definitions/carrier-billing-refund.yaml)
  [[ReDoc]](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r3.2/code/API_definitions/carrier-billing-refund.yaml&nocors)
  [[Swagger]](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r3.2/code/API_definitions/carrier-billing-refund.yaml)
  * **carrier-billing v0.5.0**
  [[YAML]](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r3.2/code/API_definitions/carrier-billing.yaml)
  [[ReDoc]](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r3.2/code/API_definitions/carrier-billing.yaml&nocors)
  [[Swagger]](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r3.2/code/API_definitions/carrier-billing.yaml)
* The latest public release is always available here: https://github.com/camaraproject/CarrierBillingCheckOut/releases/latest
* Other releases of this repository are available in https://github.com/camaraproject/CarrierBillingCheckOut/releases
* For changes see [CHANGELOG.md](https://github.com/camaraproject/CarrierBillingCheckOut/blob/main/CHANGELOG.md)

_The above section is automatically synchronized by CAMARA project-administration._
<!-- CAMARA:RELEASE-INFO:END -->

## Contributing
* Meetings are held virtually 
    * Schedule: Bi-Weekly, Wednesdays 13:00 - 14:00 UTC
    * [Registration / Join](https://zoom-lfx.platform.linuxfoundation.org/meeting/96513497117?password=ac26d34b-87d2-4d78-aa47-4de1ca14c882)
    * Minutes: Access [Meeting minutes](https://lf-camaraproject.atlassian.net/wiki/x/CDDe)
* Mailing List
    * Subscribe / Unsubscribe to the mailing list of this Sub Project <https://lists.camaraproject.org/g/sp-cbc>.
    * A message to the community of this Sub Project can be sent using <sp-cbc@lists.camaraproject.org>.
