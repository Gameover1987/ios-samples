
import Foundation

extension Folder {
    
    var notesSorted: [Note] {
        return notes?.sortedArray(using:[ NSSortDescriptor(key: "updatedAt", ascending: false),
                                          NSSortDescriptor(key: "name", ascending: true) ]) as? [Note] ?? []
    }
    
    func changeName(newName: String) {
        self.name = newName
        self.updatedAt = Date()
        
        do {
            try managedObjectContext?.save()
        } catch {
            print(error)
        }
    }
}


