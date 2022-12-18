
import Foundation
import UIKit

protocol FileSystemProviderProtocol {
    func getDocumentsDirectory() -> URL
    
    func getContentsOfDirectory(path: String) throws -> [FileSystemEntry]
    
    func createDirectory(directoryUrl: URL) throws
    
    func saveImageToFile(image: UIImage)
}

final class FileSystemProvider : FileSystemProviderProtocol {
    static let shared: FileSystemProvider = .init()
    
    private init() {
        
    }
    
    func getDocumentsDirectory() -> URL {
        try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    func getContentsOfDirectory(path: String) throws -> [FileSystemEntry] {
        
        var fileSystemEntries = [FileSystemEntry]()
        let contents = try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: path), includingPropertiesForKeys: nil, options: [])
        for item in contents {
            fileSystemEntries.append(FileSystemEntry(url: item, isSystem: false))
        }
        
        return fileSystemEntries
    }
    
    func createDirectory(directoryUrl: URL) throws {
        try FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: false, attributes: [:])
    }
        
    func saveImageToFile(image: UIImage) {
        
    }
}


