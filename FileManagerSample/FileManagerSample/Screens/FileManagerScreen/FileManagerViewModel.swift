
import Foundation
import UIKit

final class FileManagerViewModel {
    private let fileSystemProvider: FileSystemProviderProtocol
    private let settings: SettingsProtocol
    
    init(fileSystemProvider: FileSystemProviderProtocol, settings: SettingsProtocol) {
        self.fileSystemProvider = fileSystemProvider
        self.settings = settings
    }
    
    var currentDirectory: URL?
    var entries = [FileSystemEntry]()
    
    func changeDirectory(url: URL) {
        do {
            currentDirectory = url
            try loadContentsOfCurrentDirectory()
        } catch {
            print(error)
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
            print(error)
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
            print(error)
        }
        
    }
    
    func deleteEntry(position: Int) {
        let entry = entries[position]
        
        do {
            try fileSystemProvider.delete(url: entry.url)
            try loadContentsOfCurrentDirectory()
        } catch {
            print(error)
        }
        
    }
    
    func applySettings() {
 
        do {
            try loadContentsOfCurrentDirectory()
        } catch {
            
        }
    }
    
    private func loadContentsOfCurrentDirectory() throws {
        
        guard let currentDirectory = currentDirectory else {return}
        
        let sortingMode = settings.sortingMode
        let items = try fileSystemProvider.getContentsOfDirectory(path: currentDirectory.relativePath)
        
        let folders = items.filter { item in
            item.isFolder
        }.sorted(by: { sortUsingSettings(sortingMode: sortingMode, nameA: $0.name, nameB: $1.name) })
        
        let files = items.filter { item in
            !item.isFolder
        }.sorted(by: { sortUsingSettings(sortingMode: sortingMode, nameA: $0.name, nameB: $1.name) })
        
        entries = folders + files
    }
    
    private func sortUsingSettings(sortingMode: SortingMode, nameA: String, nameB: String) -> Bool {
        switch sortingMode {
        case .none:
            return nameA == nameB
        case .alphabeticalAscending:
            return nameA < nameB
        case .alphabeticalDescending:
            return nameA > nameB
        }
    }
}
