import Nimble
import Quick
@testable import OSPaymentsLib

class OSPMTMockAvailabilityBehaviour: OSPMTAvailabilityDelegate {
    var error: OSPMTError?
    
    init(error: OSPMTError? = nil) {
        self.error = error
    }
    
    private func checkIfEqual(to error: OSPMTError) -> OSPMTError? {
        self.error == error ? error : nil
    }
    
    func checkWallet() -> OSPMTError? {
        self.checkIfEqual(to: .walletNotAvailable)
    }
    
    func checkPayment() -> OSPMTError? {
        self.checkIfEqual(to: .paymentNotAvailable)
    }
    
    func checkPaymentSetup() -> OSPMTError? {
        self.checkIfEqual(to: .setupPaymentNotAvailable)
    }
}

class OSPMTApplePayHandlerSpec: QuickSpec {
    override func spec() {
        var applePayHandler: OSPMTApplePayHandler!
        var mockAvailabilityBehaviour: OSPMTMockAvailabilityBehaviour!
        
        describe("Given a configuration") {
            beforeEach {
                applePayHandler = OSPMTApplePayHandler(configurationSource: OSPMTTestConfigurations.fullConfig)
            }
            
            context("When Apple Pay Handler is initialized") {
                it("should create the configuration property correctly") {
                    expect(applePayHandler).toNot(beNil())
                }
                
                context("and the configuration is setup") {
                    it("should return a string that matches the configuration") {
                        let result = applePayHandler.setupConfiguration()
                        
                        if case let .success(text) = result {
                            OSPMTTestConfigurations.fullConfig.forEach { item in
                                expect(text).to(contain(item.key))
                                expect(text).toNot(beEmpty())
                                if let value = item.value as? String {
                                    expect(value).toNot(beEmpty())
                                } else if let value = item.value as? [String] {
                                    expect(value).toNot(beEmpty())
                                }
                            }
                        } else {
                            fail()
                        }
                    }
                }
            }
        }
        
        describe("Given an incomplete configuration") {
            describe("without Merchant ID configured") {
                beforeEach {
                    applePayHandler = OSPMTApplePayHandler(configurationSource: OSPMTTestConfigurations.noMerchantIDConfig)
                }
                
                context("When Apple Pay Handler is initialized") {
                    it("should return a InvalidConfiguration error") {
                        let result = applePayHandler.setupConfiguration()
                        
                        if case let .failure(error) = result {
                            expect(error).to(equal(.invalidConfiguration))
                        } else {
                            fail()
                        }
                    }
                }
            }
            
            describe("without Merchant Name configured") {
                beforeEach {
                    applePayHandler = OSPMTApplePayHandler(configurationSource: OSPMTTestConfigurations.noMerchantNameConfig)
                }
                
                context("When Apple Pay Handler is initialized") {
                    it("should return a InvalidConfiguration error") {
                        let result = applePayHandler.setupConfiguration()
                        
                        if case let .failure(error) = result {
                            expect(error).to(equal(.invalidConfiguration))
                        } else {
                            fail()
                        }
                    }
                }
            }
            
            describe("without Merchant Country Code configured") {
                beforeEach {
                    applePayHandler = OSPMTApplePayHandler(configurationSource: OSPMTTestConfigurations.noMerchantCountryCodeConfig)
                }
                
                context("When Apple Pay Handler is initialized") {
                    it("should return a InvalidConfiguration error") {
                        let result = applePayHandler.setupConfiguration()
                        
                        if case let .failure(error) = result {
                            expect(error).to(equal(.invalidConfiguration))
                        } else {
                            fail()
                        }
                    }
                }
            }
            
            describe("without Payment Allowed Networks configured") {
                beforeEach {
                    applePayHandler = OSPMTApplePayHandler(configurationSource: OSPMTTestConfigurations.noPaymentAllowedNetworksConfig)
                }
                
                context("When Apple Pay Handler is initialized") {
                    it("should return a InvalidConfiguration error") {
                        let result = applePayHandler.setupConfiguration()
                        
                        if case let .failure(error) = result {
                            expect(error).to(equal(.invalidConfiguration))
                        } else {
                            fail()
                        }
                    }
                }
            }
            
            describe("without Payment Supported Capabilities configured") {
                beforeEach {
                    applePayHandler = OSPMTApplePayHandler(configurationSource: OSPMTTestConfigurations.noPaymentSupportedCapabilitiesConfig)
                }
                
                context("When Apple Pay Handler is initialized") {
                    it("should return a InvalidConfiguration error") {
                        let result = applePayHandler.setupConfiguration()
                        
                        if case let .failure(error) = result {
                            expect(error).to(equal(.invalidConfiguration))
                        } else {
                            fail()
                        }
                    }
                }
            }
            
            describe("without Payment Supported Card Countries configured") {
                beforeEach {
                    applePayHandler = OSPMTApplePayHandler(configurationSource: OSPMTTestConfigurations.noPaymentSupportedCardCountriesConfig)
                }
                
                context("When Apple Pay Handler is initialized") {
                    it("should return a InvalidConfiguration error") {
                        let result = applePayHandler.setupConfiguration()
                        
                        if case let .failure(error) = result {
                            expect(error).to(equal(.invalidConfiguration))
                        } else {
                            fail()
                        }
                    }
                }
            }
            
            describe("without Shipping Supported Contacts configured") {
                beforeEach {
                    applePayHandler = OSPMTApplePayHandler(configurationSource: OSPMTTestConfigurations.noShippingSupportedContactsConfig)
                }
                
                context("When Apple Pay Handler is initialized") {
                    it("should return a successful configuration string") {
                        let result = applePayHandler.setupConfiguration()
                        
                        if case let .success(text) = result {
                            expect(text).toNot(beEmpty())
                        } else {
                            fail()
                        }
                    }
                }
            }
            
            describe("without Billing Supported Contacts configured") {
                beforeEach {
                    applePayHandler = OSPMTApplePayHandler(configurationSource: OSPMTTestConfigurations.noBillingSupportedContactsConfig)
                }
                
                context("When Apple Pay Handler is initialized") {
                    it("should return a successful configuration string") {
                        let result = applePayHandler.setupConfiguration()
                        
                        if case let .success(text) = result {
                            expect(text).toNot(beEmpty())
                        } else {
                            fail()
                        }
                    }
                }
            }
        }
        
        describe("Given an AvailabilityBehaviour") {
            var applePayConfiguration: OSPMTApplePayConfiguration!
            
            beforeEach {
                applePayConfiguration = OSPMTApplePayConfiguration(source: OSPMTTestConfigurations.fullConfig)
            }
            context("When Wallet is not available for usage") {
                beforeEach {
                    mockAvailabilityBehaviour = OSPMTMockAvailabilityBehaviour(error: .walletNotAvailable)
                    applePayHandler = OSPMTApplePayHandler(configuration: applePayConfiguration, availabilityBehaviour: mockAvailabilityBehaviour)
                }
                
                it("should return the walletNotAvailable error") {
                    let error = applePayHandler.checkWalletAvailability()
                    
                    expect(error).to(equal(.walletNotAvailable))
                }
            }
            
            context("When Payment is not available for usage") {
                beforeEach {
                    mockAvailabilityBehaviour = OSPMTMockAvailabilityBehaviour(error: .paymentNotAvailable)
                    applePayHandler = OSPMTApplePayHandler(configuration: applePayConfiguration, availabilityBehaviour: mockAvailabilityBehaviour)
                }
                
                it("should return the paymentNotAvailable error") {
                    let error = applePayHandler.checkWalletAvailability()
                    
                    expect(error).to(equal(.paymentNotAvailable))
                }
            }
            
            context("When Payment is not available for usage") {
                beforeEach {
                    mockAvailabilityBehaviour = OSPMTMockAvailabilityBehaviour(error: .setupPaymentNotAvailable)
                    applePayHandler = OSPMTApplePayHandler(configuration: applePayConfiguration, availabilityBehaviour: mockAvailabilityBehaviour)
                }
                
                it("should return the setupPaymentNotAvailable error") {
                    let error = applePayHandler.checkWalletAvailability()
                    
                    expect(error).to(equal(.setupPaymentNotAvailable))
                }
            }
            
            context("When everything is available for usage") {
                beforeEach {
                    mockAvailabilityBehaviour = OSPMTMockAvailabilityBehaviour()
                    applePayHandler = OSPMTApplePayHandler(configuration: applePayConfiguration, availabilityBehaviour: mockAvailabilityBehaviour)
                }
                
                it("should return a nil error") {
                    let error = applePayHandler.checkWalletAvailability()
                    
                    expect(error).to(beNil())
                }
            }
        }       
    }
}
