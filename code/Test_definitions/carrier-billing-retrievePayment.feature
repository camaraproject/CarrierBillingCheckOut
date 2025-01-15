Feature: CAMARA Carrier Billing API, v0.4 - Operation retrievePayment
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  #
  #
  # Testing assets:
  # * A phone number eligible for payment (no restrictions for it to be used to perform a payment)
  # * Several payments performed in different status in the environment (at least 10)
  #
  # References to OAS spec schemas refer to schemas specifies in carrier-billing.yaml, version 0.4.0

  Background: Common retrievePayment setup
    Given the resource "/carrier-billing/v0.4/payments/{paymentId}"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the path parameter "paymentId" is set to a valid value

  ##############################
  # Happy path scenarios
  ##############################

  @retrieve_payment_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    Given an existing payment created by operation createPayment OR preparePayment
    And the path parameter "paymentId" is set to the value for that payment
    When the HTTP "GET" request is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/Payment"

  ##############################
  # Error scenarios
  ##############################

  # Error 401 scenarios

  @retrieve_payment_401.01_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the path parameter "paymentId" is set to a valid value
    When the HTTP "GET" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_payment_401.02_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the path parameter "paymentId" is set to a valid value
    When the HTTP "GET" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_payment_401.03_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the path parameter "paymentId" is set to a valid value
    When the HTTP "GET" request is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Error 403 scenarios

  @retrieve_payment_403.01_invalid_token_permissions
  Scenario: Inconsistent access token permissions
    # To test this, an access token has to be obtained without carrier-billing:payments:read scope
    Given header "Authorization" is set to a valid access token emitted without carrier-billing:payments:read scope
    And the path parameter "paymentId" is set to a valid value
    When the HTTP "GET" request is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @retrieve_payment_403.02_phoneNumber_token_mismatch
  Scenario: Inconsistent access token context for the phoneNumber
    # To test this, a 3-legged access token has to be obtained for a different phoneNumber
    Given the header "Authorization" is set to a valid access token emitted for a phone number
    And the path parameter "paymentId" is set to a valid value associated to a phone number different than the access token is associated
    When the HTTP "GET" request is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "CARRIER_BILLING.INVALID_PAYMENT_CONTEXT"
    And the response property "$.message" contains a user friendly text

  # Error 404 scenarios

  @retrieve_payment_404.01_payment_not_found
  Scenario: Payment not found
    # To test this, a 2-legged access token is needed, just beacuse if not it triggers test "@retrieve_payment_403.02_phoneNumber_token_mismatch"
    Given the path parameter "paymentId" is set to non-existing value in the environment
    And the header "Authorization" is set to a valid access token
    When the HTTP "POST" request is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  ##############################
  ##END
  ##############################