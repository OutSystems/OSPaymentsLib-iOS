class OSPMTApplePayHandler: NSObject {
    let configuration: OSPMTConfigurationDelegate
    let availabilityBehaviour: OSPMTAvailabilityDelegate
    let requestBehaviour: OSPMTRequestDelegate
    
    init(configuration: OSPMTConfigurationDelegate, availabilityBehaviour: OSPMTAvailabilityDelegate, requestBehaviour: OSPMTRequestDelegate) {
        self.configuration = configuration
        self.availabilityBehaviour = availabilityBehaviour
        self.requestBehaviour = requestBehaviour
        super.init()
    }
    
    convenience init(configurationSource: OSPMTConfiguration = Bundle.main.infoDictionary!) {
        let applePayConfiguration = OSPMTApplePayConfiguration(source: configurationSource)
        let applePayAvailabilityBehaviour = OSPMTApplePayAvailabilityBehaviour(configuration: applePayConfiguration)
        let applePayRequestBehaviour = OSPMTApplePayRequestBehaviour(configuration: applePayConfiguration)
        self.init(
            configuration: applePayConfiguration, availabilityBehaviour: applePayAvailabilityBehaviour, requestBehaviour: applePayRequestBehaviour
        )
    }
}

// MARK: - OSPMTHandlerProtocol Methods
extension OSPMTApplePayHandler: OSPMTHandlerDelegate {
    func setupConfiguration() -> Result<String, OSPMTError> {
        !self.configuration.description.isEmpty ? .success(self.configuration.description) : .failure(.invalidConfiguration)
    }
    
    func checkWalletAvailability() -> OSPMTError? {
        self.availabilityBehaviour.checkWallet() ?? self.availabilityBehaviour.checkPayment() ?? self.availabilityBehaviour.checkPaymentSetup()
    }
    
    func set(_ detailsModel: OSPMTDetailsModel, completion: @escaping OSPMTCompletionHandler) {
        self.requestBehaviour.trigger(with: detailsModel, completion)
    }
}
