
import Foundation

enum SortingMode: String, CaseIterable {
    case none = "None"
    case alphabeticalAscending = "Alphabetical ascending"
    case alphabeticalDescending = "Alphabetical descending"
}

protocol SettingsProtocol {
    var sortingMode: SortingMode {get set}
    
    var isPasswordSet: Bool {get}
}
