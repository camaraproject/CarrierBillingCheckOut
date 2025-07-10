Feature: CAMARA Carrier Billing Refund API, v0.3.0-rc.1 - Operation retrieveRefund
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

  Background: Common retrieveRefund setup
    Given the resource "/carrier-billing-refund/v0.3rc1/payments/{paymentId}/refunds/{refundId}"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the path parameter "paymentId" is set to a valid value
    And the path parameter "refundId" is set to a valid value

  ##############################
  # Happy path scenarios
  ##############################

  @retrieve_refund_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    Given an existing refund created by operation createRefund
    And the path parameter "refundId" is set to the value for this refund
    And the path parameter "paymentId" is set to the value of the payment related to this refund
    When the request "retrieveRefund" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/Refund"

  ##############################
  # Error scenarios
  ##############################

  # Error 400 scenarios

  @retrieve_refund_400.01_invalid_x-correlator
  Scenario: Invalid x-correlator header
    Given the header "x-correlator" does not comply with the schema at "#/components/schemas/XCorrelator"
    When the request "retrieveRefund" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"

  # Error 401 scenarios

  @retrieve_refund_401.01_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the path parameter "paymentId" is set to a valid value
    And the path parameter "refundId" is set to a valid value
    When the request "retrieveRefund" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_refund_401.02_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the path parameter "paymentId" is set to a valid value
    And the path parameter "refundId" is set to a valid value
    When the request "retrieveRefund" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_refund_401.03_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the path parameter "paymentId" is set to a valid value
    And the path parameter "refundId" is set to a valid value
    When the request "retrieveRefund" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Error 403 scenarios

  @retrieve_refund_403.01_invalid_token_permissions
  Scenario: Inconsistent access token permissions
    # To test this scenario, it will be necessary to obtain a token without the required scope
    Given header "Authorization" is set to an access token without the required scope
    And the path parameter "paymentId" is set to a valid value
    When the request "retrieveRefund" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  # Error 404 scenarios

  @retrieve_refund_404.01_payment_not_found
  Scenario: Payment not found
    Given the header "Authorization" is set to a valid access token
    And the path parameter "paymentId" is compliant with the schema but does not identify a valid payment in the environment
    And the path parameter "refundId" is set to a valid value in the environment
    When the request "retrieveRefund" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @retrieve_refund_404.02_refund_not_found
  Scenario: Refund not found
    Given the header "Authorization" is set to a valid access token
    And the path parameter "paymentId" is set to a valid value in the environment
    And the path parameter "refundId" is compliant with the schema but does not identify a valid refund in the environment
    When the request "retrieveRefund" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  # Error 429 scenarios

  @retrieve_refund_429.01_Too_Many_Requests
  #To test this scenario environment has to be configured to reject requests reaching the threshold limit settled. N is a value defined by the Telco Operator
  Scenario: Request is rejected due to threshold policy
    Given the path parameter "paymentId" is set to a valid value in the environment
    And the path parameter "refundId" is set to a valid value in the environment
    And the header "Authorization" is set to a valid access token
    And the threshold of requests has been reached
    When the request "retrieveRefund" is sent
    Then the response status code is 429
    And the response property "$.status" is 429
    And the response property "$.code" is "TOO_MANY_REQUESTS"
    And the response property "$.message" contains a user friendly text

  ##############################
  ##END
  ##############################