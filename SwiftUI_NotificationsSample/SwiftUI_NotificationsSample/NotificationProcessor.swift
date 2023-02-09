
import Foundation
import UserNotifications

final class NotificationProcessor : NSObject {
    
    private let center = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        center.delegate = self
    }
}

extension NotificationProcessor : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "Preved":
            print("ну привет че")
            
        case "Medved":
            print("съебывай давай ))")
            
        default:
            print("Unknown identifier")
            
        }
        
        completionHandler()
    }
}
