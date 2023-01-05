
import Foundation

extension String? {
    func isNullOrWhiteSpace() -> Bool {
        if self == nil {
            return true
        }
        
        return self == ""
    }
}
