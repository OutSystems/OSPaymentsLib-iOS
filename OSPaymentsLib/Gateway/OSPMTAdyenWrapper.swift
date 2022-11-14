import PassKit

class OSPMTAdyenWrapper: OSPMTGatewayDelegate {
    func process(_ payment: PKPayment, with details: OSPMTDetailsModel, _ completion: @escaping (Result<String, OSPMTError>) -> Void) {
        let body: [String: Any] = [
            "amount": details.paymentAmount.multiplying(by: 100).intValue,
            "currency": details.currency,
            "token": payment.token.paymentData.base64EncodedString()
        ]
        
        self.processURLRequest(for: .adyen, and: body, completion)
    }
}
