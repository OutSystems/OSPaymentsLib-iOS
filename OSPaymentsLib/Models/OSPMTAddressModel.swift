struct OSPMTAddressModel: Codable, Equatable {
    let postalCode: String
    let fullAddress: String
    let countryCode: String
    let city: String
    let administrativeArea: String?
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case postalCode, fullAddress, countryCode, city, administrativeArea, state
    }
    
    init(postalCode: String, fullAddress: String, countryCode: String, city: String, administrativeArea: String? = nil, state: String? = nil) {
        self.postalCode = postalCode
        self.fullAddress = fullAddress
        self.countryCode = countryCode
        self.city = city
        self.administrativeArea = administrativeArea
        self.state = state
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let postalCode = try container.decode(String.self, forKey: .postalCode)
        let fullAddress = try container.decode(String.self, forKey: .fullAddress)
        let countryCode = try container.decode(String.self, forKey: .countryCode)
        let city = try container.decode(String.self, forKey: .city)
        let administrativeArea = try container.decodeIfPresent(String.self, forKey: .administrativeArea)
        let state = try container.decodeIfPresent(String.self, forKey: .state)
        self.init(
            postalCode: postalCode,
            fullAddress: fullAddress,
            countryCode: countryCode,
            city: city,
            administrativeArea: administrativeArea,
            state: state
        )
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postalCode, forKey: .postalCode)
        try container.encode(fullAddress, forKey: .fullAddress)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(city, forKey: .city)
        try container.encodeIfPresent(administrativeArea, forKey: .administrativeArea)
        try container.encodeIfPresent(state, forKey: .state)
    }
}
