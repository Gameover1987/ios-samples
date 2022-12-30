
import Foundation

final class FileManagerFactory {
    
    static func displayAtPath(_ url: URL) -> FileManagerViewModel {
        let fileManagerViewModel = FileManagerViewModel(fileSystemProvider: FileSystemProvider.shared)
        fileManagerViewModel.changeDirectory(url: url)
        return fileManagerViewModel
    }
}
