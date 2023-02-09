
import SwiftUI
import UserNotifications

@main
struct SwiftUI_NotificationsSampleApp : App {
    
    private let center = NotificationProcessor()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init () {
        registerNotificationCategories()
    }
    
    private func registerNotificationCategories() {
        let center = UNUserNotificationCenter.current()
        
        let action1 = UNNotificationAction(identifier: "Preved", title: "Preved hule!")
        let action2 = UNNotificationAction(identifier: "Medved", title: "Medved hule!")
        
        let category = UNNotificationCategory(identifier: "achtung!", actions: [action1, action2], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
}
