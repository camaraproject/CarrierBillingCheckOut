# Overview

<span class="colour" style="color:rgb(0, 0, 0)">The Carrier Billing Checkout API provides programmable interface for developers and other users (capabilities consumers) to charge
 a digital content purchase or subscription to the mobile line invoice.</span> 

## 1\. Introduction

The Carrier Billing Checkout API enables an application to perform a purchase of a digital good (Content -e.g. Online Gaming related content-, Smart Mobility solutions -transport tickets, Event tickets, etc.-, Live Sports Streamings,...) and its associated payment guaranteeing security.

The API also provides functionality to check the follow-up of a purchase and its lifecycle.

Intented for a future phase:<br>
* Details about a list of Purchases
* Purchase subscriptions 
* Notification Callbacks<br/>


## 2\. Quick Start

The usage of the API is based on Purchase and Payment concepts.
* **Purchase**: The action of acquiring a good, service or product.
* **Payment**: The act or process of paying for that good, service or product. In the scope of Carrier Billing Family APIs this process can be attempted in a 1-step (execute payment) or a 2-step (prepare payment and later confirm OR cancel it). 

Within functionality covered in current API Proposal:
* Regarding the purchase:
  * It is possible to create a new purchase and make the follow-up of its lifecycle.

* Regarding the payment:
  * Note the payment action is performed over the "purchase"
  * Current model is focused in a 2-step approach, given that as part of the flow OTP validation is performed (i.e output of prepare payment), so it is involved a user interaction within it.

NOTE: It will be evaluated 1-step approach for future scenarios.


Before starting to use the API, the developer needs to know about the below specified details:

**Service endpoints**
API exposes five endpoints as mentioned later in section 4.3. Two of them enable the creation and query of a purchase and the rest three the management of the payment (preparation and/or confirmation)

**Authentication**
Security access keys such as OAuth 2.0 3-legged Access Tokens used by Client applications to invoke the Carrier Billing Checkout API on behalf of end-users.

**1-Step & 2-Steps**
<br>
For 1-Step process, it is intended as future functionality.<br>
For 2-Step process:
* The first call is to request a payment preparation over the specific purchase. Among other information, output provides a mean to perform OTP validation (managed from API Server). 
* Second step is to confirm OR cancel this payment, so the process reaches a final status. Only when the confirmation is done, payment is charged. Depending on business rules of the Telco operator, a 'prepared' payment could expire after a defined delay.

**Identifier for the mobile line to be charged**
Identification of the mobile line to be charged is performed as part of the enforcement of the Access Token issued to the client application.

**Notifications Model**
Targetted for a future phase


Sample API invocations are presented in Section 4.6.

## 3\. Authentication and Authorization

