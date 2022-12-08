# Overview

<span class="colour" style="color:rgb(0, 0, 0)">The Carrier Billing Payment API provides programmable interface for developers and other users (capabilities consumers) to charge
 a digital content purchase or subscription to the mobile line invoice.  </span> 

## 1\. Introduction


The Carrier Billing Payment API is used by an application to charge an amount on the 
mobile line. It can be easily integrated ans used through this secured API and 
allows end-users to buy digital content in an easy & secured way. The API provides management of a payment entity and its associated lifecycle. 

The carrier billing Payment API is driven from Open Mobile Alliance standard.


## 2\. Quick Start

The usage of the API is based on Payment resource, which can be created (in 1 or 2 steps), confirmed (for 2-steps process), cancelled (for 2-steps process), queried and retrieved.


Before starting to use the API, the developer needs to know about the below specified details:

**payment service endpoint**
The URL pointing to the RESTful resource of the payment API.
As we manage 1-step and 2-steps process we have defined 2 separate tags to explicilty
distinct them in the swagger. A third tage 'payment' is defined for common operations for
both process (query & retrieve)

**Authentication**
Security access keys such as OAuth 2.0 client credentials used by Client applications to invoke the Carrier Billing Payment API.

**1-Step & 2-Steps**
1-Step process is very simple: The request intent is to charge an amount to the mobile line. When the server the request, it will check account associated with this line and if nothing prevent it, the amount is charged and will be bill in next invoice or removed from line credit.
For 2-steps, the first call is to request a payment preparation. The amount is not charged and the server has to be ready to get a confirmation or a cancellation to perform the payment. Only when the confirmation is done, payment is charged. Depending on business rules of the Telco operator, a 'prepared' payment could expire after n days.

**Identifier for the the mobile line to be charged**
In order to identify the mobile line to be chaged an identifer must be provided. This identifies is mapped to the endUserId attribute.


**Notification URL**
Developers may provide a callback URL on which status change notifications regarding the payment can be received from the service provider. This is an optional parameter.



Sample API invocations are presented in Section 4.6.

## 3\. Authentication and Authorization

