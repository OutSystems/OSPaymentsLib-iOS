import PassKit

extension PKContactField {
    static func convert(from text: String) -> PKContactField? {
        switch text.lowercased() {
        case "email":
            return .emailAddress
        case "name":
            return .name
        case "phone":
            return .phoneNumber
        case "postal_address":
            return .postalAddress
        default:
            return nil
        }
    }
}
