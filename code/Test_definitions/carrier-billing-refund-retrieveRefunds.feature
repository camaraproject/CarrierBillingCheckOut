Feature: CAMARA Carrier Billing Refund API, v0.3.0-rc.1 - Operation retrieveRefunds
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  #
  #
  # Testing assets:
  # * A phone number eligible for payment & refund
  # * Several payments and refunds performed in the environment (at least 10 for each of them)
  #
  # References to OAS spec schemas refer to schemas specifies in carrier-billing-refund.yaml, version 0.3.0-rc.1

  Background: Common retrievePayment setup
    Given the resource "/carrier-billing-refund/v0.3rc1/payments/{paymentId}/refunds"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the path parameter "paymentId" is set to a valid value

  ##############################
  # Happy path scenarios
  ##############################

  @retrieve_refunds_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    Given at least an existing refund created by operation createRefund
    When the request "retrieveRefunds" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/RefundArray"

  @retrieve_refunds_02_no_refunds
  Scenario: No existing refunds
    Given no refunds have been created by operation createRefund
    When the request "retrieveRefunds" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an empty array "[]"

  @retrieve_refunds_03_for_phoneNumber
  Scenario: List of refunds for a given phone number
    Given at least an existing refund created by operation createRefund
    And the header "Authorization" is set to a valid access token associated for a phone number with refunds requested
    When the request "retrieveRefunds" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/RefundArray"
    And only the refunds associated to that phone number are returned

  @retrieve_refunds_04_for_application
  Scenario: List of refunds for a given application (API client)
  #To test this scenario, a 2-legged token is needed
    Given several existing refunds created by operation createRefund
    And the header "Authorization" is set to a valid access token not emitted for a specific phone number
    When the request "retrieveRefunds" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/RefundArray"
    And only the refunds associated to that application are returned

  # Query Parameter scenarios

  @retrieve_refunds_05_start_creationDate
  Scenario Outline: List of refunds since a given creationDate
    Given several existing refunds created by operation createRefund
    And the header "Authorization" is set to a valid access token
    And the query parameter "refundCreationDate.gte" is set to "<creation_date>"
    When the request "retrieveRefunds" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/RefundArray"
    And all the refunds returned have their property "$[*].refundCreationDate" greater or equal than "<creation_date>"
    And only the refunds with their property "$[*].refundCreationDate" greater or equal than "<creation_date>" are returned

    Examples:
      | creation_date |
      | NOW - 1 day   |
      | NOW - 7 days  |
      | NOW - 30 days |

  @retrieve_refunds_06_end_creationDate
  Scenario Outline: List of refunds up to a given creationDate
    Given several existing refunds created by operation createRefund
    And the header "Authorization" is set to a valid access token
    And the query parameter "refundCreationDate.lte" is set to "<creation_date>"
    When the request "retrieveRefunds" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/RefundArray"
    And all the refunds returned have their property "$[*].refundCreationDate" lower or equal than "<creation_date>"
    And only the refunds with their property "$[*].refundCreationDate" lower or equal than "<creation_date>" are returned

    Examples:
      | creation_date |
      | NOW - 1 day   |
      | NOW - 3 days  |
      | NOW - 7 days  |

  @retrieve_refunds_07_date_range
  Scenario Outline: List of refunds within a creationDate range
    Given several existing refunds created by operation createRefund
    And the header "Authorization" is set to a valid access token
    And the query parameter "refundCreationDate.gte" is set to "<start_creation_date>"
    And the query parameter "refundCreationDate.lte" is set to "<end_creation_date>"
    When the request "retrieveRefunds" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/RefundArray"
    And all the refunds returned have their property "$[*].refundCreationDate" between "<start_creation_date>" and "<end_creation_date>"
    And only the refunds with their property "$[*].refundCreationDate" between "<start_creation_date>" and "<end_creation_date>"

    Examples:
      | start_creation_date | end_creation_date |
      | NOW - 7 days        | NOW               |
      | NOW - 30 days       | NOW               |
      | NOW - 30 days       | NOW - 7 days      |

  @retrieve_refunds_08_ordering
  Scenario Outline: List of refunds ordered by refundCreationDate
    Given several existing refunds created by operation createRefund
    And the header "Authorization" is set to a valid access token
    And the query parameter "order" is set to "<order>"
    When the request "retrieveRefunds" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/RefundArray"
    And all the refunds returned are ordered by "<order>" property "$[*].refundCreationDate"

    Examples:
      | order |
      | desc  |
      | asc   |

  @retrieve_refunds_09_refund_status
  Scenario Outline: List of refunds in a given status
    Given several existing refunds created by operation createRefund in different refund status
    And the header "Authorization" is set to a valid access token
    And the query parameter "paymentStatus" is set to "<refund_status>"
    When the request "retrieveRefunds" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/RefundArray"
    And all the refunds returned have their property "$[*].refundStatus" == "<refund_status>"
    And only the refunds with their property "$[*].refundStatus" == "<refund_status>" are returned

    Examples:
      | refund_status      |
      | processing         |
      | denied             |
      | succeeded          |

  @retrieve_refunds_10_merchantIdentifier
  Scenario: List of refunds for a given merchantIdentifier
    Given several existing refunds created by operation createRefund for a given merchant
    And the header "Authorization" is set to a valid access token
    And the query parameter "merchantIdentifier" is set to the value representing such a merchant
    When the request "retrieveRefunds" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/RefundArray"
    And all the refunds returned have their property "$[*].amountTransaction.refundAmount.chargingMetadata.merchantIdentifier" set to the same value as the query parameter "merchantIdentifier"
    And only the refunds with their property "$[*].amountTransaction.refundAmount.chargingMetadata.merchantIdentifier" set to the same value as the query parameter "merchantIdentifier" are returned

  @retrieve_refunds_11_pagination
  Scenario: Pagination in List of refunds
    Given several existing refunds created by operation createRefund, at least more than five
    And the header "Authorization" is set to a valid access token
    And the query parameter "page" is set to "1"
    And the query parameter "perPage" is set to "5"
    When the request "retrieveRefunds" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/RefundArray"
    And only five refunds are returned

  ##############################
  # Error scenarios
  ##############################

  # Error 400 scenarios

  @retrieve_refunds_400.01_invalid_date_range
  Scenario Outline: List of refunds with an invalid date range
    Given several existing refunds created by operation createRefund
    And the header "Authorization" is set to a valid access token
    And the query parameter "refundCreationDate.gte" is set to "<start_creation_date>"
    And the query parameter "refundCreationDate.lte" is set to "<end_creation_date>"
    When the request "retrieveRefunds" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "CARRIER_BILLING_REFUND.INVALID_DATE_RANGE"
    And the response property "$.message" contains a user friendly text

    Examples:
      | start_creation_date | end_creation_date |
      | NOW                 | NOW - 7 days      |
      | NOW - 7 days        | NOW - 30 days     |

  @retrieve_refunds_400.02_out_of_range
  Scenario: List of refunds out of range
    Given several existing refunds created by operation createRefund
    And the header "Authorization" is set to a valid access token
    And the query parameter "page" is set to "1000"
    And the query parameter "perPage" is set to "1000"
    When the request "retrieveRefunds" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "CARRIER_BILLING_REFUND.OUT_OF_RANGE"
    And the response property "$.message" contains a user friendly text

  @retrieve_refunds_400.03_too_many_matching_records
  Scenario: List of refunds too many matching records
  #Optional test to be performed. To test this scenario there would be needed many refunds in the environment.
    Given several existing refunds created by operation createRefund
    And the header "Authorization" is set to a valid access token
    And the query parameter "page" is set to "1"
    And the query parameter "perPage" is set to "1000"
    When the request "retrieveRefunds" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "CARRIER_BILLING_REFUND.TOO_MANY_MATCHING_RECORDS"
    And the response property "$.message" contains a user friendly text

  @retrieve_refunds_400.04_invalid_x-correlator
  Scenario: Invalid x-correlator header
    Given the header "x-correlator" does not comply with the schema at "#/components/schemas/XCorrelator"
    When the request "retrieveRefunds" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"

  # Error 401 scenarios

  @retrieve_refunds_401.01_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    When the request "retrieveRefunds" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_refunds_401.02_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    When the request "retrieveRefunds" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_refunds_401.03_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    When the request "retrieveRefunds" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Error 403 scenarios

  @retrieve_refunds_403.01_invalid_token_permissions
  Scenario: Inconsistent access token permissions
    # To test this scenario, it will be necessary to obtain a token without the required scope
    Given header "Authorization" is set to an access token without the required scope
    When the request "retrieveRefunds" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  # Error 429 scenarios

  @retrieve_refunds_429.01_Too_Many_Requests
  #To test this scenario environment has to be configured to reject requests reaching the threshold limit settled. N is a value defined by the Telco Operator
  Scenario: Request is rejected due to threshold policy
    Given the path parameter "paymentId" is set to a valid value in the environment
    And the path parameter "refundId" is set to a valid value in the environment
    And the header "Authorization" is set to a valid access token
    And the threshold of requests has been reached
    When the request "retrieveRefunds" is sent
    Then the response status code is 429
    And the response property "$.status" is 429
    And the response property "$.code" is "TOO_MANY_REQUESTS"
    And the response property "$.message" contains a user friendly text

  ##############################
  ##END
  ##############################