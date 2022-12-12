/// Payment Service Provider enum object
enum OSPMTGateway: String {
    case stripe = "Stripe"
}

extension OSPMTGateway {
    
    /// Converts a string into a `OSPMTGateway` object.
    /// - Parameter text: Text to convert.
    /// - Returns: A `OSPMTGateway` enum object if successful. `nil` is returned in case of error.
    static func convert(from text: String) -> OSPMTGateway? {
        return text.lowercased() == "stripe" ? .stripe : nil
    }
}
