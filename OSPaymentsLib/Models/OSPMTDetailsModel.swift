import PassKit

enum OSPMTStatus: String, Codable {
    case final
    case pending
}

struct OSPMTDetailsModel: Codable {
    let amount: Decimal
    let currency: String
    let status: OSPMTStatus
    let shippingContactArray: [String]?
    let billingContactArray: [String]?
    
    enum CodingKeys: String, CodingKey {
        case amount
        case currency
        case status
        case shippingContactArray = "shippingContacts"
        case billingContactArray = "billingContacts"
    }
    
    init(amount: Decimal, currency: String, status: OSPMTStatus, shippingContactArray: [String]? = nil, billingContactArray: [String]? = nil) {
        self.amount = amount
        self.currency = currency
        self.status = status
        self.shippingContactArray = shippingContactArray
        self.billingContactArray = billingContactArray
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let amount = try container.decode(Decimal.self, forKey: .amount)
        let currency = try container.decode(String.self, forKey: .currency)
        let status = try container.decode(OSPMTStatus.self, forKey: .status)
        let shippingContactArray = try container.decodeIfPresent([String].self, forKey: .shippingContactArray)
        let billingContactArray = try container.decodeIfPresent([String].self, forKey: .billingContactArray)
        self.init(
            amount: amount, currency: currency, status: status, shippingContactArray: shippingContactArray, billingContactArray: billingContactArray
        )
    }
}

// MARK: Apple Pay extension
extension OSPMTDetailsModel {
    var paymentAmount: NSDecimalNumber {
        NSDecimalNumber(decimal: self.amount)
    }
    
    var paymentSummaryItemType: PKPaymentSummaryItemType {
        self.status == .pending ? .pending : .final
    }
}
