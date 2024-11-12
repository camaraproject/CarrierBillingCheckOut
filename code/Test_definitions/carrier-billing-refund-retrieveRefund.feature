Feature: CAMARA Carrier Billing Refund API, v0.1 - Operation retrieveRefund
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  #
  #
  # Testing assets:
  # * A phone number eligible for payment & refund
  # * Several payments and refunds performed in the environment (at least 10 for each of them)
  #
  # References to OAS spec schemas refer to schemas specifies in carrier-billing-refund.yaml, version 0.1.0

  Background: Common retrieveRefund setup
    Given the resource "/carrier-billing-refund/v0.1/payments/{paymentId}/refunds/{refundId}"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
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
    When the HTTP "GET" request is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/Refund"

  ##############################
  # Error scenarios
  ##############################

  # Error 401 scenarios

  @retrieve_refund_401.01_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the path parameter "paymentId" is set to a valid value
    And the path parameter "refundId" is set to a valid value
    When the HTTP "GET" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_refund_401.02_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the path parameter "paymentId" is set to a valid value
    And the path parameter "refundId" is set to a valid value
    When the HTTP "GET" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_refund_401.03_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the path parameter "paymentId" is set to a valid value
    And the path parameter "refundId" is set to a valid value
    When the HTTP "GET" request is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Error 403 scenarios

  @retrieve_refund_403.01_invalid_token_permissions
  Scenario: Inconsistent access token permissions
    # To test this, an access token has to be obtained without carrier-billing-refund:refunds:read scope
    Given header "Authorization" is set to a valid access token emitted without carrier-billing-refund:refunds:read scope
    And the path parameter "paymentId" is set to a valid value
    When the HTTP "GET" request is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @retrieve_refund_403.02_phoneNumber_token_mismatch
  Scenario: Inconsistent access token context for the phoneNumber
    # To test this, a 3-legged access token has to be obtained for a different phoneNumber
    Given the header "Authorization" is set to a valid access token emitted for a phone number
    And the path parameter "paymentId" is set to a valid value associated to a phone number different than the access token is associated
    And the path parameter "refundId" is set to a valid value associated to the "paymentId"
    When the HTTP "GET" request is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text

  # Error 404 scenarios

  @retrieve_refund_404.01_payment_not_found
  Scenario: Payment not found
    # To test this, a 2-legged access token is needed, just beacuse if not it triggers test "@retrieve_refund_403.02_phoneNumber_token_mismatch"
    Given the path parameter "paymentId" is set to a non-existing value in the environment
    And the path parameter "refundId" is set to a valid value in the environment
    And the header "Authorization" is set to a valid access token
    When the HTTP "POST" request is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @retrieve_refund_404.02_refund_not_found
  Scenario: Refund not found
    Given the path parameter "paymentId" is set to a valid value in the environment
    And the path parameter "refundId" is set to a non-existing value in the environment
    And the header "Authorization" is set to a valid access token
    When the HTTP "POST" request is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  ##############################
  ##END
  ##############################
