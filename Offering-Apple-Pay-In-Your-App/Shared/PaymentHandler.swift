/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A shared class for handling payments across an app and its related extensions.
*/

import UIKit
import PassKit
import Stripe
import StripeCore

typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {

    var paymentController: PKPaymentAuthorizationController?
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler!
    
    var ticket = Ticket(title: "Festival Entry", price: NSDecimalNumber(string: "14.99"))

    static let supportedNetworks: [PKPaymentNetwork] = [
//        .amex,
//        .discover,
        .masterCard,
        .visa
    ]

    static func applePayStatus() -> (canMakePayments: Bool, canSetupCards: Bool) {
        return (PKPaymentAuthorizationController.canMakePayments(),
                PKPaymentAuthorizationController.canMakePayments(usingNetworks: supportedNetworks))
    }
    
    // Define the shipping methods.
    func shippingMethodCalculator() -> [PKShippingMethod] {
        // Calculate the pickup date.
        
        let today = Date()
        let calendar = Calendar.current
        
        var shippingMethods = [PKShippingMethod]()
        
        for shippingMethod in ShippingMethod.shippingMethodOptions {
            let offset = ShippingMethod.shippingMethodOptions.count - shippingMethods.count
            
            let shippingStart = calendar.date(byAdding: .day, value: 3 * offset, to: today)!
            let shippingEnd = calendar.date(byAdding: .day, value: 5 * offset, to: today)!
            
            let startComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingStart)
            let endComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingEnd)
            
            let shippingDelivery = PKShippingMethod(label: shippingMethod.title, amount: shippingMethod.price)
            shippingDelivery.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)
            shippingDelivery.detail = shippingMethod.title
            shippingDelivery.identifier = shippingMethod.title
            
            shippingMethods.append(shippingDelivery)
        }
        
        let shippingCollection = PKShippingMethod(label: "Collection", amount: NSDecimalNumber(string: "0.00"))
        shippingCollection.detail = "Collect ticket at festival"
        shippingCollection.identifier = "COLLECTION"
        
        shippingMethods.append(shippingCollection)
        
        return shippingMethods
    }
    
    func calculatePaymentSummaryItems() -> [PKPaymentSummaryItem] {
        var summaryItems = [PKPaymentSummaryItem]()
        
        summaryItems.append(PKPaymentSummaryItem(label: ticket.title, amount: ticket.price))
        
        
        if let discount = ticket.discount {
            summaryItems.append(PKPaymentSummaryItem(label: "Coupon Code Applied", amount: discount.discountValue))
        }
        
        summaryItems.append(PKPaymentSummaryItem(label: "Tax", amount: ticket.tax, type: .pending))
        
        switch ticket.type {
        case .delivery(let method):
            summaryItems.append(PKPaymentSummaryItem(label: method.title, amount: method.price))
        case .collection:
            summaryItems.append(PKPaymentSummaryItem(label: "Collection", amount: NSDecimalNumber(string: "0.00")))
            break
        }
        
        summaryItems.append(PKPaymentSummaryItem(label: "Total", amount: ticket.total, type: .pending))
        
        return summaryItems
    }
    
    func startPayment(completion: @escaping PaymentCompletionHandler) {
        completionHandler = completion
        
        // Create a payment request.
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = calculatePaymentSummaryItems()
//        paymentRequest.merchantIdentifier = "merchant.com.adyen.pluginPayments.test"
        paymentRequest.merchantIdentifier = Configuration.Merchant.identifier
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "PT"
        paymentRequest.currencyCode = "EUR"
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
        paymentRequest.shippingType = .delivery
        paymentRequest.shippingMethods = shippingMethodCalculator()
        paymentRequest.requiredShippingContactFields = [.emailAddress]
        
//        paymentRequest.requiredBillingContactFields = [.postalAddress]
        
        paymentRequest.supportsCouponCode = true
        
        // Display the payment request.
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { presented in
            self.paymentStatus = .failure
            
            if presented {
                debugPrint("Presented payment controller")
            } else {
                debugPrint("Failed to present payment controller")
                self.completionHandler(false)
            }
        })
    }
}

