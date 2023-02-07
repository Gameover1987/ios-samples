
import Foundation

final class BandsViewModel : ObservableObject {
    
    private let bandsProvider: BandsProviderProtocol
    
    init(bandsProvider: BandsProviderProtocol) {
        self.bandsProvider = bandsProvider
        
        self.bands = bandsProvider.getBands()
    }
    
    let bands: [Band]
}
