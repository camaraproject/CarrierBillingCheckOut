<a href="https://github.com/camaraproject/CarrierBillingCheckOut/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/CarrierBillingCheckOut?style=plastic"></a>
<a href="https://github.com/camaraproject/CarrierBillingCheckOut/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>

# CarrierBillingCheckOut
Repository to describe, develop, document and test the CarrierBillingCheckOut API family

## Notice for the reader
The Carrier Billing family features 2 APIs with **distinct business scope**:
* 'Carrier billing checkout' : Service that provides functionality for enabling first the purchase and then the payment request against OB Carrier Billing Systems.
* 'Carrier billing payment' : Service enabling payments and payment follow-up against OB Carrier Billing Systems.

Both proposals manage the payment request & processing. 'Carrier billing checkout' proposal prerequisites a 'Purchase' creation before to trigger a payment request (The payment is performed for this purchase).
Depending on the use case an implementation could use either one of these 2 APIs. 

Reader has to be aware of this distinction because API definition as documentation are provided for both flavor.


## Scope
* Service APIs for “CarrierBillingCheckOut” (see APIBacklog.md)  
* It provides the customer with the ability to:  
  * purchase (only for 'carrier billing checkout' flavor),
  * trigger carrier billing payment request (in one or two steps) 
  * follow up of payment processing using as Payment Method Carrier Billing, i.e.: the operator performs the billing of the goods.
  * follow up of fulfilment of physical/digital goods (only for 'carrier billing checkout' flavor),
  * NOTE: The scope of this API family should be limited (at least at a first stage) to 4G and 5G.
* Describe, develop, document and test the APIs (with 1-2 Telcos)  
  * Started: October 2022
  * Location: virtually  

## Meetings
* Meetings are held virtually
* Schedule:
  * Weekly, Wednesdays 16:00 - 17:00 (GMT+1)
  * Bi-Weekly, Wednesdays 16:00 - 17:00 (GMT+1) (Starting 2023 TBD)
* Meeting link: [Link](https://teams.microsoft.com/l/meetup-join/19%3ameeting_MjlhNzg3NTctYjAyYS00ZjM0LTlmZDEtYjE2NGFmNjYyZmM5%40thread.v2/0?context=%7b%22Tid%22%3a%229744600e-3e04-492e-baa1-25ec245c6f10%22%2c%22Oid%22%3a%2219764050-b5d5-4991-9f15-d10905a94c08%22%7d)

## Results
* Sub Project is in progress

## Contributorship and mailing list
* To subscribe / unsubscribe to the mailing list of this Sub Project and thus be / resign as Contributor please visit <https://lists.camaraproject.org/g/sp-cbc>.
* A message to all Contributors of this Sub Project can be sent using <sp-cbc@lists.camaraproject.org>.