// Set up PKPaymentAuthorizationControllerDelegate conformance.

extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    
    func processStripe(payment: PKPayment, completion: @escaping (Result<String, Error>) -> Void) {
        STPAPIClient.shared.createPaymentMethod(with: payment) { paymentMethod, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let paymentMethod = paymentMethod {
                let url = URL(string: "http://192.168.1.230:5000/pay")
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let body: [String: Any] = [
                    "amount": self.ticket.total.multiplying(by: 100),
                    "payment_method": paymentMethod.stripeId
                ]

                request.httpBody = try? JSONSerialization.data(withJSONObject: body)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let response = response as? HTTPURLResponse,
                          response.statusCode == 200,
                          error == nil,
                          let data = data,
                          let string = String(data: data, encoding: .utf8) else {
                        completion(.failure(error!))
                        return
                    }

                    completion(.success(string))
                }
                task.resume()
            }
        }
        
//        let body: [String: Any] = [
//            "card" : [
//                "address_city": "Hoofddorp",
//                "address_country": "NL",
//                "address_line1": "A5%0AQq",
//                "address_zip": 2132,
//                "name": "Some%20Place"
//            ],
////            "payment_user_agent": "stripe-ios/22.5.1%3B%20variant.legacy",
//            "pk_token": String(data: payment.token.paymentData, encoding: .utf8)!,
//            "pk_token_instrument_name": payment.token.paymentMethod.displayName!,
//            "pk_token_payment_network": payment.token.paymentMethod.network!,
//            "pk_token_transaction_id": payment.token.transactionIdentifier
//        ]
//
//        let formData = URLEncoder.queryString(from: body).data(using: .utf8)
//
//        var request = URLRequest(url: URL(string: "https://api.stripe.com/v1/tokens")!)
//        request.httpMethod = "POST"
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
////        request.setValue("{\"type\":\"iPhone12,8\",\"vendor_identifier\":\"A07D825C-71A4-40C0-981F-975AB441CC18\",\"lang\":\"objective-c\",\"os_version\":\"16.0\",\"model\":\"iPhone\",\"bindings_version\":\"22.5.1\"}", forHTTPHeaderField: "X-Stripe-User-Agent")
////        request.setValue("2020-08-27", forHTTPHeaderField: "Stripe-Version")
//        request.setValue("Bearer pk_test_51KvKHLI1WLTTyI34CsVnUY8UoKGVpeklyySXSMhucxD2fViPCE7kW7KUqZoULMtqav1h2kkaESWeQCAqXLKnszEq00mFN2SGup", forHTTPHeaderField: "Authorization")
//        request.setValue(
//            String(format: "%lu", UInt(formData?.count ?? 0)), forHTTPHeaderField: "Content-Length")
//
//        request.httpBody = formData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let response = response as? HTTPURLResponse {
//
//            }
//        }
//        task.resume()
        
            
        //        STPAPIClient.shared.createToken(with: payment) { token, error in
        //            if let error = error {
        //                completion(PKPaymentAuthorizationResult(status: self.paymentStatus, errors: [error]))
        //                return
        //            }
        //
        //            if let shippingContact = payment.shippingContact {
        //                let url = URL(string: "http://192.168.1.197:5000/pay")
        //                var request = URLRequest(url: url!)
        //                request.httpMethod = "POST"
        //                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //
        //                let body: [String: Any] = [
        //                    "stripeToken": token!.tokenId,
        //                    "amount": self.ticket.total.multiplying(by: 100),
        //                    "description": self.ticket.title,
        //                    "shipping": [
        //                        "city": shippingContact.postalAddress!.city,
        //                        "state": shippingContact.postalAddress!.state,
        //                        "zip": shippingContact.postalAddress!.postalCode,
        //                        "firstName": shippingContact.name!.givenName!,
        //                        "lastName": shippingContact.name!.familyName!
        //                    ]
        //                ]
        //
        //                request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        //                let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //                    guard let response = response as? HTTPURLResponse,
        //                          response.statusCode == 200,
        //                          error == nil,
        //                          let data = data,
        //                          String(data: data, encoding: .utf8) != nil else {
        //                        completion(PKPaymentAuthorizationResult(status: self.paymentStatus, errors: error != nil ? [error!] : nil))
        //                        return
        //                    }
        //
        //                    self.paymentStatus = .success
        //                    completion(PKPaymentAuthorizationResult(status: self.paymentStatus, errors: nil))
        //                }
        //                task.resume()
        //            }
        //        }
    }
        
    func processStripe(payment: PKPayment) async -> Result<String, Error> {
        await withCheckedContinuation { continuation in
            self.processStripe(payment: payment) { result in
                continuation.resume(returning: result)
            }
        }
    }
    
    func processAdyen(payment: PKPayment, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://checkout-test.adyen.com/v69/payments")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("AQE1hmfuXNWTK0Qc+iSfh3ALvvePTYZePpxMTHJX1H2Ok1ROmsJFMQpHL2RmePTnUm084KxIFHgQwV1bDb7kfNy1WIxIIkxgBw==-8tzEgTutkfhd6PXN81PzFnjNROupZYGIKUhpuycXBTo=-JVMkqDa#aUz<*6Y~", forHTTPHeaderField: "x-API-key")

        let body: [String: Any] = [
//            "amount": self.ticket.total.multiplying(by: 100),
//            "payment_method": paymentMethod.stripeId
            "merchantAccount": "OutSystemsSoftwareEmRedeSAECOM",
            "reference": "1",
            "amount": [
                "currency": "EUR",
                "value": self.ticket.total.multiplying(by: 100)
            ],
            "paymentMethod": [
                "type": "applepay",
                "applePayToken": payment.token.paymentData.base64EncodedString()
            ],
            "returnUrl":"deeplink://paymentok"
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  error == nil,
                  let data = data,
                  let string = String(data: data, encoding: .utf8) else {
                completion(.failure(error!))
                return
            }

            completion(.success(string))
        }
        task.resume()
    }
    
    func processAdyen(payment: PKPayment) async -> Result<String, Error> {
        await withCheckedContinuation { continuation in
            self.processAdyen(payment: payment) { result in
                continuation.resume(returning: result)
            }
        }
    }
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment) async -> PKPaymentAuthorizationResult {
        let result = await self.processStripe(payment: payment)
//        let result = await self.processAdyen(payment: payment)
        
        var errors: [Error]?
        
        switch result {
        case .success:
            self.paymentStatus = .success
        case .failure(let error):
            self.paymentStatus = .failure
            errors = [error]
        }
        
        return PKPaymentAuthorizationResult(status: self.paymentStatus, errors: errors)
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            // The payment sheet doesn't automatically dismiss once it has finished. Dismiss the payment sheet.
            DispatchQueue.main.async {
                self.completionHandler!(self.paymentStatus == .success)
            }
        }
    }
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectShippingMethod shippingMethod: PKShippingMethod) async -> PKPaymentRequestShippingMethodUpdate {
        let shippingMethod = ShippingMethod.shippingMethodOptions.filter { $0.title == shippingMethod.identifier }.first
        
        ticket.type = shippingMethod != nil ? .delivery(method: shippingMethod!) : .collection
        return PKPaymentRequestShippingMethodUpdate(paymentSummaryItems: calculatePaymentSummaryItems())
    }
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didChangeCouponCode couponCode: String) async -> PKPaymentRequestCouponCodeUpdate {
        // The `didChangeCouponCode` delegate method allows you to make changes when the user enters or updates a coupon code.
        ticket.discount = DiscountType(rawValue: couponCode.uppercased())
        
        if ticket.discount == nil && !couponCode.isEmpty {
            // If the user enters a code, but it's not valid, we can display an error.
            let couponError = PKPaymentRequest.paymentCouponCodeInvalidError(localizedDescription: "Coupon code is not valid.")
            return PKPaymentRequestCouponCodeUpdate(errors: [couponError], paymentSummaryItems: calculatePaymentSummaryItems(), shippingMethods: shippingMethodCalculator())
        }
        
        return PKPaymentRequestCouponCodeUpdate(paymentSummaryItems: calculatePaymentSummaryItems())
    }

}

