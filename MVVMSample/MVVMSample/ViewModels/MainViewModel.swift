
import Foundation

final class MainViewModel {
    
    enum Action {
        case loadUsers
        case userDidTap
    }
    
    enum State {
        case initial
        case loading
        case loaded([User])
        case error
    }
    
    private let userService: UserService
    
    private(set) var state: State = .initial {
        didSet {
            stateChanged?(state)
        }
    }
    
    init (userService: UserService) {
        self.userService = userService
    }
    
    var stateChanged: ((State) -> Void)?
    
    func loadUsers() {
        state = .loading
        userService.fetchUsers(completion: { [weak self] result in
            switch result {
            case .success(let users):
                print(users)
                self?.state = .loaded(users)
            
            case .failure(_):
                self?.state = .error
            }
        })
    }
    
    func selectUser(user: User) {
        print(user)
    }
    
}
