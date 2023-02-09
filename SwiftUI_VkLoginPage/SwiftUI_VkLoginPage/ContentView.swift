
import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = "123"
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("vk_logo")
                .resizable()
                .frame(width: 100, height: 100)
            
            Spacer().frame(height: 50.0)
            
            TextField("Email or phone", text: $username)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10.0)
                    .stroke(.gray, lineWidth: 0.5))
            SecureField("Password", text: $username)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10.0)
                    .stroke(.gray, lineWidth: 0.5))
            
            Spacer().frame(height: 16.0)
            
            Button {
                print("User pressed login button")
            } label: {
                Text("Log in")
                    .frame(maxWidth: .infinity, minHeight: 40.0)
            }
            .buttonStyle(.borderedProminent)
            
            Button (action: {
                LocalAuthorizationService.shared.evaluate { success, error in
                    if let error = error {
                        print(error.errorDescription)
                        return
                    }
                    
                    print("Аутентификация с использованием \(LocalAuthorizationService.shared.biometryType) прошла успешно!")
                }
            }) {
                Image(systemName: LocalAuthorizationService.shared.biometryType == .touchID ? "touchid" : "faceid")
                      .resizable()
                      .frame(width: 50, height: 50)
            }
            .padding(.top, 16.0)
            .opacity(LocalAuthorizationService.shared.biometryType == .none ? 0.0 : 1.0)
            
            Spacer()
            
            Button {
                print("User pressed sign up button")
            } label: {
                Text("Want to join us? Sign up!")
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