The Carrier Billing Payment API makes use of the OAUTH 2.0 client credentials grant which is applicable for server to server use cases involving trusted partners
or clients without any protected user data involved.
In this method the API invoker client is registered as a confidential client with an authorization grant type of client_credentials [[1]](#1).

## 4\. API Documentation

### 4.1 API Version

0.5.0

### 4.2 Details

#### 4.2.1 API sequencing

As described above, the API accomodates 2 distinc processes: one step process (direct request to charge) and two steps process (which requires an intermediate step to confirm/cancel a payment request)

Following diagram shows the API resources operation sequencing

<br>

<img src="./resources/Carrier_Billing_Payment_sequence_diagram.png" alt="PaymentSequence" title="Carrier Billing Payment API sequence diagram">

#### 4.2.1 API attributes 


Attribute definition

**Payment Class description:**

 **Name** | **Description** | **Comment** |
| -------- | --------- | ----------- |
| endUserId | Identify the mobile account to be charged - in general mobile number is provided | Mandatory attribute in POST request |
| clientCorrelator | Provided by the requester - Uniquely identifies this create charge request | Optionally valued by requester |
| paymentAmount | See PaymentAmount class table description| Mandatory attribute in POST request |
| referenceCode | Merchant generated payment reference to uniquely identify the request, for example the purchase or order identifier | Mandatory attribute in POST request |
| transactionOperationStatus | Specifies the payment status (example: Processing, Denied, Reserved, Succeeded, Cancelled) | Must be valued by server side (not is POST request) |
| resourceURL | URI of the created resource (same as in the Location header) | Only valued (optionally) by server side (not is POST request) |
| serverReferenceCode | Reference to the charge or refund, provided by the server, and meaningful to the server’s backend system for the purpose of reconciliation | Only valued (optionally) by server side (not is POST request) |
| notificationUrl | Allows asynchronous delivery of purchase related events | Optionally valued by requester - if used, customer needs to have a notification endpoint |

**PaymentAccount class description:**

2 classes are defined:

ChargingInformation:

 **Name** | **Description** | **Comment** |
| -------- | --------- | ----------- |
| amount | Amount to be charged or reserved (number) | Mandatory attribute in POST request |
| currency | Currency identifier as defined in [ISO4217] | Mandatory attribute in POST request |
| description | Description text to be used for information and billing text | Mandatory attribute in POST request|


ChargingMetaData

 **Name** | **Description** | **Comment** |
| -------- | --------- | ----------- |
| onBehalfOf | Allows aggregators/partners to specify the actual payee | Optionally valued by requester |
| purchaseCategoryCode | Allows aggregators/partners to specify the actual payee | Optionaly valued by requester |
| channel | Channel where the order occurred | Optionally valued by requester |
| taxAmount | The tax amount charged by the merchant if the charge has tax already included (number). This also provides an indicator to the downstream billing system | Optionaly valued by requester |
| serviceId | Identifier of service related to the payment | Optionally valued by requester |
| productId | Identifier of product related to the payment | Optionally valued by requester |

**Payment State engine**

Follow schema provides information about the payment state engine (state description & transition)

<img src="./resources/Carrier_Billing_Payment_State_Engine.jpg" alt="PaymentState" title="Carrier Billing Payment API state engine">


### 4.3 Endpoint Definitions

Following table defines API endpoints of exposed REST based for Carrier Billing Payment API management operations.

| **Endpoint** | **Operation** | **Description** |
| -------- | --------- | ----------- |
| POST<br>  \<base-url>/payment/v0/payments | **Create one step payment** | Create request for one step payment |
| POST<br>  \<base-url>/payment/v0/payments/prepare | **Create two steps payment** | Create request for two step payment |
| POST<br>  \<base-url>/payment/v0/payments/confirm/{paymentId} | **Confirm a two steps payment** | Confirmation request for a prepared payment |
| POST<br>  \<base-url>/payment/v0/payments/cancel/{paymentId} | **Cancel a two steps payment** | Cancellation request for a prepared payment |
| GET<br> \<base-url>/payment/v0/payments | **Query for payment** | Querying for payment with criteria |
| GET<br> \<base-url>/payment/v0/payments/{paymentId} | **Retrieve payment** | Retrieve payment |
<br>

#### Carrier Billing Payment Resource Operations:
<br>

| **Create payment resource (one step)** |
| -------------------------- |
| **HTTP Request**<br> POST \<base-url>/payment/v0/payments<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> endUserId must be provided <br>**Request Body Parameters**<br> See above table for attribute definition.<br> Following attributes are mandatory in the request: endUserId; paymentAmount.chargingInformation.amount; paymentAmount.chargingInformation.currency ; paymentAmount.chargingInformation.description ; referenceCode.<br>Following attributes are only valued on server side and not present in POST request: transactionOperationStatus; resourceURL ; serverReferenceCode.

 <br>**Response**<br> **201: payment created**<br>  Response body: A complete payment representation as described in above table is provided. <br> **400:** **Invalid input.**<br> **401:** **Un-authorized. <br> **403:** Forbidden.**<br> **409:** **Conflict.**<br> **500:** **Server Error.**<br> **503:** **Service temporarily unavailable.** |
<br>


| **Create payment resource (two steps)** |
| -------------------------- |
 **HTTP Request**<br> POST \<base-url>/payment/v0/payments/prepare<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> endUserId must be provided <br>**Request Body Parameters**<br> See above table for attribute definition. Following attributes are mandatory in the request: endUserId; paymentAmount.chargingInformation.amount; paymentAmount.chargingInformation.currency ; paymentAmount.chargingInformation.description ; referenceCode. Folowing attributes are only valued on server side and not present in POST request: transactionOperationStatus; resourceURL ; serverReferenceCode.

 **Response**<br> **201: payment created**<br>  Response body: A complete payment representation as described in above table is provided. <br> **400:** **Invalid input.**<br> **401:** **Un-authorized. <br> **403:** Forbidden.**<br> **409:** **Conflict.**<br> **500:** **Server Error.**<br> **503:** **Service temporarily unavailable.** 
<br>


| **Confirm payment task (only for two steps process)** |
| -------------------------- |
 **HTTP Request**<br> POST \<base-url>/payment/v0/payments/confirm/{paymentId<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> endUserId and PaymentId must be provided <br>**Request Body Parameters**<br> none

 **Response**<br> **200: payment confirmation accepted** <br>Response body: None <br><br> **400:** **Invalid input.**<br> **401:** **Un-authorized. <br> **403:** Forbidden.**<br> **409:** **Conflict.**<br> **500:** **Server Error.**<br> **503:** **Service temporarily unavailable.** 
<br>

| **Cancel payment task (only for two steps process)** |
| -------------------------- |
 **HTTP Request**<br> POST \<base-url>/payment/v0/payments/cancel/{paymentId}<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> endUserId and PaymentId must be provided <br>**Request Body Parameters**<br> none

 **Response**<br> **202: payment cancellation accepted** <br>Response body: None <br><br> **400:** **Invalid input.**<br> **401:** **Un-authorized. <br> **403:** Forbidden.**<br> **409:** **Conflict.**<br> **500:** **Server Error.**<br> **503:** **Service temporarily unavailable.** 
<br>


#### Query for payment resource

| **Quering payment Resource /id information** |
| --------------------------------------- |
| **HTTP Request**<br> GET\<base-url>/payment/v0/payments/{paymentId}<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> paymentId: paymentId id that was obtained from the Create payment operation.<br>**Request Body Parameters**<br> No request body parameters are defined.<br>**Response**<br><br> **200: Payment information returned.**<br>  Response body:<br> Complete payment representation as defined in the above table.<br><br> **401:** Un-authorized. <br> **403:** Forbidden. <br> **404:** Payment not found.<br> **503:** Service temporarily unavailable. |
<br>


| **Quering payment Resource /list information** |
| --------------------------------------- |
| **HTTP Request**<br> GET\<base-url>/payment/v0/payments/{paymentId}<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> endUserId: Identify the mobile account  charged - in general mobile number is provided<br> fields: Comma-separated pattributes to be provided in response <br> offset: Requested index for start of resources to be provided in response <br> limit: Requested number of resources to be provided in response <br>**Request Body Parameters**<br> No request body parameters are defined.<br>**Response**<br><br> **200: a list of payment(s).**<br>  Response body:<br> An array of payment representation. It could be empty if no payment match search criteria.<br><br> **401:** Un-authorized. <br> **403:** Forbidden. <br> <br> **503:** Service temporarily unavailable. |
<br>

### 4.4 Errors

Since CAMARA Carrier Billing Payment API is based on REST design principles and blueprints, well defined HTTP status codes and families specified by community are followed [[2]](#2).

Details of HTTP based error/exception codes for the Carrier Billing Payment API are described in Section 4.3 of each API REST based method.
Following table provides an overview of common error names, codes, and messages applicable to Carrier Billing Payment API.

| No | Error Name | Error Code | Error Message |
| --- | ---------- | ---------- | ------------- |
|1	|400 |	INVALID_INPUT |	"Expected property is missing: endUserId" |
|2	|400 |	INVALID_INPUT |	"Expected property is missing: referenceCode" |
|3	|400 |	INVALID_INPUT |	"Expected property is missing: paymentAmount.chargingInformation.amount" |
|4	|400 |	INVALID_INPUT |	"Expected property is missing: paymentAmount.chargingInformation.currency" |
|5	|400 |	INVALID_INPUT |	"Expected property is missing: paymentAmount.chargingInformation.description" |
|6	|400 |	INVALID_INPUT |	"Expected property is missing: paymentId" |
|7	|400 |	INVALID_INPUT |	"Expected property is missing: qos" |
|8	|400 |	INVALID_INPUT |	"Payment status does not allow to confirm it" |
|9	|400 |	INVALID_INPUT |	"Payment status does not allow to cancel it" |
|10	|401 |	UNAUTHORIZED |	"No authorization to invoke operation" |
|11	|403 |	FORBIDDEN |	"Operation not allowed" |
|12	|404 |	NOT_FOUND |	"Payment Id does not exist" |
|13	|409 |	CONFLICT |	"Another payment is created for the same client correlator" |
|14	|500 |	INTERNAL |	"Payment could not be created" |
|15	|503 |	SERVICE_UNAVAILABLE |	"Service unavailable" |

### 4.5 Policies

N/A

### 4.6 Code Snippets
<br>
<span class="colour" style="color:rgb(36, 41, 47)">Snippet 1, elaborates REST based API call with "*curl"* to create a payment for a Video on demand payment </span>



Please note, the credentials for API authentication purposes need to be adjusted based on target security system configuration.

| Snippet 1. Create Payment resource  |
| ----------------------------------------------- |
| curl -X 'POST' `https://sample-base-url/payment/v0/payments`   <br>    -H 'accept: application/json' <br>    -H 'Content-Type: application/json'<br>    -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbG...."<br>    -d '{ "amountTransaction": { "endUserId": "+33068741256+d", "paymentAmount": { "chargingInformation": { "amount": 2.99, "currency": "EUR", "description": "VOD charge" }, "chargingMetaData": { "onBehalfOf": "VOD Service", "purchaseCategoryCode": "Purchase Movie", "channel": "TV", "taxAmount": 0.84, "serviceId": "N/A", "productId": "vod-47" } }, "referenceCode": "vod081220225698", "clientCorrelator": "78g9-dfg6-fgtr6" }, "notificationUrl": "https://callback..."  |
| response will be: <br> 201 <br>   -d '{ "amountTransaction": { "endUserId": "+33068741256+d", "paymentAmount": { "chargingInformation": { "amount": 2.99, "currency": "EUR", "description": "VOD charge" }, "chargingMetaData": { "onBehalfOf": "VOD Service", "purchaseCategoryCode": "Purchase Movie", "channel": "TV", "taxAmount": 0.84, "serviceId": "N/A", "productId": "vod-47" } }, "referenceCode": "vod081220225698", "clientCorrelator": "78g9-dfg6-fgtr6", "transactionOperationStatus": "succeeded", "resourceURL": "https://localhost:9091/payment/v0/payments/7896321", "serverReferenceCode": "7896321" }, "notificationUrl": "https://callback..." }'|
<br>


### 4.7 FAQ's

(FAQs will be added in a later version of the documentation)

### 4.8 Terms

N/A

### 4.9 Release Notes

N/A

## References


<a name="1">[1] [CAMARA Commonalities : Authentication and Authorization Concept for Service APIs](https://github.com/camaraproject/WorkingGroups/blob/main/Commonalities/documentation/Working/CAMARA-AuthN-AuthZ-Concept.md) <br>
<a name="2">[2] [HTTP Status codes spec](https://restfulapi.net/http-status-codes/) <br>
