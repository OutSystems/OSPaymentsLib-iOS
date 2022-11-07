
import UIKit

import StripeCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        StripeAPI.defaultPublishableKey = "pk_test_51KvKHLI1WLTTyI34CsVnUY8UoKGVpeklyySXSMhucxD2fViPCE7kW7KUqZoULMtqav1h2kkaESWeQCAqXLKnszEq00mFN2SGup"
        return true
    }
}

