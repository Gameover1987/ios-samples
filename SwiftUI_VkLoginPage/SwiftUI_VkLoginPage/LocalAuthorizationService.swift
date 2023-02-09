
import Foundation
import LocalAuthentication

enum BiometricType {
    case none
    case touchID
    case faceID
}

enum BiometricError: LocalizedError {
    case authenticationFailed
    case userCancel
    case userFallback
    case biometryNotAvailable
    case biometryNotEnrolled
    case biometryLockout
    case unknown
    
    var errorDescription: String {
        switch self {
        case .authenticationFailed:
            return "Чет проблема какая то с определением кто есть кто"
        case .userCancel:
            return "Вы отменили аутентификацию"
        case .userFallback:
            return "Вы решили ввести пароль"
        case .biometryNotAvailable:
            return "FaceID/TouchID недоступен"
        case .biometryNotEnrolled:
            return "FaceID/TouchID не настроен"
        case .biometryLockout:
            return "FaceID/TouchID заблокирован"
        default:
            return "FaceID/TouchID возможно не сконфигурирован"
        }
    }
}

final class LocalAuthorizationService {
    
    static let shared = LocalAuthorizationService()
    
    private let context = LAContext()
    private let policy: LAPolicy
    private let localizedreason: String
    
    private var error: NSError?
    
    init(policy: LAPolicy = .deviceOwnerAuthentication,
         localizedReason: String = "Кто стучится в дверь ко мне?",
         localizedFallbackTitle: String = "Может все таки пароль введем?") {
        self.policy = policy
        self.localizedreason = localizedReason
        context.localizedFallbackTitle = localizedFallbackTitle
        context.localizedFallbackTitle = "Может таки пароль?"
        
        context.canEvaluatePolicy(policy, error: &error)
    }
    
    var biometryType: BiometricType {
        return biometricType(for: context.biometryType)
    }
    
    func evaluate(completion: @escaping(Bool, BiometricError?) -> Void) {
        
        if biometryType == .none {
            print("Биометрия недоступна")
            return
        }
        
        context.evaluatePolicy(policy, localizedReason: localizedreason) { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    completion(true, nil)
                }
                else {
                    guard let error = error else { return completion(false, nil) }
                    
                    completion(false, self?.biometricError(from: error as NSError))
                }
            }
        }
    }
    
    private func biometricType(for type: LABiometryType) -> BiometricType {
        switch type {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        }
    }
    
    private func biometricError(from nsError: NSError) -> BiometricError {
        switch nsError {
        case LAError.authenticationFailed:
            return .authenticationFailed
            
        case LAError.userCancel:
            return .userCancel
            
        case LAError.userFallback:
            return .userFallback
            
        case LAError.biometryNotAvailable:
            return .biometryNotAvailable
            
        case LAError.biometryNotEnrolled:
            return .biometryNotEnrolled
            
        case LAError.biometryLockout:
            return .biometryLockout
            
        default:
            return .unknown
        }
    }
}