//extension PaymentHandler {
//    func createTokenAPIVersion(payment: PKPayment) {
//        let method = "POST"
//
//        // setup the request
//        let req_url = URL(string: "https://api.stripe.com/v1/tokens")
//        var request = URLRequest(url: req_url!);
//
//        // set the method
//        request.httpMethod = method;
//        let secret_key = "pk_test_51KvKHLI1WLTTyI34CsVnUY8UoKGVpeklyySXSMhucxD2fViPCE7kW7KUqZoULMtqav1h2kkaESWeQCAqXLKnszEq00mFN2SGup"
//        request.setValue("Bearer " + secret_key, forHTTPHeaderField: "Authorization");
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
//
//        let n_details = NSMutableDictionary()
//        n_details.addEntries(from: ["lang": "objective-c"])
//        n_details.addEntries(from: ["bindings_version": "22.3.0"])
//        n_details.addEntries(from: ["os_version": UIDevice.current.systemVersion])
//        n_details.addEntries(from: ["type": "iPhone12,8"])
//        n_details.addEntries(from: ["model": UIDevice.current.localizedModel])
//        n_details.addEntries(from: ["vendor_identifier": UIDevice.current.identifierForVendor!.uuidString])
//
//        print(n_details)
//
//        var xstripeuseragent = ""
//        do {
//            let j_data = try JSONSerialization.data(withJSONObject:n_details)
//            let j_dataString = String(data: j_data, encoding: .utf8)!
//            print(j_dataString)
//            xstripeuseragent = j_dataString
//        } catch {
//            print(error)
//        }
//
//        request.setValue(xstripeuseragent, forHTTPHeaderField:"X-Stripe-User-Agent")
//        request.setValue("2020-08-27", forHTTPHeaderField:"Stripe-Version")
//
//        var urlParser = URLComponents()
//
//        urlParser.queryItems = [
//            URLQueryItem(name: "pk_token", value: String(bytes: payment.token.paymentData, encoding: .utf8)),
//            URLQueryItem(name: "pk_token_transaction_id", value: payment.token.transactionIdentifier)
//
//        ]
//
//        if ((payment.token.paymentMethod.displayName) != nil) {
//            urlParser.queryItems?.append(URLQueryItem(name: "pk_token_instrument_name", value: payment.token.paymentMethod.displayName))
//        }
//
//        if ((payment.token.paymentMethod.network) != nil) {
//            urlParser.queryItems?.append(URLQueryItem(name: "pk_token_payment_network", value: payment.token.paymentMethod.network?.rawValue))
//        }
//
//        urlParser.queryItems?.append(URLQueryItem(name: "payment_user_agent", value:"stripe-ios/22.3.0; variant.legacy"))
//
//        let httpBodyString = urlParser.percentEncodedQuery
//
//        request.httpBody = httpBodyString?.data(using: .utf8)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard
//                let response = response as? HTTPURLResponse,
//                response.statusCode == 200,
//                error == nil,
//                let data = data,
//                let json = try? JSONSerialization.jsonObject(with: data)
//            else {
//                print("error")
//                return
//            }
//        }
//        task.resume()
//    }
//}
//
//private class URLEncoder {
//    public class func string(byURLEncoding string: String) -> String {
//        return escape(string)
//    }
//
//    public class func convertToCamelCase(snakeCase input: String) -> String {
//        let parts: [String] = input.components(separatedBy: "_")
//        var camelCaseParam = ""
//        for (idx, part) in parts.enumerated() {
//            camelCaseParam += idx == 0 ? part : part.capitalized
//        }
//
//        return camelCaseParam
//    }
//
//    public class func convertToSnakeCase(camelCase input: String) -> String {
//        var newString = input
//
//        while let range = newString.rangeOfCharacter(from: .uppercaseLetters) {
//            let character = newString[range]
//            newString = newString.replacingCharacters(in: range, with: character.lowercased())
//            newString.insert("_", at: range.lowerBound)
//        }
//
//        return newString
//    }
//
//    @objc(queryStringFromParameters:)
//    public class func queryString(from parameters: [String: Any]) -> String {
//        return query(parameters)
//    }
//}
//
//// MARK: -
//// The code below is adapted from https://github.com/Alamofire/Alamofire
//struct Key {
//    enum Part {
//        case normal(String)
//        case dontEscape(String)
//    }
//    let parts: [Part]
//}
//
///// Creates a percent-escaped, URL encoded query string components from the given key-value pair recursively.
/////
///// - Parameters:
/////   - key:   Key of the query component.
/////   - value: Value of the query component.
/////
///// - Returns: The percent-escaped, URL encoded query string components.
//private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
//    func unwrap<T>(_ any: T) -> Any {
//        let mirror = Mirror(reflecting: any)
//        guard mirror.displayStyle == .optional, let first = mirror.children.first else {
//            return any
//        }
//        return first.value
//    }
//
//    var components: [(String, String)] = []
//    switch value {
//    case let dictionary as [String: Any]:
//        for nestedKey in dictionary.keys.sorted() {
//            let value = dictionary[nestedKey]!
//            let escapedNestedKey = escape(nestedKey)
//            components += queryComponents(fromKey: "\(key)[\(escapedNestedKey)]", value: value)
//        }
//    case let array as [Any]:
//        for (index, value) in array.enumerated() {
//            components += queryComponents(fromKey: "\(key)[\(index)]", value: value)
//        }
//    case let number as NSNumber:
//        if number.isBool {
//            components.append((key, escape(number.boolValue ? "true" : "false")))
//        } else {
//            components.append((key, escape("\(number)")))
//        }
//    case let bool as Bool:
//        components.append((key, escape(bool ? "true" : "false")))
//    case let set as Set<AnyHashable>:
//        for value in Array(set) {
//            components += queryComponents(fromKey: "\(key)", value: value)
//        }
//    default:
//        let unwrappedValue = unwrap(value)
//        components.append((key, escape("\(unwrappedValue)")))
//    }
//    return components
//}
//
///// Creates a percent-escaped string following RFC 3986 for a query string key or value.
/////
///// - Parameter string: `String` to be percent-escaped.
/////
///// - Returns:          The percent-escaped `String`.
//private func escape(_ string: String) -> String {
//    string.addingPercentEncoding(withAllowedCharacters: URLQueryAllowed) ?? string
//}
//
//private func query(_ parameters: [String: Any]) -> String {
//    var components: [(String, String)] = []
//
//    for key in parameters.keys.sorted(by: <) {
//        let value = parameters[key]!
//        components += queryComponents(fromKey: escape(key), value: value)
//    }
//    return components.map { "\($0)=\($1)" }.joined(separator: "&")
//}
//
///// Creates a CharacterSet from RFC 3986 allowed characters.
/////
///// RFC 3986 states that the following characters are "reserved" characters.
/////
///// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
///// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
/////
///// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
///// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
///// should be percent-escaped in the query string.
//private let URLQueryAllowed: CharacterSet = {
//    let generalDelimitersToEncode = ":#[]@"  // does not include "?" or "/" due to RFC 3986 - Section 3.4
//    let subDelimitersToEncode = "!$&'()*+,;="
//    let encodableDelimiters = CharacterSet(
//        charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
//
//    return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
//}()
//
//extension NSNumber {
//    fileprivate var isBool: Bool {
//        // Use Obj-C type encoding to check whether the underlying type is a `Bool`, as it's guaranteed as part of
//        // swift-corelibs-foundation, per [this discussion on the Swift forums](https://forums.swift.org/t/alamofire-on-linux-possible-but-not-release-ready/34553/22).
//        String(cString: objCType) == "c"
//    }
//}
