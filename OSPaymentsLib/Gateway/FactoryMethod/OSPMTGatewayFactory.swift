struct OSPMTGatewayFactory {
    static func createWrapper() -> OSPMTGatewayDelegate? {
        #if STRIPE_ENABLED
        return OSPMTStripeWrapper()
        #elseif ADYEN_ENABLED
        return OSPMTAdyenWrapper()
        #else
        return nil
        #endif
    }
}
