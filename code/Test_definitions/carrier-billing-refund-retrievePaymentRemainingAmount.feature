Feature: CAMARA Carrier Billing Refund API, v0.2 - Operation retrievePaymentRemainingAmount
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  #
  #
  # Testing assets:
  # * A phone number eligible for payment & refund
  # * Several payments refunds performed in different situations (total and partial)
  #
  # References to OAS spec schemas refer to schemas specifies in carrier-billing-refund.yaml, version 0.2.0-rc.1

  Background: Common retrievePayment setup
    Given the resource "/carrier-billing-refund/v0.2/payments/{paymentId}/refunds/remaining-amount"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the path parameter "paymentId" is set to a valid value

  ##############################
  # Happy path scenarios
  ##############################

  @retrieve_payment_remaining_amount_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    Given an existing payment created by operation createPayment OR preparePayment
    And the path parameter "paymentId" is set to the value for that payment
    When the HTTP "GET" request is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentRemainingAmount"

  @retrieve_payment_remaining_amount_02_total_refund_in_progress
  Scenario: Remaining payment amount for total refund in progress
    Given an existing payment created by operation createPayment OR preparePayment
    And an existing total refund being perfomed for that "paymentId"
    And the path parameter "paymentId" is set to the value for that payment
    When the HTTP "GET" request is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentRemainingAmount"
    And the response property "$.amount" is "0"

  @retrieve_payment_remaining_amount_03_total_refund_succeeded
  Scenario: Remaining payment amount for total refund succeeded
    Given an existing payment created by operation createPayment OR preparePayment
    And an existing total refund completed successfully for that "paymentId"
    And the path parameter "paymentId" is set to the value for that payment
    When the HTTP "GET" request is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentRemainingAmount"
    And the response property "$.amount" is "0"

  @retrieve_payment_remaining_amount_04_total_refund_denied
  Scenario: Remaining payment amount for total refund denied
    Given an existing payment created by operation createPayment OR preparePayment
    And an existing total refund finally denied for that "paymentId"
    And the path parameter "paymentId" is set to the value for that payment
    When the HTTP "GET" request is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentRemainingAmount"
    And the response property "$.amount" is the value of the amount of the related payment

  @retrieve_payment_remaining_amount_05_partial_refund_in_progress
  Scenario: Remaining payment amount for partial refund in progress
    Given an existing payment created by operation createPayment OR preparePayment
    And an existing partial refund being perfomed for that "paymentId"
    And the path parameter "paymentId" is set to the value for that payment
    When the HTTP "GET" request is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentRemainingAmount"
    And the response property "$.amount" is the value of "payment amount" - "refund amount"

  @retrieve_payment_remaining_amount_06_partial_refund_succeeded
  Scenario: Remaining payment amount for partial refund succeeded
    Given an existing payment created by operation createPayment OR preparePayment
    And an existing partial refund completed successfully for that "paymentId"
    And the path parameter "paymentId" is set to the value for that payment
    When the HTTP "GET" request is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentRemainingAmount"
    And the response property "$.amount" is the value of "payment amount" - "refund amount"

  @retrieve_payment_remaining_amount_07_partial_refund_denied
  Scenario: Remaining payment amount for partial refund denied
    Given an existing payment created by operation createPayment OR preparePayment
    And an existing partial refund finally denied for that "paymentId"
    And the path parameter "paymentId" is set to the value for that payment
    When the HTTP "GET" request is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentRemainingAmount"
    And the response property "$.amount" is the value of the amount of the related payment

  ##############################
  # Error scenarios
  ##############################

  # Error 401 scenarios

  @retrieve_payment_remaining_amount_401.01_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the path parameter "paymentId" is set to a valid value
    When the HTTP "GET" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_payment_remaining_amount_401.02_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the path parameter "paymentId" is set to a valid value
    When the HTTP "GET" request is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @retrieve_payment_remaining_amount_401.03_invalid_access_token
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

  @retrieve_payment_remaining_amount_403.01_invalid_token_permissions
  Scenario: Inconsistent access token permissions
    # To test this, an access token has to be obtained without carrier-billing-refund:refunds:read scope
    Given header "Authorization" is set to a valid access token emitted without carrier-billing-refund:refunds:read scope
    And the path parameter "paymentId" is set to a valid value
    When the HTTP "GET" request is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @retrieve_payment_remaining_amount_403.02_phoneNumber_token_mismatch
  Scenario: Inconsistent access token context for the phoneNumber
    # To test this, a 3-legged access token has to be obtained for a different phoneNumber
    Given the header "Authorization" is set to a valid access token emitted for a phone number
    And the path parameter "paymentId" is set to a valid value associated to a phone number different than the access token is associated
    When the HTTP "GET" request is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "CARRIER_BILLING_REFUND.INVALID_REFUND_CONTEXT"
    And the response property "$.message" contains a user friendly text

  # Error 404 scenarios

  @retrieve_payment_remaining_amount_404.01_payment_not_found
  Scenario: Payment not found
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