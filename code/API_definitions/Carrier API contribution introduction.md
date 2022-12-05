

# Document objective

The following document provide a quick introduction of the Orange contribution for a Carrier Billing API

# Use Case Definition

The API swagger proposal covers sequence diagram illustrated in supportingDocument folder



Note:
The API allows to manage :

- a one-step payment (the request is a request to 'execute' a payment) or
- a 2-steps payment - in this case the first step is a payment preparation request that must be later conformed in order to be 'executed. It is possible to cancel a payment preparation.
- retrieve payment by if
- search payment from criterias


# API definition

The proposed API did not features 'purchase' resource management. The purchase could be handeld separatly in another API 
The purchase id could be referred in the payment (via referenceCode or via an explicit attribute to be added). 

In order to keep consistence with operator existing assets, the API resource model is directly design from standard RESTful Network API for Payment from the Open Mobile Alliance.

# API open points

- use of an explicit attribute to identify the msisdn 'to be charged' (to put right, to identyfy the account which must be charged. This account is identified via the msisdn linked to the account).
- The API could be simplified (for example remove resourceURL, serverReferenceode, etc...atributes if not relevant for our UC)
- Payment lifecyle must be disccussed - OMA could bve used as proposal and simplified
