
import Foundation

extension Note {
    
    func setText(text: String) {
        self.text = text
        self.updatedAt = Date()
        
        do {
            try self.managedObjectContext?.save()
        } catch {
            print(error)
        }
    }
}
