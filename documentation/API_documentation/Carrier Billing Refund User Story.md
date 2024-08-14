**User Story: Make a Payment Refund request in one step**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to request (using my application server/backend service) a payment refund (_total_: requesting whole payment amount or whole remaining payment amount not yet refunded, so as no more refunds can be requested; or _partial_: requesting a specific payment amount refund less than the overall amount related to the payment done, so as in principle more refunds can be requested, until performing a total refund or not having remaining payment amount to be refunded) to be billed against a customer's carrier bill. |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Refund on Carrier Bill* \- Initiate Carrier Billing Refund process with Customer from Carrier Channels (SMS/App) |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has Carrier Billing activated as payment method.</li><li>The Customer:User has initiated Refund via Carrier Billing from application/portal/product channel</li><li>The RefundRequester has verified that associated carrier billing service belongs to the Customer:User (Generally as part of adding a new payment method, 2-Factor-Authorization or equivalent)</li></ol> |
| ***Activities/Steps*** | **Starts when:** The customer application server makes a request to the Carrier Billing Refund service (API) to trigger the refund.<br>**Ends when:** The refund is completed and the customer application customer can query details of that refund.<br> |
| ***Post-conditions*** | After customer application server performs the refund, refund details can be queried. |
| ***Exceptions*** | Several exceptions might occur during the Carrier Billing Refund API operations:<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token).</li><li>Invalid input: Not valid input data to invoke operation (e.g. invalid paymentId).</li><li>Denied by Carrier: Any user/business condition and/or regulation that forbids the perform of the refund</li><li>Conflict: Internal configuration policies don't allow for Refund Execution.</li></ul> |


**User Story: Retrieve a Payment Refund from its identifier**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to get details of one performed refund (from its id) by means of that application. |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Refund Details done against Carrier Billing* |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has performed refunds via application, both success and failed</li><li>The Customer:User has payment identification and refund identification.</li></ol> |
| ***Activities/Steps*** | **Starts when:** The customer application server makes a request to the Carrier Billing Refund service (API) to get refund details performed via that application providing payment identifier and refund identifier.<br>**Ends when:** Response is received from Carrier Billing Refund service showing the refund details |
| ***Post-conditions*** | Requester receives a complete representation of the refund. |
| ***Exceptions*** | Several exceptions might occur during the Carrier Billing Refund API operations:<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token).</li><li>Invalid input: Not valid payment identifier or refund identifier to invoke operation.</li><li>Denied by Carrier: Any user/business condition and/or regulation that forbids the retrieval of the refund</li></ul> |


**User Story: Retrieve a Payment Refunds list**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to get a list of performed refunds from criteria (using my application server/backend service), by means of that application. |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Refunds list done against Carrier Billing* |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has performed refunds via application, both success and failed</li><li>The requester provides a list of criteria(s) to select refund (Customer/user identifier, refund status)</li></ol> |
| ***Activities/Steps*** | **Starts when:** The customer application server makes a request to the Carrier Billing Refund service (API) to get refund/refunds details performed via that application<br>**Ends when:** Response is received from Carrier Billing Refund service showing the details |
| ***Post-conditions*** | N/A |
| ***Exceptions*** | Several exceptions might occur during the Carrier Billing Refund API operations:<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token).</li><li>Denied by Carrier: Any user/business condition and/or regulation that forbids the retrieval of the refund</li></ul> |


**User Story: Retrieve a Payment Amount Not Refunded yet**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to get the remaining amount not yet refunded for a given payment (using my application server/backend service), by means of that application. |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Application service providers, hyperscalers, application developers. <br> **Scope:** *Request Remaining Amount not yet refunded done against Carrier Billing* |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has performed refunds via application, both success and failed</li><li>The requester provides payment identification</li></ol> |
| ***Activities/Steps*** | **Starts when:** The customer application server makes a request to the Carrier Billing Refund service (API) to get the remaining amount not yet refunded for a given paymentId performed via that application<br>**Ends when:** Response is received from Carrier Billing Refund service showing the remaining amount not yet refunded |
| ***Post-conditions*** | N/A |
| ***Exceptions*** | Several exceptions might occur during the Carrier Billing Refund API operations:<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token). |

<br>
