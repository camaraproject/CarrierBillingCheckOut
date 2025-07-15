# Changelog CarrierBillingCheckOut API Family

## Table of Contents

- [r3.1 - rc](#r31---rc)
- [r2.2](#r22)
- [r2.1 - rc](#r21---rc)
- [r1.3](#r13)
- [r1.2](#r12)
- [r1.1 - rc](#r11---rc)
- [v0.2.1](#v021)
- [v0.2.0](#v020)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

## r3.1 - rc

## Release Notes

This release contains the definition and documentation of
* Carrier Billing v0.5.0-rc.1
* Carrier Billing Refund v0.3.0-rc.1

The API definition(s) are based on
* Commonalities v0.6.0-rc.1
* Identity and Consent Management v0.4.0-rc.1

## Carrier Billing v0.5.0-rc.1

**Carrier Billing v0.5.0-rc.1 is the first release-candidate version for v0.5.0 of the Carrier Billing API.**
- **This version contains significant changes compared to v0.4.0:**
  - Removal of `401 - AUTHENTICATION_REQUIRED`
  - New pattern for `x-correlator`
  - Addition of a new section `# Additional CAMARA error responses` in `info.description` field
  - Addition of `404 - INVALID_SINK` in `createPayment` and `preparePayment` endpoints
  - Addition of `404 - IDENTIFIER_NOT_FOUND` in `createPayment`, `preparePayment`, `confirmPayment` and `cancelPayment` endpoints
  - Addition of `404 - NOT_FOUND` in `validatePayment` endpoint
  - Removal of `403 - CARRIER_BILLING.INVALID_PAYMENT_CONTEXT` in `retrievePayment` and `retrievePayments` endpoints 

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r3.1/code/API_definitions/carrier-billing.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r3.1/code/API_definitions/carrier-billing.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r3.1/code/API_definitions/carrier-billing.yaml)

### Added
* New section `# Additional CAMARA error responses` in `info.description` field in https://github.com/camaraproject/CarrierBillingCheckOut/pull/229.
* `404 - INVALID_SINK` error in `createPayment` and `preparePayment` endpoints in https://github.com/camaraproject/CarrierBillingCheckOut/pull/229.
* `404 - IDENTIFIER_NOT_FOUND` error in `createPayment`, `preparePayment`, `confirmPayment` and `cancelPayment` endpoints in https://github.com/camaraproject/CarrierBillingCheckOut/pull/217.
* `404 - NOT_FOUND` error in `validatePayment` endpoint in https://github.com/camaraproject/CarrierBillingCheckOut/pull/217.
* New test for invalid `x-correlator` in Gherkin `.feature` files in https://github.com/camaraproject/CarrierBillingCheckOut/pull/230.
* Error 404 testing scenarios in Gherkin `.feature` files for `createPayment`, `preparePayment`, `confirmPayment`, `cancelPayment` and `validatePayment` in https://github.com/camaraproject/CarrierBillingCheckOut/pull/230.

### Changed
* New pattern for `x-correlator` and model aligment with Commonalities in https://github.com/camaraproject/CarrierBillingCheckOut/pull/229.
* Update Gherkin `.feature` files with Commonalities testing guidelines in https://github.com/camaraproject/CarrierBillingCheckOut/pull/230.
* Update test for invalid sink in Gherkin `.feature` files for `createPayment` and `preparePayment` endpoints in https://github.com/camaraproject/CarrierBillingCheckOut/pull/230.

### Fixed
* N/A

### Removed
* `401 - AUTHENTICATION_REQUIRED` error in https://github.com/camaraproject/CarrierBillingCheckOut/pull/229.
* `403 - CARRIER_BILLING.INVALID_PAYMENT_CONTEXT` error in `retrievePayment` and `retrievePayments` endpoints in https://github.com/camaraproject/CarrierBillingCheckOut/pull/226.
* Test `@*_403.02_phoneNumber_token_mismatch` in Gherkin `.feature` files for `retrievePayment` and `retrievePayments` in https://github.com/camaraproject/CarrierBillingCheckOut/pull/230.

## Carrier Billing Refund v0.3.0-rc.1

**Carrier Billing Refund v0.3.0-rc.1 is the first release-candidate version for v0.3.0 of the Carrier Billing Refund API.**
- **This version contains significant changes compared to v0.2.0:**
  - Removal of `401 - AUTHENTICATION_REQUIRED`
  - New pattern for `x-correlator`
  - Addition of a new section `# Additional CAMARA error responses` in `info.description` field
  - Addition of `404 - INVALID_SINK` in `createRefund` endpoint
  - Removal of `403 - CARRIER_BILLING.INVALID_REFUND_CONTEXT`

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r3.1/code/API_definitions/carrier-billing-refund.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r3.1/code/API_definitions/carrier-billing-refund.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r3.1/code/API_definitions/carrier-billing-refund.yaml)

### Added
* * New section `# Additional CAMARA error responses` in `info.description` field in https://github.com/camaraproject/CarrierBillingCheckOut/pull/229.
* `404 - INVALID_SINK` error in `createRefund` endpoint in https://github.com/camaraproject/CarrierBillingCheckOut/pull/229.
* New test for invalid `x-correlator` in Gherkin `.feature` files in https://github.com/camaraproject/CarrierBillingCheckOut/pull/230.

### Changed
* New pattern for `x-correlator` and model aligment with Commonalities in https://github.com/camaraproject/CarrierBillingCheckOut/pull/229.
* Update Gherkin `.feature` files with Commonalities testing guidelines in https://github.com/camaraproject/CarrierBillingCheckOut/pull/230.
* Update test for invalid sink in Gherkin `.feature` file for `createRefund` endpoint in https://github.com/camaraproject/CarrierBillingCheckOut/pull/230.

### Fixed
* N/A

### Removed
* `401 - AUTHENTICATION_REQUIRED` error in https://github.com/camaraproject/CarrierBillingCheckOut/pull/229.
* `403 - CARRIER_BILLING.INVALID_REFUND_CONTEXT` error in https://github.com/camaraproject/CarrierBillingCheckOut/pull/226.
* Test `@*_403.02_phoneNumber_token_mismatch` in Gherkin `.feature` files in https://github.com/camaraproject/CarrierBillingCheckOut/pull/230.

## New Contributors
* N/A


**Full Changelog**: https://github.com/camaraproject/CarrierBillingCheckOut/compare/r2.2...r3.1

## r2.2

## Release Notes

This release contains the definition and documentation of
* Carrier Billing v0.4.0
* Carrier Billing Refund v0.2.0

The API definition(s) are based on
* Commonalities v0.5.0
* Identity and Consent Management v0.3.0

## Carrier Billing v0.4.0

**Carrier Billing v0.4.0 is the first public release version for v0.4.0 of the Carrier Billing API.**
- **This version contains significant changes compared to v0.3.1, and it is not backward compatible:**
  - Error model aligment with commonalities, which implies use of normalization values (i.e. enums) for `status` and `code`
  - Removal of `403 - INVALID_TOKEN_CONTEXT`
  - Removal of `5XX` errors
  - Addition of `403 - CARRIER_BILLING.INVALID_PAYMENT_CONTEXT` for GET endpoints
  - Addition of applicable `422` traversal exceptions  
  - Addition of `429 - TOO_MANY_REQUESTS`


- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r2.2/code/API_definitions/carrier-billing.yaml)

### Added
* Added `# Identifying the phone number from the access token` section within `info.description` from Commonalities guideline in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added `403 - CARRIER_BILLING.INVALID_PAYMENT_CONTEXT` for GET endpoints, to deal with the case where 3-legged Access Token is not valid for payment context, that is paymentId is not related to the phone number associated to the token in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added applicable `422` traversal exceptions in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added `429 - TOO_MANY_REQUESTS` to API endpoints in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added Gherkin Testing Linter in https://github.com/camaraproject/CarrierBillingCheckOut/pull/191.
* Generate Tests for 429 Error in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.

### Changed
* Updated `# Authorization and authentication` section from ICM guideline in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Error model aligment with commonalities. Normalization values (i.e. enums) for `status` and `code`. In https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Updated testing plan in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Update API specification version and servers.url in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.
* Update Test Definitions API version in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.
* Update `sink` format to `uri` in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.

### Fixed
* Updated `accessTokenExpiresUtc` description in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Some clarifications on descriptions in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Update `@{operationId}_403.01_invalid_token_permissions` test wording to be more generic in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.
* Fix `CARRIER_BILLING.INVALID_DATE_RANGE` description in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.

### Removed
* Removed `403 - INVALID_TOKEN_CONTEXT` in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Removed `5XX` errors in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Removed `sinkCredential` from API responses in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.

## Carrier Billing Refund v0.2.0

**Carrier Billing Refund v0.2.0 is the first public release version for v0.2.0 of the Carrier Billing Refund API.**
- **This version contains significant changes compared to v0.1.1, and it is not backward compatible:**
  - Error model aligment with commonalities, which implies use of normalization values (i.e. enums) for `status` and `code`
  - Removal of `403 - INVALID_TOKEN_CONTEXT`
  - Removal of `5XX` errors
  - Addition of `403 - CARRIER_BILLING_REFUND.INVALID_REFUND_CONTEXT` for GET endpoints
  - Addition of applicable `422` traversal exceptions  
  - Addition of `429 - TOO_MANY_REQUESTS`

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing-refund.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.2/code/API_definitions/carrier-billing-refund.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r2.2/code/API_definitions/carrier-billing-refund.yaml)

### Added
* Added `403 - CARRIER_BILLING_REFUND.INVALID_REFUND_CONTEXT` for GET endpoints, to deal with the case where 3-legged Access Token is not valid for refund context, that is refundId is not related to the phone number associated to the token in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added applicable `422` traversal exceptions in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added `429 - TOO_MANY_REQUESTS` to API endpoints in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added Gherkin Testing Linter in https://github.com/camaraproject/CarrierBillingCheckOut/pull/191.
* Generate Tests for 429 Error in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.

### Changed
* Updated `# Authorization and authentication` section from ICM guideline in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Error model aligment with commonalities. Normalization values (i.e. enums) for `status` and `code`. In https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Updated testing plan in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Update API specification version and servers.url in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.
* Update Test Definitions API version in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.
* Update `sink` format to `uri` in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.

### Fixed
* Updated `accessTokenExpiresUtc` description in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Some clarifications on descriptions in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Update `@{operationId}_403.01_invalid_token_permissions` test wording to be more generic in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.
* Fix `CARRIER_BILLING_REFUND.INVALID_DATE_RANGE` description in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.
* Fix some Error exceptions `CARRIER_BILLING...` to `CARRIER_BILLING_REFUND...` in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.

### Removed
* Removed `403 - INVALID_TOKEN_CONTEXT` in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Removed `5XX` errors in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Removed `sinkCredential` from API responses in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.
* Remove `Content-Last-Key` and `X-Total-Count` from `retrieveRefund` and `retrievePaymentRemainingAmount` operations as they are not applicable in https://github.com/camaraproject/CarrierBillingCheckOut/pull/206.

## New Contributors
* N/A


**Full Changelog**: https://github.com/camaraproject/CarrierBillingCheckOut/compare/r1.3...r2.2

## r2.1 - rc

## Release Notes

This release contains the definition and documentation of
* Carrier Billing v0.4.0-rc.1
* Carrier Billing Refund v0.2.0-rc.1

The API definition(s) are based on
* Commonalities v0.5.0-rc.1
* Identity and Consent Management v0.3.0-alpha.1

## Carrier Billing v0.4.0-rc.1

**Carrier Billing v0.4.0-rc.1 is the first release-candidate version for v0.4.0 of the Carrier Billing API.**
- **This version contains significant changes compared to v0.3.1, and it is not backward compatible:**
  - Error model aligment with commonalities, which implies use of normalization values (i.e. enums) for `status` and `code`
  - Removal of `403 - INVALID_TOKEN_CONTEXT`
  - Removal of `5XX` errors
  - Addition of `403 - CARRIER_BILLING.INVALID_PAYMENT_CONTEXT` for GET endpoints
  - Addition of applicable `422` traversal exceptions  
  - Addition of `429 - TOO_MANY_REQUESTS`


- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.1/code/API_definitions/carrier-billing.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.1/code/API_definitions/carrier-billing.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r2.1/code/API_definitions/carrier-billing.yaml)

### Added
* Added `# Identifying the phone number from the access token` section within `info.description` from Commonalities guideline in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added `403 - CARRIER_BILLING.INVALID_PAYMENT_CONTEXT` for GET endpoints, to deal with the case where 3-legged Access Token is not valid for payment context, that is paymentId is not related to the phone number associated to the token in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added applicable `422` traversal exceptions in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added `429 - TOO_MANY_REQUESTS` to API endpoints in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added Gherkin Testing Linter in https://github.com/camaraproject/CarrierBillingCheckOut/pull/191.

### Changed
* Updated `# Authorization and authentication` section from ICM guideline in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Error model aligment with commonalities. Normalization values (i.e. enums) for `status` and `code`. In https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Updated testing plan in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.

### Fixed
* Updated `accessTokenExpiresUtc` description in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Some clarifications on descriptions in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.

### Removed
* Removed `403 - INVALID_TOKEN_CONTEXT` in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Removed `5XX` errors in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.

## Carrier Billing Refund v0.2.0-rc.1

**Carrier Billing Refund v0.2.0-rc.1 is the first release-candidate version for v0.2.0 of the Carrier Billing Refund API.**
- **This version contains significant changes compared to v0.1.1, and it is not backward compatible:**
  - Error model aligment with commonalities, which implies use of normalization values (i.e. enums) for `status` and `code`
  - Removal of `403 - INVALID_TOKEN_CONTEXT`
  - Removal of `5XX` errors
  - Addition of `403 - CARRIER_BILLING_REFUND.INVALID_REFUND_CONTEXT` for GET endpoints
  - Addition of applicable `422` traversal exceptions  
  - Addition of `429 - TOO_MANY_REQUESTS`

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.1/code/API_definitions/carrier-billing-refund.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r2.1/code/API_definitions/carrier-billing-refund.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r2.1/code/API_definitions/carrier-billing-refund.yaml)

### Added
* Added `403 - CARRIER_BILLING_REFUND.INVALID_REFUND_CONTEXT` for GET endpoints, to deal with the case where 3-legged Access Token is not valid for refund context, that is refundId is not related to the phone number associated to the token in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added applicable `422` traversal exceptions in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added `429 - TOO_MANY_REQUESTS` to API endpoints in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Added Gherkin Testing Linter in https://github.com/camaraproject/CarrierBillingCheckOut/pull/191.

### Changed
* Updated `# Authorization and authentication` section from ICM guideline in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Error model aligment with commonalities. Normalization values (i.e. enums) for `status` and `code`. In https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Updated testing plan in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.

### Fixed
* Updated `accessTokenExpiresUtc` description in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Some clarifications on descriptions in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.

### Removed
* Removed `403 - INVALID_TOKEN_CONTEXT` in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.
* Removed `5XX` errors in https://github.com/camaraproject/CarrierBillingCheckOut/pull/202.

## New Contributors
* N/A


**Full Changelog**: https://github.com/camaraproject/CarrierBillingCheckOut/compare/r2.1...r1.3

## r1.3

## Release Notes

This release contains the definition and documentation of
* Carrier Billing v0.3.1
* Carrier Billing Refund v0.1.1

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## Carrier Billing v0.3.1

**Carrier Billing v0.3.1 is a public release (patch release for v0.3.0) of the Carrier Billing API.**
- **This version contains documentational updates compared to v0.3.0, being backwards compatible:**
  - Added a section `# Generic Clarification about optional parameters` within API Spec `info.description` field

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.3/code/API_definitions/carrier-billing.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.3/code/API_definitions/carrier-billing.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r1.3/code/API_definitions/carrier-billing.yaml)

**Main changes since [r1.2](#r12)**

### Added
* New section `# Generic Clarification about optional parameters` within API Spec `info.description` field in https://github.com/camaraproject/CarrierBillingCheckOut/pull/183

### Changed
* Update `README.md` with new wiki domain for the Sub-project in https://github.com/camaraproject/CarrierBillingCheckOut/pull/182

### Fixed
* N/A

### Removed
* N/A

## Carrier Billing Refund v0.1.1

**Carrier Billing Refund v0.1.1 is a public release (patch release for v0.1.0) of the Carrier Billing Refund API.**
- **This version contains documentational updates compared to v0.1.0, being backwards compatible:**
  - Added a section `# Generic Clarification about optional parameters` within API Spec `info.description` field

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.3/code/API_definitions/carrier-billing-refund.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.3/code/API_definitions/carrier-billing-refund.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r1.3/code/API_definitions/carrier-billing-refund.yaml)

**Main changes since [r1.2](#r12)**

### Added
* New section `# Generic Clarification about optional parameters` within API Spec `info.description` field in https://github.com/camaraproject/CarrierBillingCheckOut/pull/183

### Changed
* Update `README.md` with new wiki domain for the Sub-project in https://github.com/camaraproject/CarrierBillingCheckOut/pull/182

### Fixed
* N/A

### Removed
* N/A

## New Contributors
* N/A


**Full Changelog**: https://github.com/camaraproject/CarrierBillingCheckOut/compare/r1.2...r1.3

## r1.2

## Release Notes

This release contains the definition and documentation of
* Carrier Billing v0.3.0
* Carrier Billing Refund v0.1.0

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## Carrier Billing v0.3.0

**Carrier Billing v0.3.0 is the first public release for v0.3.0 of the Carrier Billing API.**
- **This version contains significant changes compared to v0.2.1, and it is not backward compatible:**
  - Within notifications, callback concept named as `webhook` has been replaced by the terms `sink` and `sinkCredential` in accordance with the updated CAMARA Design Guidelines (Adoption of CloudEvent Subscription Model within MetaRelease Fall24 (v0.4.0))
  - Exceptions has also been aligned with Commonalities MetaRelease-Fall24 (v0.4.0), so as some excepctions has changed their `HTTP` and/or `status` values.
  - Version designed to work jointly with Carrier Billing Refund API

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.2/code/API_definitions/carrier-billing.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.2/code/API_definitions/carrier-billing.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r1.2/code/API_definitions/carrier-billing.yaml)

**Main changes since [r1.1 - rc](#r11---rc)**

### Added
* Basic Test cases definition in https://github.com/camaraproject/CarrierBillingCheckOut/pull/174

### Changed
* Update User Stories in https://github.com/camaraproject/CarrierBillingCheckOut/pull/172
* Update `README.md` with meeting info and template alignment in https://github.com/camaraproject/CarrierBillingCheckOut/pull/177
* Update filename to kebab-case format in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178

### Fixed
* Align 401 Exception Codes with CAMARA Commonalities in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178
* Align Exceptions naming model with CAMARA Commonalities in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178
* Fix `sink` property description in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178
* Adjust `version` and `servers.url` values aligned with Release Mabagement Commonalities in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178
* Fix `externalDocs.url` value in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178
* Fix missing required Request Body for `confirmPayment` operation in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178

### Removed
* N/A

## Carrier Billing Refund v0.1.0

**Carrier Billing Refund v0.1.0 is the first public release for v0.1.0 of the Carrier Billing Refund API.**
- **This version defines a new API:**
  - Initial version covering the following functionality and related endpoints:
    - New endpoint `createRefund`, both total and partial refunds
    - New endpoint `retrieveRefunds`
    - New endpoint `retrieveRefund`
    - New endpoint `retrievePaymentRemainingAmount`
    - Support for `Instance-based (implicit) subscription` notification mode

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.2/code/API_definitions/carrier-billing-refund.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.2/code/API_definitions/carrier-billing-refund.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r1.2/code/API_definitions/carrier-billing-refund.yaml)

**Main changes since [r1.1 - rc](#r11---rc)**

### Added
* Generate User Stories in https://github.com/camaraproject/CarrierBillingCheckOut/pull/172
* Basic Test cases definition in https://github.com/camaraproject/CarrierBillingCheckOut/pull/176

### Changed
* Update `README.md` with meeting info and template alignment in https://github.com/camaraproject/CarrierBillingCheckOut/pull/177
* Update filename to kebab-case format in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178

### Fixed
* Align 401 Exception Codes with CAMARA Commonalities in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178
* Align Exceptions naming model with CAMARA Commonalities in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178
* Fix `sink` property description in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178
* Adjust `version` and `servers.url` values aligned with Release Mabagement Commonalities in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178
* Fix `externalDocs.url` value in https://github.com/camaraproject/CarrierBillingCheckOut/pull/178

### Removed
* N/A

## New Contributors
* N/A


**Full Changelog**: https://github.com/camaraproject/CarrierBillingCheckOut/compare/v0.2.1...r1.2

## r1.1 - rc

## Release Notes

This release contains the definition and documentation of
* Carrier Billing v0.3.0-rc.1
* Carrier Billing Refund v0.1.0-rc.1

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## Carrier Billing v0.3.0-rc.1

**Carrier Billing v0.3.0-rc.1 is the first release-candidate version for v0.3.0 of the Carrier Billing API.**
- **This version contains significant changes compared to v0.2.1, and it is not backward compatible:**
  - Within notifications, callback concept named as `webhook` has been replaced by the terms `sink` and `sinkCredential` in accordance with the updated CAMARA Design Guidelines (Adoption of CloudEvent Subscription Model within MetaRelease Fall24 (v0.4.0))
  - Exceptions has also been aligned with Commonalities MetaRelease-Fall24 (v0.4.0), so as some excepctions has changed their `HTTP` and/or `status` values.
  - Version designed to work jointly with Carrier Billing Refund API

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.1/code/API_definitions/carrier_billing.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.1/code/API_definitions/carrier_billing.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r1.1/code/API_definitions/carrier_billing.yaml)

### Added
* N/A

### Changed
* Support for non-negative `amount` and `taxAmount` values in https://github.com/camaraproject/CarrierBillingCheckOut/pull/152
* Adoption of CloudEvents Subscription Model replacing `webhook` by `sink` and `sinkCredential` concepts as well as aligning callback endpoint for notifications in https://github.com/camaraproject/CarrierBillingCheckOut/pull/152
* Aligment of Exceptions with Commonalities MetaRelease Fall24 in https://github.com/camaraproject/CarrierBillingCheckOut/pull/152
* Alignment of Authorization and authentication section with I&CM MetaRelease Fall24 in https://github.com/camaraproject/CarrierBillingCheckOut/pull/152

### Fixed
* Clarifications on descriptions and editorial enhancements in https://github.com/camaraproject/CarrierBillingCheckOut/pull/152

### Removed
* N/A

## Carrier Billing Refund v0.1.0-rc.1

**Carrier Billing Refund v0.1.0-rc.1 is the first release-candidate version for v0.1.0 of the Carrier Billing Refund API.**
- **This version defines a new API:**
  - Initial version covering the following functionality and related endpoints:
    - New endpoint `createRefund`, both total and partial refunds
    - New endpoint `retrieveRefunds`
    - New endpoint `retrieveRefund`
    - New endpoint `retrievePaymentRemainingAmount`
    - Support for `Instance-based (implicit) subscription` notification mode

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.1/code/API_definitions/carrier_billing_refund.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.1/code/API_definitions/carrier_billing_refund.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/CarrierBillingCheckOut/blob/r1.1/code/API_definitions/carrier_billing_refund.yaml)

