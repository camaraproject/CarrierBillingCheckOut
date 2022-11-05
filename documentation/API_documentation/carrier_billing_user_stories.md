| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to request (using my application server/backend service) a purchase (one-time or recurring) to be billed against a customer's carrier bill, so that I can offer customers payment alternatives.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Payment/Check out on Carrier Bill* \- Initiate Carrier Billing approval process with Customer from Carrier Channels (SMS/App) |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User have initiated payment via Carrier Billing/Checkout from application/portal/product channel</li><li>The PaymentRequester have verified that associated carrier service belongs to the Customer:User (Generally as part of adding a new payment method, 2FA or equivelant)</li>|
| ***Activities/Steps*** | **Starts when:** TBD<br>**Ends when:** TBD |
| ***Post-conditions*** | TBD  |
| ***Exceptions*** | TBD|
<br>
| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to add (using my application server/backend service) CarrierBillingCheckout Payment method as a verified payment method , so that I allow customers to manage payment methods.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Carrier Eligibility/Approval for CBC* \- Verify Customer:User ownership of Carrier Service to be used in CBC. |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User have initiated adding CBC as a payment method from application/portal/product channel</li>|
| ***Activities/Steps*** | **Starts when:** TBD<br>**Ends when:** TBD |
| ***Post-conditions*** | TBD  |
| ***Exceptions*** | TBD|