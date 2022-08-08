struct OSPMTTokenInfoModel: Codable, Equatable {
    let token: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case token, type
    }
    
    init(token: String, type: String) {
        self.token = token
        self.type = type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let token = try container.decode(String.self, forKey: .token)
        let type = try container.decode(String.self, forKey: .type)
        self.init(token: token, type: type)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(token, forKey: .token)
        try container.encode(type, forKey: .type)
    }
}
