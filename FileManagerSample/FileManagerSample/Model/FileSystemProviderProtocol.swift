
import Foundation
import UIKit

protocol FileSystemProviderProtocol {
    
    func getDocumentsDirectory() -> URL
    
    func getContentsOfDirectory(path: String) throws -> [FileSystemEntry]
    
    func createDirectory(directoryUrl: URL) throws
    
    func saveImageToFile(image: UIImage, folderUrl: URL) throws
    
    func loadImageFromFile(url: URL) throws -> UIImage?
    
    func delete(url: URL) throws
}
