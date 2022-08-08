struct OSPMTDataModel: Codable {
    let billingInfo: OSPMTContactInfoModel
    let cardDetails: String
    let cardNetwork: String
    let tokenData: OSPMTTokenInfoModel
    
    enum CodingKeys: String, CodingKey {
        case billingInfo, cardDetails, cardNetwork, tokenData
    }
    
    init(billingInfo: OSPMTContactInfoModel, cardDetails: String, cardNetwork: String, tokenData: OSPMTTokenInfoModel) {
        self.billingInfo = billingInfo
        self.cardDetails = cardDetails
        self.cardNetwork = cardNetwork
        self.tokenData = tokenData
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let billingInfo = try container.decode(OSPMTContactInfoModel.self, forKey: .billingInfo)
        let cardDetails = try container.decode(String.self, forKey: .cardDetails)
        let cardNetwork = try container.decode(String.self, forKey: .cardNetwork)
        let tokenData = try container.decode(OSPMTTokenInfoModel.self, forKey: .tokenData)
        self.init(billingInfo: billingInfo, cardDetails: cardDetails, cardNetwork: cardNetwork, tokenData: tokenData)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(billingInfo, forKey: .billingInfo)
        try container.encode(cardDetails, forKey: .cardDetails)
        try container.encode(cardNetwork, forKey: .cardNetwork)
        try container.encode(tokenData, forKey: .tokenData)
    }
}

extension OSPMTDataModel: Equatable {
    static func == (lhs: OSPMTDataModel, rhs: OSPMTDataModel) -> Bool {
        lhs.billingInfo == rhs.billingInfo
        && lhs.cardDetails == rhs.cardDetails
        && lhs.cardNetwork == rhs.cardNetwork
        && lhs.tokenData == rhs.tokenData
    }
}
