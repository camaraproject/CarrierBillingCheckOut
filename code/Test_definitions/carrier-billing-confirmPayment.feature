Feature: CAMARA Carrier Billing API, v0.5.0 - Operation confirmPayment
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * Endpoint required for 2-step payment
  #
  # Testing assets:
  # * A phone number eligible for payment (no restrictions for it to be used to perform a payment)
  # * A phone number not-eligible for payment (payment is denied for it due to business conditions)
  #
  # References to OAS spec schemas refer to schemas specifies in carrier-billing.yaml

  Background: Common confirmPayment setup
    Given the resource "/carrier-billing/v0.5/payments/{paymentId}/confirm"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the path parameter "paymentId" is set to a valid value
    And the request body is set by default to a request body compliant with the schema

  ##############################
  # Happy path scenarios
  ##############################

  @confirm_payment_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    # Valid default request body compliant with the schema
    Given the request body is set to a valid request body
    When the request "confirmPayment" is sent
    Then the response status code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"

  @confirm_payment_02_phoneNumber_three_legged
  # Case using a 3-legged Access Token
  Scenario: Request confirm payment indicating phoneNumber in 3-legged access mode
    Given the request body property "$.phonenumber" is set to a valid value which is the same as associated to access token
    When the request "confirmPayment" is sent
    Then the response status code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"

  @confirm_payment_03_phoneNumber_two_legged
  # Case using a 2-legged Access Token. Only applicable for Countries and Telco Operators whose regulation allows for it
  Scenario: Request confirm payment indicating phoneNumber in 2-legged access mode
    Given the request body property "$.phonenumber" is set to a valid value which is the same as associated to access token
    When the request "confirmPayment" is sent
    Then the response status code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"

  ##############################
  # Error scenarios
  ##############################

  # Error 400 scenarios

  @confirm_payment_400.01_no_request_body
  Scenario: Missing request body
    Given the request body is not included
    When the request "confirmPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @confirm_payment_400.02_empty_request_body
  Scenario: Empty object as request body
    Given the request body is set to "{}"
    When the request "confirmPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @confirm_payment_400.03_invalid_x-correlator
  Scenario: Invalid x-correlator header
    Given the header "x-correlator" does not comply with the schema at "#/components/schemas/XCorrelator"
    And the request body is set to a valid request body
    When the request "confirmPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"

  @confirm_payment_C02.01_phone_number_not_schema_compliant
  Scenario: Phone number value does not comply with the schema
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
    When the request "confirmPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Error 401 scenarios

  @confirm_payment_401.01_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the request "confirmPayment" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @confirm_payment_401.02_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the request "confirmPayment" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @confirm_payment_401.03_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the request "confirmPayment" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Error 403 scenarios

  @confirm_payment_403.01_invalid_token_permissions
  Scenario: Inconsistent access token permissions
    # To test this scenario, it will be necessary to obtain a token without the required scope
    Given the request body is set to a valid request body
    And the header "Authorization" is set to an access token without the required scope
    When the request "confirmPayment" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @confirm_payment_403.02_payment_denied
  Scenario: Payment denied by business
    # To test this, a business context exists in the Telco Operator to deny the payment
    Given the request body is set to a valid request body
    And the header "Authorization" is set to a valid access token
    When the request "confirmPayment" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "CARRIER_BILLING.PAYMENT_DENIED"
    And the response property "$.message" contains a user friendly text

  # Error 404 scenarios

  @confirm_payment_404.01_payment_not_found
  Scenario: Payment not found
    Given the header "Authorization" is set to a valid access token
    And the path parameter "paymentId" is compliant with the schema but does not identify a valid payment in the environment
    And the request body is set to a valid request body
    When the request "confirmPayment" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @confirm_payment_C02.02_phone_number_not_found
  Scenario: Phone number not found
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is compliant with the schema but does not identify a valid phone number
    When the request "confirmPayment" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  # Error 409 scenarios

  @confirm_payment_409.01_payment_confirmed
  Scenario: Payment already confirmed
    Given the request body is set to a valid request body
    And the path param "paymentId" is set to a valid value of an already confirmed payment
    And the header "Authorization" is set to a valid access token
    When the request "confirmPayment" is sent
    Then the response status code is 409
    And the response property "$.status" is 409
    And the response property "$.code" is "CARRIER_BILLING.PAYMENT_CONFIRMED"
    And the response property "$.message" contains a user friendly text

  @confirm_payment_409.02_payment_cancelled
  Scenario: Payment already cancelled
    Given the request body is set to a valid request body
    And the path param "paymentId" is set to a valid value of an already cancelled payment
    And the header "Authorization" is set to a valid access token
    When the request "confirmPayment" is sent
    Then the response status code is 409
    And the response property "$.status" is 409
    And the response property "$.code" is "CARRIER_BILLING.PAYMENT_CANCELLED"
    And the response property "$.message" contains a user friendly text

  # Error 422 scenarios

  @confirm_payment_422.01_phoneNumber_required
  Scenario: Payment requires the indication of phoneNumber. Only applicable to Countries and Telco Operators that allow and need it.
    Given the request body is set to a valid request body
    And the request body property "$.phoneNumber" is missing
    And the header "Authorization" is set to a valid access token
    When the request "confirmPayment" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "CARRIER_BILLING.PHONE_NUMBER_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @confirm_payment_C02.03_unnecessary_phone_number
  Scenario: Phone number not to be included when it can be deduced from the access token
    Given the header "Authorization" is set to a valid access token identifying a phone number
    And the request body property "$.phoneNumber" is set to a valid phone number
    When the request "confirmPayment" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @confirm_payment_C02.04_missing_phone_number
  Scenario: Phone number not included and cannot be deducted from the access token
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is not included
    When the request "confirmPayment" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MISSING_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  # When the service is only offered to certain type of subscriptions, e.g. IoT, , B2C, etc
  @confirm_payment_C02.05_phone_number_not_supported
  Scenario: Service not available for the phone number
    Given that the service is not available for all phone numbers commercialized by the operator
    And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
    When the request "confirmPayment" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user friendly text

  # Error 429 scenarios

  @confirm_payment_429.01_Too_Many_Requests
  #To test this scenario environment has to be configured to reject requests reaching the threshold limit settled. N is a value defined by the Telco Operator
  Scenario: Request is rejected due to threshold policy
    Given that the environment is configured with a threshold policy of N transactions per second
    And the request body is set to a valid request body
    And the header "Authorization" is set to a valid access token
    And the threshold of requests has been reached
    When the request "confirmPayment" is sent
    Then the response status code is 429
    And the response property "$.status" is 429
    And the response property "$.code" is "TOO_MANY_REQUESTS"
    And the response property "$.message" contains a user friendly text

  ##############################
  ##END
  ##############################