
import Foundation
import UIKit

final class FileSystemProvider : FileSystemProviderProtocol {
    
    static let shared = FileSystemProvider()
    
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
        
    func saveImageToFile(image: UIImage, folderUrl: URL) throws {
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let fileName = dateFormatter.string(from: now) + ".jpg"
        let pathToImage = folderUrl.appendingPathComponent(fileName)
        let imageData = image.jpegData(compressionQuality: 1.0)
        
        FileManager.default.createFile(atPath: pathToImage.relativePath, contents: imageData)
    }
    
    func loadImageFromFile(url: URL) throws -> UIImage? {
        let fileData = try Data(contentsOf: url)
        return UIImage(data: fileData)!
    }
    
    func delete(url: URL) throws {
        try FileManager.default.removeItem(at: url)
    }
}
