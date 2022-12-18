
import Foundation

class FileSystemEntry {
    let fullName: String
    let name: String
    let isFolder: Bool
    let isSystem: Bool
    
    let url: URL
    
    init (url: URL, isSystem: Bool) {
        self.url = url
        self.fullName = url.relativePath
        self.name = url.lastPathComponent
        self.isFolder = url.hasDirectoryPath
        self.isSystem = isSystem
    }
}
