Feature: CAMARA Carrier Billing API, v0.5.0 - Operation createPayment
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * Telco Operator carrier billing behaviour mode: sync or async
  #
  # Testing assets:
  # * A phone number eligible for payment (no restrictions for it to be used to perform a payment)
  # * A phone number not-eligible for payment (payment is denied for it due to business conditions)
  #
  # References to OAS spec schemas refer to schemas specifies in carrier-billing.yaml

  Background: Common createPayment setup
    Given the resource "/carrier-billing/v0.5/payments"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is set by default to a request body compliant with the schema

  ##############################
  # Happy path scenarios
  ##############################

  @create_payment_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    # Valid default request body compliant with the schema
    # Property "$.amountTransaction" is set with required information only
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body is set to a valid request body
    When the request "createPayment" is sent
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
    When the request "createPayment" is sent
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
    When the request "createPayment" is sent
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
    When the request "createPayment" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.paymentAmount.chargingInformation.isTaxIncluded" is true

  @create_payment_05_amountTransaction_net_amount
  Scenario: Request 1-step payment with net amount
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.amountTransaction.paymentAmount.chargingInformation.isTaxIncluded" is set to false OR not set
    When the request "createPayment" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.paymentAmount.chargingInformation.isTaxIncluded" is false OR not returned

  @create_payment_06_amountTransaction_taxAmount
  Scenario: Request 1-step payment indicating taxAmount
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.amountTransaction.paymentAmount.chargingInformation.taxAmount" is set to a valid value
    When the request "createPayment" is sent
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
    When the request "createPayment" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.paymentAmount.chargingMetaData.merchantIdentifier" has the same value as provided in the request body

  @create_payment_08_amountTransaction_paymentDetails
  Scenario: Request 1-step payment indicating paymentDetails
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body array property "$.amountTransaction.paymentAmount.paymentDetails" is set with valid information
    When the request "createPayment" is sent
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
    When the request "createPayment" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.clientCorrelator" has the same value as provided in the request body

  @create_payment_10_amountTransaction_phoneNumber_three_legged
  # Case using a 3-legged Access Token emitted for a specific phone number
  Scenario: Request 1-step payment indicating phoneNumber in 3-legged access mode
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.amountTransaction.phoneNumber" is set to a valid value which is the same as associated to access token
    When the request "createPayment" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.phoneNumber" has the same value as provided in the request body

  @create_payment_11_amountTransaction_phoneNumber_two_legged
  # Case using a 2-legged Access Token. Only applicable for Countries and Telco Operators whose regulation allows for it
  Scenario: Request 1-step payment indicating phoneNumber in 2-legged access mode
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.amountTransaction.phoneNumber" is set to a valid value
    When the request "createPayment" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.amountTransaction.phoneNumber" has the same value as provided in the request body

  @create_payment_12_sync_behaviour
  # Scenario for a Telco Operator that behaves synchronously
  Scenario: Request 1-step payment with sync behaviour
    Given the request body property "$.amountTransaction" is set with valid required information
    When the request "createPayment" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.paymentStatus" is "succeeded"

  @create_payment_13_async_behaviour
  # Scenario for a Telco Operator that behaves asynchronously
  Scenario: Request 1-step payment with async behaviour
    Given the request body property "$.amountTransaction" is set with valid required information
    When the request "createPayment" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PaymentCreated"
    And the response body property "$.paymentStatus" is "processing"

  ##############################
  # Error scenarios
  ##############################

  # Error 400 scenarios

  @create_payment_400.01_no_request_body
  Scenario: Missing request body
    Given the request body is not included
    When the request "createPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @create_payment_400.02_empty_request_body
  Scenario: Empty object as request body
    Given the request body is set to "{}"
    When the request "createPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @create_payment_400.03_other_input_properties_schema_not_compliant
  # Test other input properties in addition to amountTransaction
  Scenario Outline: Input property values does not comply with the schema
    Given the request body property "<input_property>" does not comply with the OAS schema at <oas_spec_schema>
    When the request "createPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | input_property          | oas_spec_schema                    |
      | $.sink                  | /components/schemas/CreatePayment  |
      | $.sinkCredential        | /components/schemas/SinkCredential |

  @create_payment_400.04_required_input_properties_missing
  Scenario Outline: Required input properties are missing
    Given the request body property "<input_property>" is not included
    When the request "createPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | input_property                                                    |
      | $.amountTransaction                                               |
      | $.amountTransaction.paymentAmount                                 |
      | $.amountTransaction.referenceCode                                 |
      | $.amountTransaction.paymentAmount.chargingInformation             |
      | $.amountTransaction.paymentAmount.chargingInformation.amount      |
      | $.amountTransaction.paymentAmount.chargingInformation.currency    |
      | $.amountTransaction.paymentAmount.chargingInformation.description |

  @create_payment_400.05_clientCorrelator_in_use
  Scenario: Using the same client correlator for two different payment requests
    Given the request body property includes property "$.clientCorrelator" with a value already use in a non-completed payment
    When the request "createPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @create_payment_400.06_invalid_sink
  Scenario: Using a invalid sink value
    Given the request body property includes property "$.sink" which is not set to an url
    When the request "createPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_SINK"
    And the response property "$.message" contains a user friendly text

  @create_payment_400.07_invalid_sinkCredential
  Scenario: Using a invalid sinkCredential type value
    Given the request body property includes property "$.sinkCredential.credentialType" whose value is not "ACCESSTOKEN"
    When the request "createPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text

  @create_payment_400.08_invalid_sinkCredential_Acccestoken
  Scenario: Using a invalid sinkCredential accesstoken type value
    Given the request body property includes property "$.sinkCredential.accessTokenType" whose value is not "bearer"
    When the request "createPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN"
    And the response property "$.message" contains a user friendly text

  @create_payment_400.09_invalid_x-correlator
  Scenario: Invalid x-correlator header
    Given the header "x-correlator" does not comply with the schema at "#/components/schemas/XCorrelator"
    And the request body is set to a valid request body
    When the request "createPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"

  @create_payment_C02.01_phone_number_not_schema_compliant
  Scenario: Phone number value does not comply with the schema
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
    When the request "createPayment" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Error 401 scenarios

  @create_payment_401.01_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the request "createPayment" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @create_payment_401.02_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the request "createPayment" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @create_payment_401.03_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the request "createPayment" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Error 403 scenarios

  @create_payment_403.01_invalid_token_permissions
  Scenario: Inconsistent access token permissions
    # To test this scenario, it will be necessary to obtain a token without the required scope
    Given the request body is set to a valid request body
    And the header "Authorization" is set to an access token without the required scope
    When the request "createPayment" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @create_payment_403.02_payment_denied
  Scenario: Payment denied by business
    # To test this, a business context exists in the Telco Operator to deny the payment
    Given the request body is set to a valid request body
    And the header "Authorization" is set to a valid access token
    When the request "createPayment" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "CARRIER_BILLING.PAYMENT_DENIED"
    And the response property "$.message" contains a user friendly text

  # Error 404 scenarios

  @create_payment_C02.02_phone_number_not_found
  Scenario: Phone number not found
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.amountTransaction.phoneNumber" is compliant with the schema but does not identify a valid phone number
    When the request "createPayment" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  # Error 409 scenarios

  @create_payment_409.01_payment_duplicated
  Scenario: Payment duplicated
    Given the request body is set to a valid request body
    And the request body property "$.amountTransaction.referenceCode" is set to a value already use in another payment request
    And the request body property "$.clientCorrelator" is missing
    And the header "Authorization" is set to a valid access token
    When the request "createPayment" is sent
    Then the response status code is 409
    And the response property "$.status" is 409
    And the response property "$.code" is "ALREADY_EXISTS"
    And the response property "$.message" contains a user friendly text

  # Error 422 scenarios

  @create_payment_422.01_phoneNumber_required
  Scenario: Payment requires the indication of phoneNumber. Only applicable to Countries and Telco Operators that allow and need it.
    Given the request body is set to a valid request body
    And the request body property "$.amountTransaction.phoneNumber" is missing
    And the header "Authorization" is set to a valid access token
    When the request "createPayment" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "CARRIER_BILLING.PHONE_NUMBER_REQUIRED"
    And the response property "$.message" contains a user friendly text

  @create_payment_422.02_unauthorized_amount
  Scenario: Payment amount exceeds the value allowed by the regulation
    # This test applies/depends on the regulation applicable for a given Country
    Given the request body is set to a valid request body
    And the request body property "$.amountTransaction.paymentAmount.chargingInformationAmount" exceeds the value allowed by the regulation
    And the header "Authorization" is set to a valid access token
    When the request "createPayment" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "CARRIER_BILLING.UNAUTHORIZED_AMOUNT"
    And the response property "$.message" contains a user friendly text

  @create_payment_422.02_accumulated_threshold_amount_overpassed
  Scenario: Payment amount exceeds the accumulated threshold amount value allowed by the regulation
    # This test applies/depends on the regulation applicable for a given Country
    Given the request body is set to a valid request body
    And the request body property "$.amountTransaction.paymentAmount.chargingInformationAmount" exceeds the accumulated threshold amount value allowed by the regulation
    And the header "Authorization" is set to a valid access token
    When the request "createPayment" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "CARRIER_BILLING.AMOUNT_THRESHOLD_OVERPASSED"
    And the response property "$.message" contains a user friendly text

  @create_payment_C02.03_unnecessary_phone_number
  Scenario: Phone number not to be included when it can be deduced from the access token
    Given the header "Authorization" is set to a valid access token identifying a phone number
    And the request body property "$.phoneNumber" is set to a valid phone number
    When the request "createPayment" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @create_payment_C02.04_missing_phone_number
  Scenario: Phone number not included and cannot be deducted from the access token
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is not included
    When the request "createPayment" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MISSING_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  # When the service is only offered to certain type of subscriptions, e.g. IoT, , B2C, etc
  @create_payment_C02.05_phone_number_not_supported
  Scenario: Service not available for the phone number
    Given that the service is not available for all phone numbers commercialized by the operator
    And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
    When the request "createPayment" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user friendly text

  # Error 429 scenarios

  @create_payment_429.01_Too_Many_Requests
  #To test this scenario environment has to be configured to reject requests reaching the threshold limit settled. N is a value defined by the Telco Operator
  Scenario: Request is rejected due to threshold policy
    Given that the environment is configured with a threshold policy of N transactions per second
    And the request body is set to a valid request body
    And the header "Authorization" is set to a valid access token
    And the threshold of requests has been reached
    When the request "createPayment" is sent
    Then the response status code is 429
    And the response property "$.status" is 429
    And the response property "$.code" is "TOO_MANY_REQUESTS"
    And the response property "$.message" contains a user friendly text

  ##############################
  ##END
  ##############################