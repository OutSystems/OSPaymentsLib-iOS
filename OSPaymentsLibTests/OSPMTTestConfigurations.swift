@testable import OSPaymentsLib

struct OSPMTTestConfigurations {
    // MARK: - General Configurations
    static let dummyString = "Dummy"
    
    // MARK: - OSPMTApplePayHandlerSpec Configurations
    static let fullConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID : Self.dummyString,
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
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID : Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noMerchantCountryCodeConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID : Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noPaymentAllowedNetworksConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID : Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noPaymentSupportedCapabilitiesConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID : Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noPaymentSupportedCardCountriesConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID : Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noShippingSupportedContactsConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID : Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.billingSupportedContacts: Self.dummyString + "," + Self.dummyString
    ]
    
    static let noBillingSupportedContactsConfig: OSPMTConfiguration = [
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantID : Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantName: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.merchantCountryCode: Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentAllowedNetworks: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCapabilities: [Self.dummyString],
        OSPMTApplePayConfiguration.ConfigurationKeys.paymentSupportedCardCountries: Self.dummyString + "," + Self.dummyString,
        OSPMTApplePayConfiguration.ConfigurationKeys.shippingSupportedContacts: Self.dummyString + "," + Self.dummyString,
    ]
}
