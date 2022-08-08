class OSPMTPayments: NSObject {
    private let delegate: OSPMTCallbackDelegate
    private let handler: OSPMTHandlerDelegate
    
    init(delegate: OSPMTCallbackDelegate, handler: OSPMTHandlerDelegate) {
        self.delegate = delegate
        self.handler = handler
    }
    
    convenience init(applePayWithDelegate delegate: OSPMTCallbackDelegate, andConfiguration configurationSource: OSPMTConfiguration =  Bundle.main.infoDictionary!) {
        let applePayHandler = OSPMTApplePayHandler(configurationSource: configurationSource)
        self.init(delegate: delegate, handler: applePayHandler)
    }
}

// MARK: - Action Methods to be called by Bridge
extension OSPMTPayments: OSPMTActionDelegate {
    func setupConfiguration() {
        let result = self.handler.setupConfiguration()
        
        switch result {
        case .success(let message):
            self.delegate.callback(result: message)
        case .failure(let error):
            self.delegate.callback(error: error)
        }
    }
    
    func checkWalletSetup() {
        if let error = self.handler.checkWalletAvailability() {
            self.delegate.callback(error: error)
        } else {
            self.delegate.callbackSuccess()
        }
    }
    
    func set(_ details: String) {
        let detailsResult = self.decode(details)
        switch detailsResult {
        case .success(let detailsModel):
            self.handler.set(detailsModel) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let scopeModel):
                    let scopeResult = self.encode(scopeModel)
                    switch scopeResult {
                    case .success(let scopeText):
                        self.delegate.callback(result: scopeText)
                    case .failure(let error):
                        self.delegate.callback(error: error)
                    }
                case .failure(let error):
                    self.delegate.callback(error: error)
                }
            }
        case .failure(let error):
            self.delegate.callback(error: error)
        }
    }
}

extension OSPMTPayments {
    func decode(_ detailsText: String) -> Result<OSPMTDetailsModel, OSPMTError> {
        guard
            let detailsData = detailsText.data(using: .utf8),
            let detailsModel = try? JSONDecoder().decode(OSPMTDetailsModel.self, from: detailsData)
        else { return .failure(.invalidDecodeDetails) }
        return .success(detailsModel)
    }
    
    func encode(_ scopeModel: OSPMTScopeModel) -> Result<String, OSPMTError> {
        guard let scopeData = try? JSONEncoder().encode(scopeModel), let scopeText = String(data: scopeData, encoding: .utf8)
        else { return .failure(.invalidEncodeScope) }
        return .success(scopeText)
    }
}
