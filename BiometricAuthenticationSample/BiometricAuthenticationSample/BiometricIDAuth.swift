
import Foundation
import LocalAuthentication

final class BiometricIDAuth {
    enum BiometricType {
        case none
        case touchID
        case faceID
        case unknown
    }
    
    enum BiometricError: LocalizedError {
        case authenticationFailed
        case userCancel
        case userFallback
        case biometryNotAvailable
        case biometryNotEnrolled
        case biometryLockout
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .authenticationFailed:
                return "There was a problem verifying your identity."
            case .userCancel:
                return "You pressed cancel."
            case .userFallback:
                return "You pressed password."
            case .biometryNotAvailable:
                return "FaceID/TouchID is not available."
            case .biometryNotEnrolled:
                return "FaceID/TouchID is not setup."
            case .biometryLockout:
                return "FaceID/TouchID is locked."
            case .unknown:
                return "FaceID/TouchID may not be configured."
            }
        }
    }
    
    private let context = LAContext()
    private let policy: LAPolicy
    private let localizedreason: String
    
    private var error: NSError?
    
    init(policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
         localizedReason: String = "Verify your identity",
         localizedFallbackTitle: String = "Enter App Password") {
        self.policy = policy
        self.localizedreason = localizedReason
        context.localizedFallbackTitle = localizedFallbackTitle
        context.localizedFallbackTitle = "Touch me not ))"
    }
    
    func canEvaluate(completion: (Bool, BiometricType, BiometricError?) -> Void) {
        guard context.canEvaluatePolicy(policy, error: &error) else {
            let type = biometricType(for: context.biometryType)
            
            guard let error = error else {
                return completion(false, type, nil)
            }
            
            return completion(false, type, biometricError(from: error))
        }
        
        return completion(true, biometricType(for: context.biometryType), nil)
    }
    
    func evaluate(completion: @escaping(Bool, BiometricError?) -> Void) {
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
            
        default:
            return .unknown
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
