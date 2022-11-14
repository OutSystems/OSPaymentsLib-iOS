enum OSPMTGateway: String {
    case stripe = "Stripe"
    case adyen = "Adyen"
}

extension OSPMTGateway {
    static func convert(from text: String) -> OSPMTGateway? {
        switch text.lowercased() {
        case "stripe":
            return .stripe
        case "adyen":
            return .adyen
        default:
            return nil
        }
    }
}
