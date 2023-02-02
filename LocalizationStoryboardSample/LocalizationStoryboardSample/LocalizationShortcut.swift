
import Foundation

postfix operator §
postfix func § (key: String) -> String {
    return NSLocalizedString(key, comment: "")
}
