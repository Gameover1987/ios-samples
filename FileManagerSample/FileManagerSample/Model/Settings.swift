
import Foundation

class Settings : SettingsProtocol {
    
    public static var shared: Settings = .init()
    
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
    
    var isPasswordSet: Bool = false
}
