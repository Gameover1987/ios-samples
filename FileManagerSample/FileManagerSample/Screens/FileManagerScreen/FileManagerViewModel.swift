
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
    
    func saveImageToCurrentFolder(image: UIImage) {
        guard let currentDirectory = currentDirectory else {
            return
        }
        
        do {
            try fileSystemProvider.saveImageToFile(image: image,
                                               folderUrl: currentDirectory)
            try refresh()
        } catch {
            
        }
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
    
    private func refresh() throws {
        
        guard let currentDirectory = currentDirectory else {return}
        
        entries.removeAll()
        
        if (currentDirectory != fileSystemProvider.getDocumentsDirectory()) {
            entries.append(FileSystemEntry(url: currentDirectory.deletingLastPathComponent(), isSystem: true))
        }
        
        let items = try fileSystemProvider.getContentsOfDirectory(path: currentDirectory.relativePath)
           
        let systemItems = items.filter { item in
            item.isSystem
        }
        
        let folders = items.filter { item in
            item.isFolder
        }.sorted(by: { $0.name < $1.name })
        
        let files = items.filter { item in
            !item.isFolder
        }.sorted(by: { $0.name < $1.name })
            
        
        entries.append(contentsOf: systemItems + folders + files)
    }
}
