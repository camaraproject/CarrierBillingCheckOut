Feature: CAMARA Carrier Billing Refund API, v0.3.0 - Operation createRefund
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * Telco Operator carrier billing refund behaviour mode: sync or async
  #
  # Testing assets:
  # * A phone number eligible for payment & refund (no restrictions for it to be used to perform a payment or refund)
  # * A phone number not-eligible for refund (refund is denied for it due to business conditions)
  #
  # References to OAS spec schemas refer to schemas specifies in carrier-billing-refund.yaml

  Background: Common createRefund setup
    Given the resource "/carrier-billing-refund/v0.3/refunds"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the path parameter "paymentId" is set to a valid refund-eligible payment value
    And the request body is set by default to a request body compliant with the schema

  ##############################
  # Happy path scenarios
  ##############################

  @create_refund_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    # Valid default request body compliant with the schema
    # Property "$.amountTransaction" is set with required information only
    # Property "$.type" is set with a valid value
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.type" is set with a valid value
    And the request body is set to a valid request body
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/Refund"

  @create_refund_02_generic_success_scenario_with_sink_information
  Scenario: Common validations for any success scenario with sink information provided
    # Property "$.amountTransaction" is set with required information only
    # Property "$.type" is set with a valid value
    # Property "$.sink" is set with a valid public accessible HTTPs endpoint
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.type" is set with a valid value
    And the request body property "$.sink" is set with a valid URL
    And the request body is set to a valid request body
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/Refund"

  @create_refund_03_generic_success_scenario_with_sink_and_sinkCredential_information
  Scenario: Common validations for any success scenario sink and sinkCredential information provided
    # Property "$.amountTransaction" is set with required information only
    # Property "$.type" is set with a valid value
    # Property "$.sink" is set with a valid public accessible HTTPs endpoint
    # Property "$.sinkCredential" is set with a valid credential of type "ACCESSTOKEN"
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.type" is set with a valid value
    And the request body property "$.sink" is set with a valid HTTPS URL
    And the request body property "$.sinkCredential" is set to a valid credential with property "$.sinkCredential.credentialType" set to "ACCESSTOKEN"
    And the request body is set to a valid request body
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    # The response has to comply with the generic response schema which is part of the spec
    And the response body complies with the OAS schema at "/components/schemas/Refund"

  # Scenarios testing specific situations for amountTransaction

  @create_refund_04_total_refund
  Scenario: Request total refund
    Given the request body property "$.type" is set to "total"
    And the request body property"$.amountTransaction" is set with valid required information for this refund type
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Refund"
    And the response body property "$.type" is set "total"
    And the response body property "$.amountTransaction.refundAmount" is "{}"

  @create_refund_04_partial_refund_amountTransaction_gross_amount
  Scenario: Request partial refund with gross amount
    Given the request body property "$.type" is set to "partial"
    And the request body property "$.amountTransaction" is set with valid required information for this refund type
    And the request body property "$.amountTransaction.refundAmount.chargingInformation.isTaxIncluded" is set to true
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Refund"
    And the response body property "$.amountTransaction.refundAmount.chargingInformation.isTaxIncluded" is true

  @create_refund_05_partial_refund_amountTransaction_net_amount
  Scenario: Request partial refund with net amount
    Given the request body property "$.type" is set to "partial"
    And the request body property "$.amountTransaction" is set with valid required information for this refund type
    And the request body property "$.amountTransaction.refundAmount.chargingInformation.isTaxIncluded" is set to false OR not set
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Refund"
    And the response body property "$.amountTransaction.refundAmount.chargingInformation.isTaxIncluded" is false OR not returned

  @create_refund_06_partial_refund_amountTransaction_taxAmount
  Scenario: Request partial refund indicating taxAmount
    Given the request body property "$.type" is set to "partial"
    And the request body property "$.amountTransaction" is set with valid required information for this refund type
    And the request body property "$.amountTransaction.refundAmount.chargingInformation.taxAmount" is set to a valid value
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Refund"
    And the response body property "$.amountTransaction.refundAmount.chargingInformation.taxAmount" has the same value as provided in the request body

  @create_refund_07_amountTransaction_merchantIdentifier
  # May be relevant scenario for Payment Aggregator Case
  Scenario: Request refund indicating merchantIdentifier
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.type" is set with a valid value
    And the request body property "$.amountTransaction.refundAmount.chargingMetaData.merchantIdentifier" is set to a valid value
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Refund"
    And the response body property "$.amountTransaction.refundAmount.chargingMetaData.merchantIdentifier" has the same value as provided in the request body

  @create_refund_08_partial_refund_amountTransaction_refundDetails
  Scenario: Request partial refund indicating indicating refundDetails
    Given the request body property "$.type" is set to "partial"
    And the request body property "$.amountTransaction" is set with valid required information for this refund type
    And the request body array property "$.amountTransaction.refundAmount.refundDetails" is set with valid information
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Refund"
    And the response body array property "$.amountTransaction.refundAmount.refundDetails" has the same information as provided in the request body

  @create_refund_09_amountTransaction_clientCorrelator
  # Recommended scenario to manage request idempotency
  Scenario: Request refund indicating clientCorrelator
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.type" is set with a valid value
    And the request body property "$.amountTransaction.clientCorrelator" is set to a valid value
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Refund"
    And the response body property "$.amountTransaction.clientCorrelator" has the same value as provided in the request body

  @create_refund_10_reason
  Scenario: Request refund indicating reason
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.type" is set with a valid value
    And the request body property "$.reason" is set to a valid value
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Refund"
    And the response body property "$.reason" has the same value as provided in the request body

  @create_refund_11_sync_behaviour
  # Scenario for a Telco Operator that behaves synchronously
  Scenario: Request refund with sync behaviour
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.type" is set with a valid value
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Refund"
    And the response body property "$.refundStatus" is "succeeded"

  @create_refund_12_async_behaviour
  # Scenario for a Telco Operator that behaves asynchronously
  Scenario: Request refund with async behaviour
    Given the request body property "$.amountTransaction" is set with valid required information
    And the request body property "$.type" is set with a valid value
    When the request "createRefund" is sent
    Then the response status code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Refund"
    And the response body property "$.refundStatus" is "processing"

  ##############################
  # Error scenarios
  ##############################

  # Error 400 scenarios

  @create_refund_400.01_no_request_body
  Scenario: Missing request body
    Given the request body is not included
    When the request "createRefund" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @create_refund_400.02_empty_request_body
  Scenario: Empty object as request body
    Given the request body is set to "{}"
    When the request "createRefund" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @create_refund_400.03_other_input_properties_schema_not_compliant
  # Test other input properties in addition to amountTransaction
  Scenario Outline: Input property values does not comply with the schema
    Given the request body property "<input_property>" does not comply with the OAS schema at <oas_spec_schema>
    When the request "createRefund" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | input_property          | oas_spec_schema                    |
      | $.sink                  | /components/schemas/CreateRefund   |
      | $.sinkCredential        | /components/schemas/SinkCredential |

  @create_refund_400.04_required_input_properties_missing
  Scenario Outline: Required input properties are missing
    Given the request body property "<input_property>" is not included
    When the request "createRefund" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | input_property                                                    |
      | $.type                                                            |
      | $.amountTransaction                                               |
      | $.amountTransaction.refundAmount                                  |
      | $.amountTransaction.referenceCode                                 |

  @create_refund_400.05_clientCorrelator_in_use
  Scenario: Using the same client correlator for two different refund requests
    Given the request body property includes property "$.amountTransaction.clientCorrelator" with a value already use in a non-completed refund
    When the request "createRefund" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @create_refund_400.06_invalid_sink
  Scenario: Using a invalid sink value
    Given the request body property includes property "$.sink" with an HTTP endpoint
    When the request "createRefund" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_SINK"
    And the response property "$.message" contains a user friendly text

  @create_refund_400.07_invalid_sinkCredential
  Scenario: Using a invalid sinkCredential type value
    Given the request body property includes property "$.sinkCredential.credentialType" whose value is not "ACCESSTOKEN"
    When the request "createRefund" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text

  @create_refund_400.08_invalid_sinkCredential_Acccestoken
  Scenario: Using a invalid sinkCredential accesstoken type value
    Given the request body property includes property "$.sinkCredential.accessTokenType" whose value is not "bearer"
    When the request "createRefund" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN"
    And the response property "$.message" contains a user friendly text

  @create_refund_400.09_invalid_x-correlator
  Scenario: Invalid x-correlator header
    Given the header "x-correlator" does not comply with the schema at "#/components/schemas/XCorrelator"
    And the request body is set to a valid request body
    When the request "createRefund" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"

  # Error 401 scenarios

  @create_refund_401.01_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the request "createRefund" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @create_refund_401.02_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the request "createRefund" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @create_refund_401.03_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the request "createRefund" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Error 403 scenarios

  @create_refund_403.01_invalid_token_permissions
  Scenario: Inconsistent access token permissions
    # To test this scenario, it will be necessary to obtain a token without the required scope
    Given the request body is set to a valid request body
    And the header "Authorization" is set to an access token without the required scope
    When the request "createRefund" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @create_refund_403.02_refund_denied
  Scenario: Refund denied by business
    # To test this, a business context exists in the Telco Operator to deny the refund
    Given the request body is set to a valid request body
    And the header "Authorization" is set to a valid access token
    When the request "createRefund" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "CARRIER_BILLING_REFUND.REFUND_DENIED"
    And the response property "$.message" contains a user friendly text

  @create_refund_403.03_payment_not_eligible_for_refund
  Scenario: Payment not eligible for refund
    # To test this, a business context exists in the Telco Operator to not consider the payment eligible for the refund
    Given the request body is set to a valid request body
    And the header "Authorization" is set to a valid access token
    When the request "createRefund" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "CARRIER_BILLING_REFUND.PAYMENT_NOT_ELIGIBLE_FOR_REFUND"
    And the response property "$.message" contains a user friendly text

  # Error 404 scenarios

  @create_refund_404.01_payment_not_found
  Scenario: Payment not found
    Given the header "Authorization" is set to a valid access token
    And the path parameter "paymentId" is compliant with the schema but does not identify a valid payment in the environment
    And the request body is set to a valid request body
    When the request "createRefund" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  # Error 409 scenarios

  @create_refund_409.01_refund_duplicated
  Scenario: Refund duplicated
    Given the request body is set to a valid request body
    And the request body property "$.amountTransaction.referenceCode" is set to a value already use in another refund request
    And the request body property "$.amountTransaction.clientCorrelator" is missing
    And the header "Authorization" is set to a valid access token
    When the request "createRefund" is sent
    Then the response status code is 409
    And the response property "$.status" is 409
    And the response property "$.code" is "ALREADY_EXISTS"
    And the response property "$.message" contains a user friendly text

  # Error 422 scenarios

  @create_refund_422.01_unauthorized_amount
  Scenario: Refund amount exceeds the related payment amount OR exceeds the value allowed by the regulation if any
    # This test may apply/depend on the regulation applicable for a given Country
    Given the request body is set to a valid request body
    And the request body property "$.type" is set to "partial"
    And the request body property "$.amountTransaction.refundAmount.chargingInformation.amount" exceeds the value of the related payment OR exceeds the value allowed by the regulation
    And the header "Authorization" is set to a valid access token
    When the request "createRefund" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "CARRIER_BILLING_REFUND.UNAUTHORIZED_AMOUNT"
    And the response property "$.message" contains a user friendly text

  @create_refund_422.02_accumulated_threshold_amount_overpassed
  Scenario: Refund amount exceeds the accumulated threshold amount value allowed by the regulation
    # This test applies/depends on the regulation applicable for a given Country
    Given the request body is set to a valid request body
    And the request body property "$.type" is set to "partial"
    And the request body property "$.amountTransaction.refundAmount.chargingInformation.amount" exceeds the accumulated threshold amount value allowed by the regulation for refunds
    And the header "Authorization" is set to a valid access token
    When the request "createRefund" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "CARRIER_BILLING_REFUND.AMOUNT_THRESHOLD_OVERPASSED"
    And the response property "$.message" contains a user friendly text

  @create_refund_422.03_payment_invalid_status
  Scenario: Refund for a Payment in an invalid status
    Given the request body is set to a valid request body
    And the path parameter "paymentId" is set to a valid value of a payment whose "paymentStatus" != "succeeded"
    And the header "Authorization" is set to a valid access token
    When the request "createRefund" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "CARRIER_BILLING_REFUND.INVALID_PAYMENT_STATUS"
    And the response property "$.message" contains a user friendly text

  @create_refund_422.04_inconsistent_tax_management
  Scenario: Request refund with inconsistent "isTaxIncluded"
    Given the request body is set to a valid request body
    And the request body property "$.type" is set to "partial"
    And the request body property "$.amountTransaction.refundAmount.chargingInformation.isTaxIncluded" is different than the value used for related payment
    And the header "Authorization" is set to a valid access token
    When the request "createRefund" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "CARRIER_BILLING_REFUND.TAXES_MANAGEMENT_MISMATCH"
    And the response property "$.message" contains a user friendly text

  @create_refund_422.05_inconsistent_refund_details
  Scenario: Request refund with inconsistent "refundDetails"
    Given the request body is set to a valid request body
    And the request body property "$.type" is set to "partial"
    And the request body property "$.amountTransaction.refundAmount.refundDetails" is not consistent with the value of "paymentDetails" used for related payment
    And the header "Authorization" is set to a valid access token
    When the request "createRefund" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "CARRIER_BILLING_REFUND.REFUND_DETAILS_MISMATCH"
    And the response property "$.message" contains a user friendly text

  # Error 429 scenarios

  @create_refund_429.01_Too_Many_Requests
  #To test this scenario environment has to be configured to reject requests reaching the threshold limit settled. N is a value defined by the Telco Operator
  Scenario: Request is rejected due to threshold policy
    Given that the environment is configured with a threshold policy of N transactions per second
    And the request body is set to a valid request body
    And the header "Authorization" is set to a valid access token
    And the threshold of requests has been reached
    When the request "createRefund" is sent
    Then the response status code is 429
    And the response property "$.status" is 429
    And the response property "$.code" is "TOO_MANY_REQUESTS"
    And the response property "$.message" contains a user friendly text

  ##############################
  ##END
  ##############################