
import Foundation
import KeychainAccess

final class Settings : SettingsProtocol {
    
    private let keychainAppName = "com.never_Soft.FileManager"
    private let keychainPasswordPath = "com.never_Soft.FileManager.Password2"
    
    static let shared = Settings()
    
    private init() {
        
    }
    
    var sortingMode: SortingMode {
        get{
            let val = UserDefaults.standard.string(forKey: "SortingMode")
            if val == nil {
                return .alphabeticalAscending
            }
            
            return SortingMode(rawValue: val!)!
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "SortingMode")
            UserDefaults.standard.synchronize()
        }
        
    }
    
    var password: String? {
        get {
            let keychain = Keychain(service: keychainAppName)
            return keychain[keychainPasswordPath]
        }
        set {
            let keychain = Keychain(service: keychainAppName)
            keychain[keychainPasswordPath] = newValue
        }
    }
}
