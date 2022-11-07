
import Foundation

enum TicketType {
    case delivery(method: ShippingMethod)
    case collection
}

enum DiscountType: String {
    case festival = "FESTIVAL"
    
    var discountValue: NSDecimalNumber {
        switch self {
        case .festival:
            return NSDecimalNumber(string: "-2.00")
        }
    }
}

struct ShippingMethod {
    let price: NSDecimalNumber
    let title: String
    
    init(price: NSDecimalNumber, title: String) {
        self.price = price
        self.title = title
    }
    
    static let pigeon = ShippingMethod(price: NSDecimalNumber(string: "1.00"), title: "Pigeon")
    static let car = ShippingMethod(price: NSDecimalNumber(string: "5.00"), title: "Car")
    static let plane = ShippingMethod(price: NSDecimalNumber(string: "10.00"), title: "Plane")
    
    static let shippingMethodOptions = [Self.pigeon, Self.car, Self.plane]
}

struct Ticket {
    let title: String
    let price: NSDecimalNumber
    
    var type: TicketType = .delivery(method: .pigeon)
    var discount: DiscountType? = nil
    var tax: NSDecimalNumber = NSDecimalNumber(string: "1.00")
    
    var total: NSDecimalNumber {
        var result = price.adding(tax)
        
        if let discount = discount {
            result = result.adding(discount.discountValue)
        }
        
        switch type {
        case .delivery(let method):
            result = result.adding(method.price)
        case .collection:
            break
        }
        
        return result
    }
    
    init(title: String, price: NSDecimalNumber) {
        self.title = title
        self.price = price
    }
}
