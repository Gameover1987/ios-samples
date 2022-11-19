
import Foundation
import UIKit

class UserService {
    let users = [
        User(name: "Slava", age: 35),
        User(name: "Igor", age: 46),
        User(name: "Anya", age: 37),
        User(name: "Kostya", age: 34),
        User(name: "Petya", age: 32),
        User(name: "Alex", age: 33),
        User(name: "Nastya", age: 29),
    ]
    
    private init() {
        
    }
    
    public static var shared: UserService = .init()
    
    func fetchUsers (completion: @escaping (Result<[User], Error>) -> Void) {
        DispatchQueue.global().async {
            sleep(3)
            completion(.success(self.users))
        }
    }
}
