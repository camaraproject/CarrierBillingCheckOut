Feature: CAMARA Carrier Billing API, v0.5.0-rc.1 - Operation retrievePayments
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  #
  #
  # Testing assets:
  # * A phone number eligible for payment (no restrictions for it to be used to perform a payment)
  # * Several payments performed in different status in the environment (at least 10)
  #
  # References to OAS spec schemas refer to schemas specifies in carrier-billing.yaml, version 0.5.0-rc.1

  Background: Common retrievePayments setup
    Given the resource "/carrier-billing/v0.5rc1/payments"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"

  ##############################
  # Happy path scenarios
  ##############################

  @retrieve_payments_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    Given at least an existing payment created by operation createPayment OR preparePayment
    When the request "retrievePayments" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentArray"

  @retrieve_payments_02_no_payments
  Scenario: No existing payments
    Given no payments have been created by operation createPayment OR preparePayment
    When the request "retrievePayments" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an empty array "[]"

  @retrieve_payments_03_for_phoneNumber
  Scenario: List of payments for a given phone number
    Given at least an existing payment created by operation createPayment OR preparePayment
    And the header "Authorization" is set to a valid access token associated for a phone number with payments requested
    When the request "retrievePayments" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentArray"
    And only the payments associated to that phone number are returned

  @retrieve_payments_04_for_application
  Scenario: List of payments for a given application (API client)
  #To test this scenario, a 2-legged token is needed
    Given at least an existing payment created by operation createPayment OR preparePayment
    And the header "Authorization" is set to a valid access token not emitted for a specific phone number
    When the request "retrievePayments" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentArray"
    And only the payments associated to that application are returned

  # Query Parameter scenarios

  @retrieve_payments_05_start_creationDate
  Scenario Outline: List of payments since a given creationDate
    Given several existing payments created by operation createPayment OR preparePayment
    And the header "Authorization" is set to a valid access token
    And the query parameter "paymentCreationDate.gte" is set to "<creation_date>"
    When the request "retrievePayments" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentArray"
    And all the payments returned have their property "$.paymentCreationDate" greater or equal than "<creation_date>"
    And only the payments with their property "$.paymentCreationDate" greater or equal than "<creation_date>" are returned

    Examples:
      | creation_date |
      | NOW - 1 day   |
      | NOW - 7 days  |
      | NOW - 30 days |

  @retrieve_payments_06_end_creationDate
  Scenario Outline: List of payments up to a given creationDate
    Given several existing payments created by operation createPayment OR preparePayment
    And the header "Authorization" is set to a valid access token
    And the query parameter "paymentCreationDate.lte" is set to "<creation_date>"
    When the request "retrievePayments" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentArray"
    And all the payments returned have their property "$.paymentCreationDate" lower or equal than "<creation_date>"
    And only the payments with their property "$.paymentCreationDate" lower or equal than "<creation_date>" are returned

    Examples:
      | creation_date |
      | NOW - 1 day   |
      | NOW - 3 days  |
      | NOW - 7 days  |

  @retrieve_payments_07_date_range
  Scenario Outline: List of payments within a creationDate range
    Given several existing payments created by operation createPayment OR preparePayment
    And the header "Authorization" is set to a valid access token
    And the query parameter "paymentCreationDate.gte" is set to "<start_creation_date>"
    And the query parameter "paymentCreationDate.lte" is set to "<end_creation_date>"
    When the request "retrievePayments" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentArray"
    And all the payments returned have their property "$.paymentCreationDate" between "<start_creation_date>" and "<end_creation_date>"
    And only the payments with their property "$.paymentCreationDate" between "<start_creation_date>" and "<end_creation_date>"

    Examples:
      | start_creation_date | end_creation_date |
      | NOW - 7 days        | NOW               |
      | NOW - 30 days       | NOW               |
      | NOW - 30 days       | NOW - 7 days      |

  @retrieve_payments_08_ordering
  Scenario Outline: List of payments ordered by creationPaymentDate
    Given several existing payments created by operation createPayment OR preparePayment
    And the header "Authorization" is set to a valid access token
    And the query parameter "order" is set to "<order>"
    When the request "retrievePayments" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentArray"
    And all the payments returned are ordered by "<order>" property "$.paymentCreationDate"

    Examples:
      | order |
      | desc  |
      | asc   |

  @retrieve_payments_09_payment_status
  Scenario Outline: List of payments in a given status
    Given several existing payments created by operation createPayment OR preparePayment in different payment status
    And the header "Authorization" is set to a valid access token
    And the query parameter "paymentStatus" is set to "<payment_status>"
    When the request "retrievePayments" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentArray"
    And all the payments returned have their property "$.paymentStatus" == "<payment_status>"
    And only the payments with their property "$.paymentStatus" == "<payment_status>" are returned

    Examples:
      | payment_status     |
      | processing         |
      | pending_validation |
      | denied             |
      | reserved           |
      | succeeded          |
      | cancelled          |

  @retrieve_payments_10_merchantIdentifier
  Scenario: List of payments for a given merchantIdentifier
    Given several existing payments created by operation createPayment OR preparePayment for a given merchant
    And the header "Authorization" is set to a valid access token
    And the query parameter "merchantIdentifier" is set to the value representing such a merchant
    When the request "retrievePayments" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentArray"
    And all the payments returned have their property "$.amountTransaction.paymentAmount.chargingMetadata.merchantIdentifier" set to the same value as the query parameter "merchantIdentifier"
    And only the payments with their property "$.amountTransaction.paymentAmount.chargingMetadata.merchantIdentifier" set to the same value as the query parameter "merchantIdentifier" are returned

  @retrieve_payments_11_pagination
  Scenario: Pagination in List of payments
    Given several existing payments created by operation createPayment OR preparePayment, at least more than five
    And the header "Authorization" is set to a valid access token
    And the query parameter "page" is set to "1"
    And the query parameter "perPage" is set to "5"
    When the request "retrievePayments" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentArray"
    And only five payments returned

  ##############################
  # Error scenarios
  ##############################

  # Error 400 scenarios

  @retrieve_payments_400.01_invalid_date_range
  Scenario Outline: List of payments with an invalid date range
    Given several existing payments created by operation createPayment OR preparePayment
    And the header "Authorization" is set to a valid access token
    And the query parameter "paymentCreationDate.gte" is set to "<start_creation_date>"
    And the query parameter "paymentCreationDate.lte" is set to "<end_creation_date>"
    When the request "retrievePayments" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "CARRIER_BILLING.INVALID_DATE_RANGE"
    And the response property "$.message" contains a user friendly text

    Examples:
      | start_creation_date | end_creation_date |
      | NOW                 | NOW - 7 days      |
      | NOW - 7 days        | NOW - 30 days     |

  @retrieve_payments_400.02_out_of_range
  Scenario: List of payments out of range
    Given several existing payments created by operation createPayment OR preparePayment
    And the header "Authorization" is set to a valid access token
    And the query parameter "page" is set to "1000"
    And the query parameter "perPage" is set to "1000"
    When the request "retrievePayments" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "CARRIER_BILLING.OUT_OF_RANGE"
    And the response property "$.message" contains a user friendly text

  @retrieve_payments_400.03_too_many_matching_records
  Scenario: List of payments too many matching records
  #Optional test to be performed. To test this scenario there would be needed many payments in the environment.
    Given several existing payments created by operation createPayment OR preparePayment
    And the header "Authorization" is set to a valid access token
    And the query parameter "page" is set to "1"
    And the query parameter "perPage" is set to "1000"
    When the request "retrievePayments" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "CARRIER_BILLING.TOO_MANY_MATCHING_RECORDS"
    And the response property "$.message" contains a user friendly text

  @retrieve_payments_400.04_invalid_x-correlator
  Scenario: Invalid x-correlator header
    Given the header "x-correlator" does not comply with the schema at "#/components/schemas/XCorrelator"
    When the request "retrievePayments" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"

  # Error 401 scenarios

  @retrieve_payments_401.01_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    When the request "retrievePayments" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_payments_401.02_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    When the request "retrievePayments" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_payments_401.03_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    When the request "retrievePayments" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Error 403 scenarios

  @retrieve_payments_403.01_invalid_token_permissions
  Scenario: Inconsistent access token permissions
    # To test this scenario, it will be necessary to obtain a token without the required scope
    Given header "Authorization" is set to an access token without the required scope
    When the request "retrievePayments" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  # Error 429 scenarios

  @retrieve_payments_429.01_Too_Many_Requests
  #To test this scenario environment has to be configured to reject requests reaching the threshold limit settled. N is a value defined by the Telco Operator
  Scenario: Request is rejected due to threshold policy
    Given the path parameter "paymentId" is set to a valid value in the environment
    And the header "Authorization" is set to a valid access token
    And the threshold of requests has been reached
    When the request "retrievePayments" is sent
    Then the response status code is 429
    And the response property "$.status" is 429
    And the response property "$.code" is "TOO_MANY_REQUESTS"
    And the response property "$.message" contains a user friendly text

  ##############################
  ##END
  ##############################