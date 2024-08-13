# Changelog CarrierBillingCheckOut API Family

## Table of Contents

- [r1.1 - rc](#r11---rc)
- [v0.2.1](#v021)
- [v0.2.0](#v020)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for each first alpha or release-candidate API version, all changes since the release of the previous public API version
* for subsequent alpha or release-candidate API versions, the delta with respect to the previous pre-release
* for a public API version, the consolidated changes since the release of the previous public API version

## r1.1 - rc

## Release Notes

This release contains the definition and documentation of
* Carrier Billing v0.3.0-rc.1
* Carrier Billing Refund v0.1.0-rc.1

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## Carrier Billing v0.3.0-rc.1

**Carrier Billing v0.3.0-rc.1 is the first release-candidate version for v0.3.0 of the Carrier Billing (Payment) API.**
- **This version contains significant changes compared to v0.2.1, and it is not backward compatible:**
  - Within notifications, callback concept named as `webhook` has been replaced by the terms `sink` and `sinkCredential` in accordance with the updated CAMARA Design Guidelines (Adoption of CloudEvent Subscription Model within MetaRelease Fall24 (v0.4.0))
  - Exceptions has also been aligned with Commonalities MetaRelease-Fall24 (v0.4.0), so as some excepctions has changed their `HTTP` and/or `status` values.
  - Version designed to work jointly with Carrier Billing Refund API

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.1/code/API_definitions/carrier_billing.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.1/code/API_definitions/carrier_billing.yaml)
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
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/r1.1/code/API_definitions/carrier_billing_refund.yaml)
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
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/CarrierBillingCheckOut/release-v0.2.1/code/API_definitions/carrier_billing.yaml)
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
