
import Foundation
import UIKit

final class FileManagerViewModel {
    private let fileSystemProvider: FileSystemProviderProtocol
    
    init(fileSystemProvider: FileSystemProviderProtocol) {
        self.fileSystemProvider = fileSystemProvider
    }
    
    var currentDirectory: String = ""
    var entries = [FileSystemEntry]()
    
    func changeDirectory(url: URL) {
        do {
            entries = try fileSystemProvider.getContentsOfDirectory(path: url.relativePath)
        } catch {
            
        }
    }
    
    func addImageToGallery(image: UIImage) {
        
    }
    
    func createDirectory(directoryName: String) {
        
    }
}
