import Nimble
import Quick
@testable import OSPaymentsLib

class OSPMTApplePayHandlerSpec: QuickSpec {
    override func spec() {
        var applePayHandler: OSPMTApplePayHandler!
        
        describe("Given a configuration") {
            context("When Apple Pay Handler is initialized") {
                beforeEach {
                    applePayHandler = OSPMTApplePayHandler(configurationSource: OSPMTTestConfigurations.fullConfig)
                }
                
                it("create the configuration property correctly") {
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
    }
}
