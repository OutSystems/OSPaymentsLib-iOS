@testable import OSPaymentsLib
import PassKit

struct OSPMTTestConfigurations {
    // MARK: - General Configurations
    static let dummyString = "Dummy"
    
    // MARK: - OSPMTApplePayHandlerSpec Configurations
    static let fullConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: [Self.dummyString, Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: [Self.dummyString, Self.dummyString]
    ]
    
    static let noMerchantNameConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: [Self.dummyString, Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: [Self.dummyString, Self.dummyString]
    ]
    
    // MARK: - OSPMTApplePayConfigurationSpec Configurations
    static let networkVisa = "VISA"
    static let networkMasterCard = "MasterCard"
    static let capability3DS = "3DS"
    static let capabilityEMV = "emv"
    
    static let validNetworkCapabilityConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.networkVisa, Self.networkMasterCard],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.capability3DS, Self.capabilityEMV],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString]
    ]
    
    static let validNetworkCapabilityWithErrorConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.networkVisa, Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.capability3DS, Self.dummyString]
    ]
    
    static let invalidNetworkCapabilityConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: Self.dummyString
    ]
    
    static let emptyNetworkCapabilityConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: []
    ]
    
    static let nilNetworkCapabilityConfig: OSPMTConfiguration = [:]
    
    // MARK: - OSPMTApplePayRequestBehaviourSpec Configurations
    static let dummyContact = OSPMTContact(isCustom: true, contactArray: [Self.dummyString])
    static let dummyDetailsModel = OSPMTDetailsModel(
        amount: 1, currency: Self.dummyString, status: .final, shippingContact: dummyContact, billingContact: dummyContact
    )
    static let dummyAddressModel = OSPMTAddressModel(
        postalCode: Self.dummyString, fullAddress: Self.dummyString, countryCode: Self.dummyString, city: Self.dummyString
    )
    static let dummyContactInfoModel = OSPMTContactInfoModel()
    static let dummyTokenInfoModel = OSPMTTokenInfoModel(token: Self.dummyString, type: Self.dummyString)
    static let dummyDataModel = OSPMTDataModel(
        billingInfo: Self.dummyContactInfoModel, cardDetails: Self.dummyString, cardNetwork: Self.dummyString, tokenData: Self.dummyTokenInfoModel
    )
    static let dummyScopeModel = OSPMTScopeModel(paymentData: Self.dummyDataModel, shippingInfo: Self.dummyContactInfoModel)
    
    static let emptyContactFieldArray = [String]()
    static let invalidContactFieldArray = [Self.dummyString]
    static let withInvalidContactFieldArray = [Self.dummyString, PKContactField.name.rawValue.lowercased()]
    static let validContactFieldArray = [PKContactField.phoneNumber.rawValue.lowercased(), PKContactField.name.rawValue.lowercased()]
    
    // MARK: - OSPMTPaymentSpec Configurations
    static let validDetailModel: [String: Any] = [
        OSPMTDetailsModel.CodingKeys.amount.rawValue: 1,
        OSPMTDetailsModel.CodingKeys.currency.rawValue: Self.dummyString,
        OSPMTDetailsModel.CodingKeys.status.rawValue: OSPMTStatus.final.rawValue,
        OSPMTDetailsModel.CodingKeys.billingContact.rawValue: [
            OSPMTContact.CodingKeys.isCustom.rawValue: true,
            OSPMTContact.CodingKeys.contactArray.rawValue: [Self.dummyString]
        ],
        OSPMTDetailsModel.CodingKeys.shippingContact.rawValue: [
            OSPMTContact.CodingKeys.isCustom.rawValue: true,
            OSPMTContact.CodingKeys.contactArray.rawValue: [Self.dummyString]
        ]
    ]
    
    static let invalidStatusDetailModel: [String: Any] = [
        OSPMTDetailsModel.CodingKeys.amount.rawValue: 1,
        OSPMTDetailsModel.CodingKeys.currency.rawValue: Self.dummyString,
        OSPMTDetailsModel.CodingKeys.status.rawValue: Self.dummyString,
        OSPMTDetailsModel.CodingKeys.billingContact.rawValue: [
            OSPMTContact.CodingKeys.isCustom.rawValue: true,
            OSPMTContact.CodingKeys.contactArray.rawValue: [Self.dummyString]
        ],
        OSPMTDetailsModel.CodingKeys.shippingContact.rawValue: [
            OSPMTContact.CodingKeys.isCustom.rawValue: true,
            OSPMTContact.CodingKeys.contactArray.rawValue: [Self.dummyString]
        ]
    ]
    
    static let useConfigBillingContactDetailModel: [String: Any] = [
        OSPMTDetailsModel.CodingKeys.amount.rawValue: 1,
        OSPMTDetailsModel.CodingKeys.currency.rawValue: Self.dummyString,
        OSPMTDetailsModel.CodingKeys.status.rawValue: OSPMTStatus.final.rawValue,
        OSPMTDetailsModel.CodingKeys.billingContact.rawValue: [
            OSPMTContact.CodingKeys.isCustom.rawValue: false
        ],
        OSPMTDetailsModel.CodingKeys.shippingContact.rawValue: [
            OSPMTContact.CodingKeys.isCustom.rawValue: true,
            OSPMTContact.CodingKeys.contactArray.rawValue: [Self.dummyString]
        ]
    ]
    
    static let useConfigurationBillingContactInfoModel = OSPMTContactInfoModel(name: Self.dummyString)
    static let useConfigurationBillingScopeModel = OSPMTScopeModel(
        paymentData: Self.dummyDataModel, shippingInfo: Self.useConfigurationBillingContactInfoModel
    )
    
    // MARK: - ModelSpec Methods
    static func decode<T: Decodable>(for type: T.Type, _ dictionary: [String: Any]) -> T? {
        guard
            let data = try? JSONSerialization.data(withJSONObject: dictionary),
            let model = try? JSONDecoder().decode(type, from: data)
        else { return nil }
        return model
    }
    
    static func encode<T: Encodable>(_ model: T) -> String? {
        guard let data = try? JSONEncoder().encode(model), let result = String(data: data, encoding: .utf8) else { return nil }
        return result
    }
}
