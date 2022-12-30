
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
            try loadContentsOfCurrentDirectory()
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
            try loadContentsOfCurrentDirectory()
        } catch {
            
        }
    }
    
    func createDirectory(directoryName: String) {
        
        guard let currentDirectory = currentDirectory else {
            return
        }
 
        do {
            try fileSystemProvider.createDirectory(directoryUrl: currentDirectory.appendingPathComponent(directoryName))
            try loadContentsOfCurrentDirectory()
        } catch {
            
        }
        
    }
    
    func deleteEntry(position: Int) {
        let entry = entries[position]
        
        do {
            try fileSystemProvider.delete(url: entry.url)
            try loadContentsOfCurrentDirectory()
        } catch {
            
        }
        
    }
    
    private func loadContentsOfCurrentDirectory() throws {
        
        guard let currentDirectory = currentDirectory else {return}
        
        let items = try fileSystemProvider.getContentsOfDirectory(path: currentDirectory.relativePath)
        
        let folders = items.filter { item in
            item.isFolder
        }.sorted(by: { $0.name < $1.name })
        
        let files = items.filter { item in
            !item.isFolder
        }.sorted(by: { $0.name < $1.name })
            
        entries = folders + files
    }
}
