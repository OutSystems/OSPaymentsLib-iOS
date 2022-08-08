import PassKit

struct OSPMTScopeModel: Codable {
    let paymentData: OSPMTDataModel
    let shippingInfo: OSPMTContactInfoModel
    
    enum CodingKeys: String, CodingKey {
        case paymentData, shippingInfo
    }
    
    init(paymentData: OSPMTDataModel, shippingInfo: OSPMTContactInfoModel) {
        self.paymentData = paymentData
        self.shippingInfo = shippingInfo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let paymentData = try container.decode(OSPMTDataModel.self, forKey: .paymentData)
        let shippingInfo = try container.decode(OSPMTContactInfoModel.self, forKey: .shippingInfo)
        self.init(paymentData: paymentData, shippingInfo: shippingInfo)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(paymentData, forKey: .paymentData)
        try container.encode(shippingInfo, forKey: .shippingInfo)
    }
}

extension OSPMTScopeModel: Equatable {
    static func == (lhs: OSPMTScopeModel, rhs: OSPMTScopeModel) -> Bool {
        lhs.paymentData == rhs.paymentData && lhs.shippingInfo == rhs.shippingInfo        
    }
}
