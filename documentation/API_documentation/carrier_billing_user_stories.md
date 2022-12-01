**User Story: Make a Payment**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to request (using my application server/backend service) a purchase (one-time -in initial phase- or recurring -in a latter phase- ) to be billed against a customer's carrier bill, so that I can offer customers payment alternatives.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Payment/Check out on Carrier Bill* \- Initiate Carrier Billing approval process with Customer from Carrier Channels (SMS/App) |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has Carrier Billing activated.</li><li>The Customer:User have initiated payment via Carrier Billing/Checkout from application/portal/product channel</li><li>The PaymentRequester have verified that associated carrier service belongs to the Customer:User (Generally as part of adding a new payment method, 2FA or equivelant)</li></ol>|
| ***Activities/Steps*** | **Starts when:** he customer application server makes a request to the Carrier Billing Checkout to trigger the payment. Payment can be performed in 1-step or 2-step approach<br>**Ends when:** The payment is completed and the customer application customer can query details of that payment<br> |
| ***Post-conditions*** | After customer application server performs the payment, payment details can be queried  |
| ***Exceptions*** | Several exceptions might occur during the Carrier Billing API operations:<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token).</li><li>Invalid input: Not valid input data to invoke operation (e.g. merchant information not provided or unknown).</li><li>Denied by Carrier: Any user/business condition and/or regulation that forbids the perform of the payment</li><li>Conflict: Internal configuration policies don't allow for Payment Execution/Cancellation.</li></ul>|


**User Story: Retrieve a Payment/s**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to get details of performed purchases/payments, individually or list of them (using my application server/backend service), by means of that application.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Payments Details done against Carrier Billing* |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has performed payments via application, both success and failed</li></ol>|
| ***Activities/Steps*** | **Starts when:** The customer application server makes a request to the Carrier Billing Checkout to get payment/payments details performed via that application<br>**Ends when:** Response is received from Carrier Billing Checkout showing the details |
| ***Post-conditions*** | N/A  |
| ***Exceptions*** | N/A|

<br>