The Carrier Billing Checkout API makes use of the OAUTH 2.0 auth_code grant which allows for 3-legged Access Tokens.[[1]](#1).

## 4\. API Documentation

### 4.1 API Version

0.5.0

### 4.2 Details

The usage of the Carrier Billing Checkout API is based on two concepts:
* **Purchase**: The action of acquiring a good, service or product. The concept of purchase is related to the item/s that comprised the action performed by the user and intention is to abstract the details of each process from its payment, that is a common procedure.
* **Payment**: The act or process of paying for that good, service or product. Currently a 2-step process is designed (prepare payment and later confirm OR cancel it). 

A purchase can be created and also queried for making a follow-up of its lifecycle.<br>
A payment can be performed over a specific purchase:
* Prepare Payment: It allows to perform internal server logic in order to check if payment conditions are met (e.g. purchase amount does not overpassed any regulation or user limits).
* Confirm Payment: It allows to effectively execute payment. A confirmed payment cannot be cancelled.
* Cancel Payment: It allows to explicitly discard payment. New purchase process has to be initiated after a cancellation.

Following diagram shows the API resources operation sequencing
<br>

<img src="./resources/Carrier_Billing_Checkout_sequence_diagram.png" alt="CarrierBillingSequence" title="Carrier Billing Checkout API sequence diagram">
<br>

**Purchase State engine**

A Purchase can have the following status:
* `initialising` - Purchase process is triggered
* `ready_to_confirm` - PreparePayment has been successfully accomplished
* `processing` - ConfirmPayment has been successfully triggered
* `succeeded` - ConfirmPayment has been successfully executed
* `failed` - Purchase process failed at any step. New purchase needs to be triggered
* `cancelled` - CancelPayment has been successfully accomplished

Follow schema provides information about the payment state engine (state description & transition)
<br>

<img src="./resources/Carrier_Billing_Checkout_State_Engine.png" alt="PurchaseState" title="Carrier Billing Checkout API state engine">


### 4.3 Endpoint Definitions

Following table defines API endpoints of exposed REST based for Carrier Billing Checkout operations.

| **Endpoint** | **Operation** | **Description** |
| -------- | --------- | ----------- |
| POST<br>  \<base-url>/carrier-billing-checkout/v0/purchases | **createPurchase** | Creates a new purchase |
| GET<br> \<base-url>/carrier-billing-checkout/v0/purchases/{purchase_id} | **getPurchaseInfo** | Retrieve Purchase Information |
| POST<br> \<base-url>/carrier-billing-checkout/v0/purchases/{purchase_id}/payment/prepare | **preparePayment** | Creates a new Payment |
| POST<br> \<base-url>/carrier-billing-checkout/v0/purchases/{purchase_id}/payment/confirm | **confirmPayment** | Confirm a Payment |
| POST<br> \<base-url>/carrier-billing-checkout/v0/purchases/{purchase_id}/payment/cancel | **cancelPayment** | Cancel a Payment |
<br>

#### Carrier Billing Checkout Operations:
<br>

| **Create a new Purchase** |
| -------------------------- |
| **HTTP Request**<br> POST \<base-url>/carrier-billing-checkout/v0/purchases<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> No path parameters are defined. <br>**Request Body Parameters**<br> **payable**: polimorphic object that represents the purchase concept. Currently one defined is of type `digital_good` and it is extensible with new types in future.<br> **payable.type**: Identifies the type of payable. Current one defined is `digital_good`, to represent a digital content/good. Within this type, attributes `merchant` and `order` are required.<br> **payable.merchant**: provides information about a merchant/provider from external market, including `id` (unique merchant identifier), `name` (merchant name) and `fee` (fee percentage for the merchant).<br> **payable.order**: Represents an order from external market, including `id` (unique order identifier in the external market), `items` (array of purchased concepts with a `name` and an `amount` -comprised of `value`, `currency` and `tax_included` flag-) and `total_amount` (overall amount for this purchase, -comprised of `value`, `currency` and `tax_included` flag- as well)<br>
 <br>**Response**<br> **201: Purchase created**<br> **Response body**: A complete purchase representation is provided. <br> **payable**: same payable as in request.<br> **id**: unique purchase identifier.<br> **status**: purchase status. <br> **400:** **Invalid Argument.**<br> **401:** **Unauthorized.** <br> **403:** **Permission Denied.** <br> **403:** **Purchase Amount Overpassed.**<br> **500:** **Server Error.**<br> **503:** **Service unavailable.**<br> **504:** **Request timeout exceeded.** |
<br>


| **Retrieve Purchase Information** |
| --------------------------------------- |
| **HTTP Request**<br> GET \<base-url>/carrier-billing-checkout/v0/purchases/{purchase_id}<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> `purchase_id` MUST be present in the request, to identify the purchase process involved. <br>**Request Body Parameters**<br> No request body parameters are defined.<br>
 <br>**Response**<br> **200: Contains information about a given purchase**<br> **Response body**: A complete purchase representation is provided. <br> **payable**: payable information related to the purchase. Same model as per createPurchase operation.<br> **id**: unique purchase identifier. Same value as in request path parameter.<br> **status**: purchase status. <br> **401:** **Unauthorized.** <br> **403:** **Permission Denied.** <br> **404:** **Not Found.** <br> **500:** **Server Error.**<br> **503:** **Service unavailable.** <br> **504:** **Request timeout exceeded.** |
<br>


| **Create a new Payment** |
| --------------------------------------- |
| **HTTP Request**<br> POST \<base-url>/carrier-billing-checkout/v0/purchases/{purchase_id}/payment/prepare<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> `purchase_id` MUST be present in the request, to identify the purchase process involved in the payment action. <br>**Request Body Parameters**<br> No request body parameters are defined.<br>
 <br>**Response**<br> **200: Payment Triggered**<br> **Response body**: Information of triggered payment. <br> **id**: unique purchase identifier. Same value as in request path parameter.<br> **status**: purchase status.<br> **payment_otp**: provides the necessary information in order to validate an OTP, including the `validation_endpoint`. OTP code is sent offline to the user (e.g. via SMS), so end-user can input it in the endpoint provided. <br> **401:** **Unauthorized.** <br> **403:** **Permission Denied.** <br> **403:** **Accumulated Purchase Amount Overpassed.** <br> **404:** **Not Found.** <br> **409:** **Already Exists.** <br> **500:** **Server Error.**<br> **503:** **Service unavailable.** <br> **504:** **Request timeout exceeded.** |
<br>


| **Confirm a Payment** |
| --------------------------------------- |
| **HTTP Request**<br> POST \<base-url>/carrier-billing-checkout/v0/purchases/{purchase_id}/payment/confirm<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> `purchase_id` MUST be present in the request, to identify the purchase process involved in the payment action. <br>**Request Body Parameters**<br> No request body parameters are defined.<br>
 <br>**Response**<br> **202: Payment Accepted**<br> **Response body**: Empty response. Details of purchase can be obtained from getPurchaseInfo endpoint. <br> **401:** **Unauthorized.** <br> **403:** **Permission Denied.** <br> **403:** **Accumulated Purchase Amount Overpassed.** <br> **404:** **Not Found.** <br> **409:** **Already Exists.** <br> **409:** **Payment reached final status.** <br> **412:** **Precondition failed.** <br> **500:** **Server Error.**<br> **503:** **Service unavailable.** <br> **504:** **Request timeout exceeded.** |
<br>


| **Cancel a Payment** |
| --------------------------------------- |
| **HTTP Request**<br> POST \<base-url>/carrier-billing-checkout/v0/purchases/{purchase_id}/payment/cancel<br>**Query Parameters**<br> No query parameters are defined.<br>**Path Parameters**<br> `purchase_id` MUST be present in the request, to identify the purchase process involved in the payment action. <br>**Request Body Parameters**<br> No request body parameters are defined.<br>
 <br>**Response**<br> **202: Payment Cancellation Accepted**<br> **Response body**: Empty response. Details of purchase can be obtained from getPurchaseInfo endpoint. <br> **401:** **Unauthorized.** <br> **403:** **Permission Denied.** <br> **404:** **Not Found.** <br> **409:** **Already Exists.** <br> **409:** **Payment reached final status.** <br> **412:** **Precondition failed.** <br> **500:** **Server Error.**<br> **503:** **Service unavailable.** <br> **504:** **Request timeout exceeded.** |
<br>

### 4.4 Errors

Since CAMARA Carrier Billing Checkout API is based on REST design principles and blueprints, well defined HTTP status codes and families specified by community are followed [[2]](#2).

Details of HTTP based error/exception codes for the Carrier Billing Checkout API are described in Section 4.3 of each API REST based method.
Following table provides an overview of common error names, codes, and messages applicable to Carrier Billing Checkout API.

| No | Error Name | Error Code | Error Message |
| --- | ---------- | ---------- | ------------- |
|1	|400 |	INVALID_ARGUMENT | "Client specified an invalid argument, request body or query parameter." |
|2	|400 |	INVALID_ARGUMENT | "Client specified an incorrect request body" | 
|3	|400 |	INVALID_ARGUMENT | "Unsupported currency received: $currency" |
|4	|401 |	UNAUTHORIZED |	"Unauthorized" |
|5	|403 |	PERMISSION_DENIED |	"Operation not allowed" |
|6	|403 |	PERMISSION_DENIED |	"Client does not have sufficient permissions to perform this action" |
|7	|403 |	PERMISSION_DENIED |	"Server could not handle purchase" |
|8	|403 |	CARRIER_BILLING_CHECKOUT.PURCHASE_AMOUNT_OVERPASSED |	"Purchase amount overpasses applicable regulation" |
|9	|403 |	CARRIER_BILLING_CHECKOUT.ACCUMULATED_PURCHASE_AMOUNT_OVERPASSED |	"Accumulated Purchases Amount overpasses applicable regulation" |
|10	|404 |	NOT_FOUND |	"Resource not found" |
|11	|409 |	ALREADY_EXISTS | "The resource already exists" |
|12	|409 |	ALREADY_EXISTS | "Purchase is already prepared or paid" |
|13	|409 |	ALREADY_EXISTS | ""requested purchase with already existing payment" |
|14	|409 |	CARRIER_BILLING_CHECKOUT.PAYMENT_REACHED_FINAL_STATUS |	"Payment already reached a final status. No further actions can be performed." |
|15	|412 |	FAILED_PRECONDITION |	"Precondition failed" |
|16	|500 |	INTERNAL |	"Server error" |
|17	|503 |	SERVICE_UNAVAILABLE |	"Service unavailable" |
|18	|504 |	TIMEOUT |	"Request timeout exceeded" |

### 4.5 Policies

N/A

### 4.6 Code Snippets
<br>
<span class="colour" style="color:rgb(36, 41, 47)">Snippet 1, elaborates REST based API call with "*curl"* to create a Purchase over a digital content -skin- in an online game</span>

Please note, the credentials for API authentication purposes need to be adjusted based on target security system configuration.

| Snippet 1. Create Purchase resource  |
| ----------------------------------------------- |
| curl -X 'POST' `https://sample-base-url/carrier-billing-checkout/v0/purchases/` <br> -H 'accept: application/json' <br> -H 'Content-Type: application/json'<br> -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbG...." <br> -d '{<br> "payable": { <br> "type": "digital_good", <br> "merchant": { "id": "1234", "name": "niantic", "fee": 8 }, <br> "order": { "id": "123456789", "items": [ {"name": "dark_skin", "amount": { "value": 9.99, "currency": "EUR", "tax_included": true } } ], "total_amount": { "value": 9.99, "currency": "EUR", "tax_included": true } } <br>} <br>}' |
| response will be: <br> 201 <br> -d '{<br> "payable": { <br> "type": "digital_good", <br> "merchant": { "id": "1234", "name": "niantic", "fee": 8 }, <br> "order": { "id": "123456789", "items": [ {"name": "dark_skin", "amount": { "value": 9.99, "currency": "EUR", "tax_included": true } } ], "total_amount": { "value": 9.99, "currency": "EUR", "tax_included": true } } <br>}, <br> "id": "ae123poj29", <br> "status": "initialising" <br>}'|

<br>
<span class="colour" style="color:rgb(36, 41, 47)">Snippet 2, elaborates REST based API call with "*curl"* to create a Payment (preparation) over a given purchase</span>

Please note, the credentials for API authentication purposes need to be adjusted based on target security system configuration.

| Snippet 2. Prepare Payment  |
| ----------------------------------------------- |
| curl -X 'POST' `https://sample-base-url/carrier-billing-checkout/v0/purchases/ae123poj29/payment/prepare` <br> -H 'accept: application/json' <br> -H 'Content-Type: application/json'<br> -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbG...." <br> |
| response will be: <br> 200 <br> -d '{<br> "id": "ae123poj29", <br> "status": "ready_to_confirm" <br>}'|

<br>
<span class="colour" style="color:rgb(36, 41, 47)">Snippet 3, elaborates REST based API call with "*curl"* to confirm a Payment over a given purchase</span>

Please note, the credentials for API authentication purposes need to be adjusted based on target security system configuration.

| Snippet 3. Confirm Payment  |
| ----------------------------------------------- |
| curl -X 'POST' `https://sample-base-url/carrier-billing-checkout/v0/purchases/ae123poj29/payment/confirm` <br> -H 'accept: application/json' <br> -H 'Content-Type: application/json'<br> -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbG...." <br> |
| response will be: <br> 202 <br> |

<br>
<span class="colour" style="color:rgb(36, 41, 47)">Snippet 4, elaborates REST based API call with "*curl"* to retrieve information about a given purchase</span>

Please note, the credentials for API authentication purposes need to be adjusted based on target security system configuration.

| Snippet 4. Retrieve Purchase info |
| ----------------------------------------------- |
| curl -X 'POST' `https://sample-base-url/carrier-billing-checkout/v0/purchases/ae123poj29` <br> -H 'accept: application/json' <br> -H 'Content-Type: application/json'<br> -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbG...." <br> |
| response will be: <br> 200 <br> -d '{<br> "payable": { <br> "type": "digital_good", <br> "merchant": { "id": "1234", "name": "niantic", "fee": 8 }, <br> "order": { "id": "123456789", "items": [ {"name": "dark_skin", "amount": { "value": 9.99, "currency": "EUR", "tax_included": true } } ], "total_amount": { "value": 9.99, "currency": "EUR", "tax_included": true } } <br>}, <br> "id": "ae123poj29", <br> "status": "succeeded" <br>}'|

### 4.7 FAQ's

(FAQs will be added in a later version of the documentation)

### 4.8 Terms

N/A

### 4.9 Release Notes

N/A

## References

<a name="1">[1] [CAMARA Commonalities : Authentication and Authorization Concept for Service APIs](https://github.com/camaraproject/WorkingGroups/blob/main/Commonalities/documentation/CAMARA-AuthN-AuthZ-Concept.md) <br>
<a name="2">[2] [HTTP Status codes spec](https://restfulapi.net/http-status-codes/) <br>
