**User Story: Make a Payment request in one step**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to request (using my application server/backend service) a payment (one-time fee -in initial phase- or recurring -in a later phase- ) to be billed against a customer's carrier bill, so that I can offer customers payment alternatives.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Payment on Carrier Bill* \- Initiate Carrier Billing approval process with Customer from Carrier Channels (SMS/App) |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has Carrier Billing activated as payment method.</li><li>The Customer:User has initiated payment via Carrier Billing from application/portal/product channel</li><li>The PaymentRequester has verified that associated carrier billing service belongs to the Customer:User (Generally as part of adding a new payment method, 2-Factor-Authorization or equivalent)</li></ol>|
| ***Activities/Steps*** | **Starts when:** The customer application server makes a request to the Carrier Billing service (API) to trigger the payment.<br>**Ends when:** The payment is completed and the customer application customer can query details of that payment.<br> |
| ***Post-conditions*** | After customer application server performs the payment, payment details can be queried.  |
| ***Exceptions*** | Several exceptions might occur during the Carrier Billing API operations:<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token).</li><li>Invalid input: Not valid input data to invoke operation (e.g. merchant information not provided or unknown).</li><li>Denied by Carrier: Any user/business condition and/or regulation that forbids the perform of the payment</li><li>Conflict: Internal configuration policies don't allow for Payment Execution/Cancellation.</li></ul>|


**User Story: Make a Payment request in two steps**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to request (using my application server/backend service) a payment (one-time fee -in initial phase- or recurring -in a later phase- ) to be billed against a customer's carrier bill, so that I can offer customers payment alternatives. The payment process will be split in 2 parts:<br><ol><li>Payment preparation request (that did not trigger the payment but only prepare it) </li><li> Payment confirmation or cancellation. The payment confirmation triggers the payment itself.</li></ol> |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Payment on Carrier Bill* \- Initiate Carrier Billing 2-steps approval process with Customer from Carrier Channels (SMS/App) |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has Carrier Billing activated as payment method.</li><li>The Customer:User has initiated 2-steps payment via Carrier Billing from application/portal/product channel</li><li>The PaymentRequester has verified that associated carrier service belongs to the Customer:User (Generally as part of adding a new payment method, 2FA or equivalent)</li></ol>|
| ***Activities/Steps*** | **Starts when:** The customer application server makes a request to the Carrier Billing service (API) to trigger a 2-steps payment. <br>**Intermediate steps:** The customer application server makes a request to confirm or cancel the payment preparation <br>**Ends when:** If payment confirmation is provided the payment is completed. If a payment cancellation is provided (explicit cancellation) or if neither a confirmation or cancellation is received after a predefined business delay (implicitly by expiration), the payment preparation is cancelled. <br>For both cases the customer application can retrieve and/or query details of that payment<br> |
| ***Post-conditions*** | After customer application server performs the payment, payment details can be queried. A payment can stay in preparation status only for a predefined business delay.  |
| ***Exceptions*** | Several exceptions might occur during the Carrier Billing API operations:<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token).</li><li>Invalid input: Not valid input data to invoke operation like for example: <br>merchant information not provided or unknown,<br>payment identifier not existing or not linked to the customer:user,<br>payment confirmation for an expired payment,<br>payment cancellation request for an already confirmed payment).</li><li>Denied by Carrier: Any user/business condition and/or regulation that forbids the perform of the payment. Payment preparation as payment confirmation could be denied</li><li>Conflict: Internal configuration policies don't allow for Payment Execution/Cancellation.</li></ul>|


**User Story: Retrieve a Payment from its identifier**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to get details of one performed payment (from its id) by means of that application.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Payments Details done against Carrier Billing* |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has performed payments via application, both success and failed</li><li>The Customer:User has payment identification.</li></ol>|
| ***Activities/Steps*** | **Starts when:** The customer application server makes a request to the Carrier Billing service (API) to get payments details performed via that application providing payment identifier.<br>**Ends when:** Response is received from Carrier Billing service showing the payment details |
| ***Post-conditions*** | Requester receives a complete representation of the payment. |
| ***Exceptions*** | Several exceptions might occur during the Carrier Billing API operations:<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token).</li><li>Invalid input: Not valid payment identifier to invoke operation.</li><li>Denied by Carrier: Any user/business condition and/or regulation that forbids the retrieval of the payment</li></ul>|


**User Story: Retrieve a Payment list**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to get a list of performed payments from criteria (using my application server/backend service), by means of that application.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Payments list done against Carrier Billing* |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has performed payments via application, both success and failed</li><li>The requester provides a list of criteria(s) to select payment (Customer/user identifier, payment status)</li></ol>|
| ***Activities/Steps*** | **Starts when:** The customer application server makes a request to the Carrier Billing service (API) to get payment/payments details performed via that application<br>**Ends when:** Response is received from Carrier Billing service showing the details |
| ***Post-conditions*** | N/A  |
| ***Exceptions*** | Several exceptions might occur during the Carrier Billing API operations:<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token).</li><li>Denied by Carrier: Any user/business condition and/or regulation that forbids the retrieval of the payment</li></ul>|

<br>
