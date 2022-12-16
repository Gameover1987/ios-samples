
import Foundation

class FileSystemEntry {
    let fullName: String
    let name: String
    let isFolder: Bool
    
    let url: URL
    
    init (url: URL) {
        self.url = url
        self.fullName = url.relativePath
        self.name = url.lastPathComponent
        self.isFolder = url.hasDirectoryPath
    }
}
