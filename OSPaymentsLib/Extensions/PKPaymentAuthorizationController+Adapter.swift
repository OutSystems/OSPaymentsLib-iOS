import PassKit

extension PKPaymentAuthorizationController: OSPMTApplePaySetupAvailabilityDelegate {
    static func isPaymentAvailable() -> Bool {
        Self.canMakePayments()
    }
    
    static func isPaymentAvailable(using networks: [PKPaymentNetwork], and merchantCapabilities: PKMerchantCapability) -> Bool {
        Self.canMakePayments(usingNetworks: networks, capabilities: merchantCapabilities)
    }
}

extension PKPaymentAuthorizationController: OSPMTApplePayRequestTriggerDelegate {
    static func createRequestTriggerBehaviour(for detailsModel: OSPMTDetailsModel, andDelegate delegate: OSPMTApplePayRequestBehaviour?) -> Result<OSPMTApplePayRequestTriggerDelegate, OSPMTError> {
        guard
            let delegate = delegate,
            let merchantIdentifier = delegate.configuration.merchantID,
            let countryCode = delegate.configuration.merchantCountryCode,
            let merchantCapabilities = delegate.configuration.merchantCapabilities,
            let paymentSummaryItems = delegate.getPaymentSummaryItems(for: detailsModel),
            let requiredBillingContactFields = detailsModel.billingContactArray ?? delegate.configuration.billingSupportedContacts,
            let requiredShippingContactFields = detailsModel.shippingContactArray ?? delegate.configuration.shippingSupportedContacts,
            let supportedNetworks = delegate.configuration.supportedNetworks
        else { return .failure(.invalidConfiguration) }
        
        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = merchantIdentifier
        paymentRequest.countryCode = countryCode
        paymentRequest.currencyCode = detailsModel.currency
        paymentRequest.merchantCapabilities = merchantCapabilities
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.requiredBillingContactFields = delegate.getContactFields(for: requiredBillingContactFields)
        paymentRequest.requiredShippingContactFields = delegate.getContactFields(for: requiredShippingContactFields)
        paymentRequest.supportedCountries = delegate.configuration.supportedCountries
        paymentRequest.supportedNetworks = supportedNetworks
        
        let paymentAuthorizationController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentAuthorizationController.delegate = delegate
        return .success(paymentAuthorizationController)
    }
    
    func triggerPayment(_ completion: @escaping OSPMTRequestTriggerCompletion) {
        self.present(completion: completion)
    }
}
