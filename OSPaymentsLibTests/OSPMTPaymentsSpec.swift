import Nimble
import Quick
@testable import OSPaymentsLib

class OSPMTMockCallback: OSPMTCallbackDelegate {
    var successText: String?
    var error: OSPMTError?
    
    func callback(result: String?, error: OSPMTError?) {
        self.successText = result
        self.error = error
    }
}

struct OSPMTMockHandler: OSPMTHandlerDelegate {
    var successText: String?
    var error: OSPMTError?
    
    func setupConfiguration() -> Result<String, OSPMTError> {
        if let error = self.error {
            return .failure(error)
        } else {
            return .success(self.successText ?? "")
        }
    }
}

class OSPMTPaymentsSpec: QuickSpec {
    override func spec() {
        var mockDelegate: OSPMTMockCallback!
        var mockHandler: OSPMTMockHandler!
        var payments: OSPMTPayments!
        
        describe("Given a delegate") {
            beforeEach {
                mockDelegate = OSPMTMockCallback()
            }
            
            describe("and a correctly configured handler") {
                context("When the OSPMTPayments object is initialized") {
                    beforeEach {
                        mockHandler = OSPMTMockHandler(successText: OSPMTTestConfigurations.dummyString)
                        payments = OSPMTPayments(delegate: mockDelegate, handler: mockHandler)
                    }
                    
                    it("Setup configuration should return a successful text message") {
                        payments.setupConfiguration()
                        
                        expect(mockDelegate.successText).to(equal(OSPMTTestConfigurations.dummyString))
                        expect(mockDelegate.error).to(beNil())
                    }
                }
            }
            
            describe("and a incorrectly configured handler") {
                context("When the OSPMTPayments object is initialized") {
                    beforeEach {
                        mockHandler = OSPMTMockHandler(error: .invalidConfiguration)
                        payments = OSPMTPayments(delegate: mockDelegate, handler: mockHandler)
                    }
                    
                    it("Setup configuration should return a InvalidConfiguration error") {
                        payments.setupConfiguration()
                        
                        expect(mockDelegate.error).to(equal(mockHandler.error))
                        expect(mockDelegate.successText).to(beNil())
                    }
                }
            }
            
            describe("and an Apple Pay Handler correctly configured") {
                context("When the OSPMTPayments object is initialized") {
                    beforeEach {
                        payments = OSPMTPayments(applePayWithDelegate: mockDelegate, andConfiguration: OSPMTTestConfigurations.fullConfig)
                    }
                    
                    it("Setup configuration should return a non empty text message") {
                        payments.setupConfiguration()
                        
                        expect(mockDelegate.successText).toNot(beEmpty())
                        expect(mockDelegate.error).to(beNil())
                    }
                }
            }
        }
    }
}
