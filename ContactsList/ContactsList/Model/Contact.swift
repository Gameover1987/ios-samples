
import Foundation

public protocol ContactProtocol {
    var title: String { get set }
    var phone: String { get set }
}

public class Contact : ContactProtocol {
    public var title: String
    public var phone: String
    
    init(contact: String, phone: String) {
        self.title = contact
        self.phone = phone
    }
}
