
import Foundation
import UIKit

final class FileManagerViewModel {
    private let fileSystemProvider: FileSystemProviderProtocol
    
    init(fileSystemProvider: FileSystemProviderProtocol) {
        self.fileSystemProvider = fileSystemProvider
    }
    
    var currentDirectory: URL? = nil
    var entries = [FileSystemEntry]()
    
    func changeDirectory(url: URL) {
        do {
            currentDirectory = url
            try refresh()
        } catch {
            
        }
    }
    
    private func refresh()  throws {
        
        guard let currentDirectory = currentDirectory else {return}
        
        entries.removeAll()
        
        if (currentDirectory != fileSystemProvider.getDocumentsDirectory()) {
            entries.append(FileSystemEntry(url: currentDirectory.deletingLastPathComponent(), isSystem: true))
        }
        
        let items = try fileSystemProvider.getContentsOfDirectory(path: currentDirectory.relativePath).sorted { entry1, entry2 in
            if (entry1.isFolder) {
                if (entry2.isFolder){
                    return entry1.name < entry2.name
                }
                return true
            }
            
            return entry1.name < entry2.name
        }
        entries.append(contentsOf: items)
    }
    
    func addImageToGallery(image: UIImage) {
        
    }
    
    func createDirectory(directoryName: String) {
        
        guard let currentDirectory = currentDirectory else {
            return
        }
 
        do {
            try fileSystemProvider.createDirectory(directoryUrl: currentDirectory.appendingPathComponent(directoryName))
            try refresh()
        } catch {
            
        }
        
    }
}
