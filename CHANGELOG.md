# Changelog CarrierBillingCheckOut

## Table of Contents

- [v0.2.1](#v0.2.1)
- [v0.2.0](#v0.2.0)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

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
