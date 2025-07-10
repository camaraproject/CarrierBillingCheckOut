Feature: CAMARA Carrier Billing API, v0.5.0-rc.1 - Operation validatePayment
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * Optional endpoint in a 2-step payment just only used in case a validation step is needed between reservation and commitment of the payment
  #
  # Testing assets:
  # * N/A (so far)
  #
  # References to OAS spec schemas refer to schemas specifies in carrier-billing.yaml, version 0.5.0-rc.1

  Background: Common validatePayment setup
    Given the resource "/carrier-billing/v0.5rc1/payments/{paymentId}/validate"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the path parameter "paymentId" is set to a valid value
    And the request body is set by default to a request body compliant with the schema

  ##############################
  # Happy path scenarios
  ##############################

  @validate_payment_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    # Valid default request body compliant with the schema
    Given the request body property "$.authorizationId" is set to a valid value
    And the request body property "$.code" is set to a valid value
    And the request body is set to a valid request body
    When the request "validatePayment" is sent
    Then the response status code is 204
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"

  ##############################
  # Error scenarios
  ##############################

  # Error 400 scenarios

  @validate_payment_400.01_no_request_body
  Scenario: Missing request body
    Given the request body is not included
    When the request "validatePayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @validate_payment_400.02_empty_request_body
  Scenario: Empty object as request body
    Given the request body is set to "{}"
    When the request "validatePayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @validate_payment_400.03_required_input_properties_missing
  Scenario Outline: Required input properties are missing
    Given the request body property "<input_property>" is not included
    When the request "validatePayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | input_property                    |
      | $.authorizationId                 |
      | $.code                            |

  @validate_payment_400.04_invalid_authorizationId
  Scenario: Using a invalid authorizationId value
    Given the request body property includes property "$.authorizationId" with a non-existing value in the environment
    When the request "validatePayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "CARRIER_BILLING.INVALID_AUTHORIZATION_ID"
    And the response property "$.message" contains a user friendly text

  @validate_payment_400.05_invalid_code
  Scenario: Using a invalid code value
    Given the request body property includes property "$.code" with a non-existing value in the environment
    When the request "validatePayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "CARRIER_BILLING.INVALID_CODE"
    And the response property "$.message" contains a user friendly text

  @validate_payment_400.06_exceeding_validation_attempts
  # Variable "N" can vary up to Telco Operator policies
  Scenario Outline: Using a invalid code value after N requests
    Given the request body property includes property "$.code" with a non-existing value in the environment
    When the request "validatePayment" is sent after "<Number>" times
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "CARRIER_BILLING.VALIDATION_FAILED"
    And the response property "$.message" contains a user friendly text

    Examples:
      | Number |
      | 3      |
      | 5      |

  @validate_payment_400.07_invalid_x-correlator
  Scenario: Invalid x-correlator header
    Given the header "x-correlator" does not comply with the schema at "#/components/schemas/XCorrelator"
    And the request body is set to a valid request body
    When the request "validatePayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"

  # Error 401 scenarios

  @validate_payment_01_generic_success_scenario_payment_401.01_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the request "validatePayment" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @validate_payment_401.02_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the request "validatePayment" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @validate_payment_401.03_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the request "validatePayment" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Error 403 scenarios

  @validate_payment_403.01_invalid_token_permissions
  Scenario: Inconsistent access token permissions
    # To test this scenario, it will be necessary to obtain a token without the required scope
    Given the request body is set to a valid request body
    And the header "Authorization" is set to an access token without the required scope
    When the request "validatePayment" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  # Error 404 scenarios

  @validate_payment_404.01_payment_not_found
  Scenario: Payment not found
    Given the header "Authorization" is set to a valid access token
    And the path parameter "paymentId" is compliant with the schema but does not identify a valid payment in the environment
    And the request body is set to a valid request body
    When the request "validatePayment" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  # Error 429 scenarios

  @validate_payment_429.01_Too_Many_Requests
  #To test this scenario environment has to be configured to reject requests reaching the threshold limit settled. N is a value defined by the Telco Operator
  Scenario: Request is rejected due to threshold policy
    Given that the environment is configured with a threshold policy of N transactions per second
    And the request body is set to a valid request body
    And the header "Authorization" is set to a valid access token
    And the threshold of requests has been reached
    When the request "validatePayment" is sent
    Then the response status code is 429
    And the response property "$.status" is 429
    And the response property "$.code" is "TOO_MANY_REQUESTS"
    And the response property "$.message" contains a user friendly text

  ##############################
  ##END
  ##############################