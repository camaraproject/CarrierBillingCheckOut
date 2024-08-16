Feature: CAMARA Carrier Billing API, v0.3 - Operation createPayment
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * TO DO
  #
  # Testing assets:
  # * TO DO
  # * TO DO
  # * TO DO
  #
  # References to OAS spec schemas refer to schemas specifies in carrier-billing.yaml, version 0.3.0

  Background: Common createPayment setup
    Given the resource "/carrier-billing/v0.3/payments"                                                              |
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema

  # Happy path scenarios


  @create_payment_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    # Valid default request body compliant with the schema
    # Property "$.amountTransaction" is set with required information only
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"


  @create_payment_02_generic_success_scenario_with_sink_information
  Scenario: Common validations for any success scenario with sink information provided
    # Property "$.amountTransaction" is set with required information only
    # Property "$.sink" is set with a valid public accessible HTTPs endpoint
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.sink" is set with a valid URL
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"


  @create_payment_03_generic_success_scenario_with_sink_and_sinkCredential_information
  Scenario: Common validations for any success scenario sink and sinkCredential information provided
    # Property "$.amountTransaction" is set with required information only
    # Property "$.sink" is set with a valid public accessible HTTPs endpoint
    # Property "$.sinkCredential" is set with a valid credential of type "ACCESSTOKEN"
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.sink" is set with a valid HTTPS URL
    And the request body property "$.sinkCredential" is set to a valid credential with property "$.sinkCredential.credentialType" set to "ACCESSTOKEN"
    And the request body is set to a valid request body
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"


  # Scenarios testing specific situations for amountTransaction

  @create_payment_04_amountTransaction_gross_amount
  Scenario: Request 1-step payment with gross amount
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.amountTransaction.paymentAmount.chargingInformation.isTaxIncluded" is set to true
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.paymentAmount.chargingInformation.isTaxIncluded" is true


  @create_payment_05_amountTransaction_net_amount
  Scenario: Request 1-step payment with net amount
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.amountTransaction.paymentAmount.chargingInformation.isTaxIncluded" is set to false OR not set
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.paymentAmount.chargingInformation.isTaxIncluded" is false OR not returned


  @create_payment_06_amountTransaction_taxAmount
  Scenario: Request 1-step payment indicating taxAmount
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.amountTransaction.paymentAmount.chargingInformation.taxAmount" is set to a valid value
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.paymentAmount.chargingInformation.taxAmount" has the same value as provided in the request body


  @create_payment_07_amountTransaction_merchantIdentifier
  # May be relevant scenario for Payment Aggregator Case
  Scenario: Request 1-step payment indicating merchantIdentifier
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.amountTransaction.paymentAmount.chargingMetaData.merchantIdentifier" is set to a valid value
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.paymentAmount.chargingMetaData.merchantIdentifier" has the same value as provided in the request body


  @create_payment_08_amountTransaction_paymentDetails
  Scenario: Request 1-step payment indicating merchantIdentifier
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body array property "$.amountTransaction.paymentAmount.paymentDetails" is set with valid information
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body array property "$.amountTransaction.paymentAmount.paymentDetails" has the same information as provided in the request body


  @create_payment_09_amountTransaction_clientCorrelator
  # Recommended scenario to manage request idempotency
  Scenario: Request 1-step payment indicating clientCorrelator
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.amountTransaction.clientCorrelator" is set to a valid value
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.clientCorrelator" has the same value as provided in the request body


  @create_payment_10_amountTransaction_phoneNumber
  # Case using a 3-legged Access Token
  Scenario: Request 1-step payment indicating phoneNumber
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.amountTransaction.phoneNumber" is set to a valid value which is the same as associated to access token
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.phoneNumber" has the same value as provided in the request body


  @create_payment_11_sync_behaviour
  # Scenario for a Telco Operator that behaves synchronously
  Scenario: Request 1-step payment with sync behaviour
    Given the request body property "$.amountTransaction" is set with valid required information
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.paymentStatus" is "succeeded"


  @create_payment_12_async_behaviour
  # Scenario for a Telco Operator that behaves asynchronously
  Scenario: Request 1-step payment with async behaviour
    Given the request body property "$.amountTransaction" is set with valid required information
    When the HTTP "POST" request is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.paymentStatus" is "processing"

HERE
  # Error scenarios


  # Error 400 scenarios

  @create_payment_xx_error_case
  Scenario: Retrieve location of a device specifying maxAge
    Given the request body property "$.amountTransaction" is set with valid required information
    When the HTTP "POST" request is sent
    Then the response status code is 4xx
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response property "$.status" is 4xx
    And the response property "$.code" is "CODE"
    And the response property "$.message" contains a user friendly text

