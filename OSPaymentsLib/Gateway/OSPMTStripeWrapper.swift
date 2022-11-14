import PassKit
import StripePayments

class OSPMTStripeWrapper: OSPMTGatewayDelegate {
    init() {
        StripeAPI.defaultPublishableKey = "pk_test_51KvKHLI1WLTTyI34CsVnUY8UoKGVpeklyySXSMhucxD2fViPCE7kW7KUqZoULMtqav1h2kkaESWeQCAqXLKnszEq00mFN2SGup"
    }
    
    func process(_ payment: PKPayment, with details: OSPMTDetailsModel, _ completion: @escaping (Result<String, OSPMTError>) -> Void) {
        STPAPIClient.shared.createPaymentMethod(with: payment) { paymentMethod, error in
            if error == nil, let paymentMethod = paymentMethod {
                let body: [String: Any] = [
                    "amount": details.paymentAmount.multiplying(by: 100).intValue,
                    "currency": details.currency,
                    "payment_method": paymentMethod.stripeId
                ]
                
                self.processURLRequest(for: .stripe, and: body, completion)
            } else {
                completion(.failure(.stripePaymentMethodCreation))
            }
        }
    }
}
