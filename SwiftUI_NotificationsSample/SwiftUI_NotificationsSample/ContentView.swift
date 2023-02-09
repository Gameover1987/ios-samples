
import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        VStack {
            
            Button {
                registerNotifications()
            } label: {
                Text("Register notifications")
                    .frame(maxWidth: .infinity, minHeight: 40.0)
            }
            .buttonStyle(.automatic)
            
            Button {
                sendNotification()
            } label: {
                Text("Send notifications")
                    .frame(maxWidth: .infinity, minHeight: 40.0)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    private func registerNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization (options: [.alert, .sound, .badge]) { success, error in
            if let error = error {
                print(error)
                return
            }
            
            if success {
                print("Notifications enabled by user")
            } else {
                print("Notifications disabled by user")
            }
        }
    }
    
    private func sendNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.badge = 25
        content.title = "Сделай домашку блеять!"
        content.body = "Наcтрой уведомления, блджад!"
        content.categoryIdentifier = "achtung!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