### Added
* Added new Carrier Billing Refund API with the functionality aforementioned indicated (create a refund, query details of a given refund or a list of refunds, retrieve the amount not yet refunded of a given payment, support for implicit-based subscription) in https://github.com/camaraproject/CarrierBillingCheckOut/pull/152
* Aligned with Commonalities and I&CM MetaRelease Fall24 in https://github.com/camaraproject/CarrierBillingCheckOut/pull/152

### Changed
* N/A

### Fixed
* N/A

### Removed
* N/A

## New Contributors
* N/A


**Full Changelog**: https://github.com/camaraproject/CarrierBillingCheckOut/compare/v0.2.1...r1.1

## v0.2.1

**Fix over the first release**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/release-v0.2.1/code/API_definitions/carrier_billing.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/release-v0.2.1/code/API_definitions/carrier_billing.yaml)
  - OpenAPI [YAML spec file](https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/release-v0.2.1/code/API_definitions/carrier_billing.yaml)

### Added

* N/A

### Changed

* N/A

### Fixed

* Fix `operationId` name of callbacks to be unique.

### Removed

* N/A

## New Contributors
* N/A


**Full Changelog**: https://github.com/camaraproject/CarrierBillingCheckOut/commits/v0.2.1

## v0.2.0

**Initial baseline contribution**
- API [definition](https://github.com/camaraproject/CarrierBillingCheckOut/tree/release-v0.2.0/code/API_definitions)


## Please note 
- this "release" is tagged to be the first release of this API.
- there are ongoing discussions about new features/enhancements so API evolution is expected.

### Added

* Initial version covering the following functionality and related endpoints:
  * One-Step Payment:
    * New endpoint `createPayment`
  * Two-Step Payment:
    * New endpoint `preparePayment`
    * New endpoint `confirmPayment`
    * New endpoint `cancelPayment`
    * New endpoint (optional, depending on business case need): `validatePayment`
  * Obtain Payment(s) information:
    * New endpoint `retrievePayments`
    * New endpoint `retrievePayment`
  * Support for `Instance-based (implicit) subscription` notification mode both in One-Step and Two-Step Payment procedures

### Changed

* N/A

### Fixed

* N/A

### Removed

* N/A

## New Contributors
* N/A


**Full Changelog**: https://github.com/camaraproject/CarrierBillingCheckOut/commits/v0.2.0
