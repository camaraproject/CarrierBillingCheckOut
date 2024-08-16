Feature: CAMARA Carrier Billing API, v0.3 - Operation cancelPayment
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * Endpoint required for 2-step payment
  #
  # Testing assets:
  # * TO DO
  # * TO DO
  # * TO DO
  #
  # References to OAS spec schemas refer to schemas specifies in carrier-billing.yaml, version 0.3.0

  Background: Common validatePayment setup
    Given the resource "/carrier-billing/v0.3/payments/{paymentId}/cancel"                                                              |
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the path parameter "paymentId" is set to a valid value
    And the request body is set by default to a request body compliant with the schema

  # Happy path scenarios


  @cancel_payment_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    # Valid default request body compliant with the schema
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"


  @cancel_payment_02_phoneNumber_included
  # Case using a 3-legged Access Token
  Scenario: Request cancel payment indicating phoneNumber
    Given the request body property "$.phonenumber" is set to a valid value which is the same as associated to access token
    When the HTTP "POST" request is sent
    Then the response status code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"


HERE
  # Error scenarios


  # Error 400 scenarios

  @cancel_payment_xx_error_case
  Scenario: Retrieve location of a device specifying maxAge
    Given the request body property "$.amountTransaction" is set with valid required information
    When the HTTP "POST" request is sent
    Then the response status code is 4xx
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response property "$.status" is 4xx
    And the response property "$.code" is "CODE"
    And the response property "$.message" contains a user friendly text

