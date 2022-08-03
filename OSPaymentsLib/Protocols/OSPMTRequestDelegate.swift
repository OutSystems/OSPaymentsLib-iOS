import PassKit

typealias OSPMTRequestTriggerCompletion = ((Bool) -> Void)

protocol OSPMTRequestTriggerDelegate: AnyObject {
    func triggerPayment(_ completion: @escaping OSPMTRequestTriggerCompletion)
}

protocol OSPMTRequestDelegate: AnyObject {
    func trigger(with detailsModel: OSPMTDetailsModel, _ completion: @escaping OSPMTCompletionHandler)
}

protocol OSPMTApplePayRequestTriggerDelegate: OSPMTRequestTriggerDelegate {
    static func createRequestTriggerBehaviour(for detailsModel: OSPMTDetailsModel, andDelegate delegate: OSPMTApplePayRequestBehaviour?) -> Result<OSPMTApplePayRequestTriggerDelegate, OSPMTError>
}

class OSPMTApplePayRequestBehaviour: NSObject, OSPMTRequestDelegate {
    let configuration: OSPMTApplePayConfiguration
    var requestTriggerBehaviour: OSPMTApplePayRequestTriggerDelegate.Type
    
    var paymentStatus: PKPaymentAuthorizationStatus = .failure
    var paymentScope: OSPMTScopeModel?
    var completionHandler: OSPMTCompletionHandler!
    
    init(configuration: OSPMTApplePayConfiguration, requestTriggerBehaviour: OSPMTApplePayRequestTriggerDelegate.Type = PKPaymentAuthorizationController.self) {
        self.configuration = configuration
        self.requestTriggerBehaviour = requestTriggerBehaviour
    }
    
    func trigger(with detailsModel: OSPMTDetailsModel, _ completion: @escaping OSPMTCompletionHandler) {
        self.completionHandler = completion
        
        let result = self.requestTriggerBehaviour.createRequestTriggerBehaviour(for: detailsModel, andDelegate: self)
        switch result {
        case .success(let paymentController):
            paymentController.triggerPayment { [weak self] presented in
                guard let self = self else { return }
                
                self.paymentStatus = .failure
                if !presented {
                    completion(.failure(.paymentTriggerPresentationFailed))
                }
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

extension OSPMTApplePayRequestBehaviour {
    func getPaymentSummaryItems(for detailsModel: OSPMTDetailsModel) -> [PKPaymentSummaryItem]? {
        guard let label = self.configuration.merchantName else { return nil }
        return [PKPaymentSummaryItem(label: label, amount: detailsModel.paymentAmount, type: detailsModel.paymentSummaryItemType)]
    }
    
    func getContactFields(for text: [String]) -> Set<PKContactField> {
        return Set(text.compactMap(PKContactField.convert(from:)))
    }
}

// MARK: - Set up PKPaymentAuthorizationControllerDelegate conformance
extension OSPMTApplePayRequestBehaviour: PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss()
        // The payment sheet doesn't automatically dismiss once it has finished. Dismiss the payment sheet.
        DispatchQueue.main.async {
            if self.paymentStatus == .success, let paymentScope = self.paymentScope {
                self.completionHandler(.success(paymentScope))
            } else {
                self.completionHandler(.failure(.paymentTriggerNotCompleted))
            }
        }
    }
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        if let scopeModel = payment.createScopeModel() {
            self.paymentScope = scopeModel
            self.paymentStatus = .success
        } else {
            self.paymentStatus = .failure
        }
        
        completion(PKPaymentAuthorizationResult(status: self.paymentStatus, errors: []))
    }
}
