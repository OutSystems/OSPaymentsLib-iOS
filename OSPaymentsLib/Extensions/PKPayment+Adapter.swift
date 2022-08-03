import PassKit

extension PKPayment {
    func createScopeModel() -> OSPMTScopeModel? {
        var result: [String: Any] = [OSPMTScopeModel.CodingKeys.paymentData.rawValue: self.createTokenDataData()]
        if let shippingContact = self.shippingContact {
            result[OSPMTScopeModel.CodingKeys.shippingInfo.rawValue] = self.createContactInfoData(for: shippingContact)
        }
        
        guard
            let scopeData = try? JSONSerialization.data(withJSONObject: result),
            let scopeModel = try? JSONDecoder().decode(OSPMTScopeModel.self, from: scopeData)
        else { return nil }
        return scopeModel
    }
    
    func createTokenDataData() -> [String: Any] {
        var result: [String: Any] = [
            OSPMTDataModel.CodingKeys.tokenData.rawValue: self.createTokenData(for: self.token.paymentData)
        ]
        if let billingContact = self.billingContact {
            result[OSPMTDataModel.CodingKeys.billingInfo.rawValue] = self.createContactInfoData(for: billingContact)
        }
        if let paymentMethodName = self.token.paymentMethod.displayName {
            let cardInfo = paymentMethodName.components(separatedBy: " ")
            if let cardNetwork = cardInfo.first, let cardDetails = cardInfo.last {
                result[OSPMTDataModel.CodingKeys.cardDetails.rawValue] = cardDetails
                result[OSPMTDataModel.CodingKeys.cardNetwork.rawValue] = cardNetwork
            }
        }
        
        return result
    }
    
    func createTokenData(for paymentData: Data) -> [String: String] {
        var result = [OSPMTTokenInfoModel.CodingKeys.type.rawValue: "Payment Service Provider Name"]
        
        if let token = String(data: paymentData, encoding: .utf8) {
            result[OSPMTTokenInfoModel.CodingKeys.token.rawValue] = token
        }
        
        return result
    }
    
    func createContactInfoData(for contact: PKContact) -> [String: Any] {
        var result = [String: Any]()
        if let address = contact.postalAddress {
            result[OSPMTContactInfoModel.CodingKeys.address.rawValue] = self.createAddressData(for: address)
        }
        if let phoneNumber = contact.phoneNumber {
            result[OSPMTContactInfoModel.CodingKeys.phoneNumber.rawValue] = phoneNumber.stringValue
        }
        if let name = contact.name, let givenName = name.givenName, let familyName = name.familyName {
            result[OSPMTContactInfoModel.CodingKeys.name.rawValue] = "\(givenName) \(familyName)"
        }
        if let email = contact.emailAddress {
            result[OSPMTContactInfoModel.CodingKeys.email.rawValue] = email
        }
        
        return result
    }
    
    func createAddressData(for postalAddress: CNPostalAddress) -> [String: String] {
        var result = [
            OSPMTAddressModel.CodingKeys.postalCode.rawValue: postalAddress.postalCode,
            OSPMTAddressModel.CodingKeys.fullAddress.rawValue: postalAddress.street,
            OSPMTAddressModel.CodingKeys.countryCode.rawValue: postalAddress.isoCountryCode,
            OSPMTAddressModel.CodingKeys.city.rawValue: postalAddress.city
        ]
        if !postalAddress.subAdministrativeArea.isEmpty {
            result[OSPMTAddressModel.CodingKeys.administrativeArea.rawValue] = postalAddress.subAdministrativeArea
        }
        if !postalAddress.state.isEmpty {
            result[OSPMTAddressModel.CodingKeys.state.rawValue] = postalAddress.state
        }
        
        return result
    }
}
