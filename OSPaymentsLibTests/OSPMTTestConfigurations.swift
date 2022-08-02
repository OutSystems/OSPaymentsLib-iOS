@testable import OSPaymentsLib

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
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noMerchantIDConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noMerchantNameConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noMerchantCountryCodeConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noPaymentAllowedNetworksConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noPaymentSupportedCapabilitiesConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noPaymentSupportedCardCountriesConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noShippingSupportedContactsConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noBillingSupportedContactsConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    // MARK: - OSPMTApplePayConfigurationSpec Configurations
    static let networkVisa = "VISA"
    static let networkMasterCard = "MasterCard"
    static let capability3DS = "3DS"
    static let capabilityEMV = "emv"
    
    static let validNetworkCapabilityConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.networkVisa, Self.networkMasterCard],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.capability3DS, Self.capabilityEMV]
    ]
    
    static let validNetworkCapabilityWithErrorConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.networkVisa, Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.capability3DS, Self.dummyString]
    ]
    
    static let invalidNetworkCapabilityConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: Self.dummyString
    ]
    
    static let emptyNetworkCapabilityConfig: OSPMTConfiguration = [:]
}
