
import Foundation

final class FileManagerFactory {
    
    static func displayAtPath(_ url: URL) -> FileManagerViewModel {
        let fileManagerViewModel = FileManagerViewModel(fileSystemProvider: FileSystemProvider.shared, settings: Settings.shared)
        fileManagerViewModel.changeDirectory(url: url)
        return fileManagerViewModel
    }
}
