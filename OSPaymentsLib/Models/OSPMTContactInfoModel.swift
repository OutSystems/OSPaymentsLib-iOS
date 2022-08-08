struct OSPMTContactInfoModel: Codable {
    let address: OSPMTAddressModel?
    let phoneNumber: String?
    let name: String?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case address, phoneNumber, name, email
    }
    
    init(address: OSPMTAddressModel? = nil, phoneNumber: String? = nil, name: String? = nil, email: String? = nil) {
        self.address = address
        self.phoneNumber = phoneNumber
        self.name = name
        self.email = email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let address = try container.decodeIfPresent(OSPMTAddressModel.self, forKey: .address)
        let phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
        let email = try container.decodeIfPresent(String.self, forKey: .email)
        self.init(address: address, phoneNumber: phoneNumber, name: name, email: email)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(phoneNumber, forKey: .phoneNumber)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(email, forKey: .email)
    }
}

extension OSPMTContactInfoModel: Equatable {
    static func == (lhs: OSPMTContactInfoModel, rhs: OSPMTContactInfoModel) -> Bool {
        lhs.address == rhs.address && lhs.phoneNumber == rhs.phoneNumber && lhs.name == rhs.name && lhs.email == rhs.email
    }
}
