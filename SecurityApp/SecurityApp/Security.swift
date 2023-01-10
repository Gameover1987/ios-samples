//
//  Security.swift
//  SecurityApp
//
//  Created by Вячеслав on 08.01.2023.
//

import Foundation
import UIKit

extension StringProtocol {
    var data: Data { .init(utf8) }
    var bytes: [UInt8] { .init(utf8) }
}

final class SecurityHelper {
    
    static let shared = SecurityHelper()
    
    private init() {
        
    }
    
    let apiKeyBytes: [UInt8] = [80, 114, 101, 118, 101, 100, 32, 105, 97, 32, 107, 108, 117, 99, 104, 101, 103, 33]

    func getApiKey() -> String {
        return String(bytes: apiKeyBytes, encoding: .utf8)!
    }
    
    
    func isDeviceJailBroken() -> Bool {
        // 1 jailbreak files
        
        // 2 Check url schemas
        if UIApplication.shared.canOpenURL(URL(string: "cydia://")!) {
            print("Achtung!!!")
            return true
        }
        
        // 3 Checck access to filesystem out of sandbox
        do {
            try "Jailbreak".write(toFile: "/private/file.txt", atomically: true, encoding: .utf8)
            print("Achtung!!!")
            return true
        }
        catch {
            
        }
        
        print("No jailbreak")
        return false
    }
}
