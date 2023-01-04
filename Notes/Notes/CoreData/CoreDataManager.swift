
import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init () {
        fetchNotes()
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var notes: [Note] = []
    
    private func fetchNotes() {
        let request = Note.fetchRequest()
        do {
            self.notes = try persistentContainer.viewContext.fetch(request)
        }
        catch {
            print(error)
        }
    }
    
    func addNote() {
        let note = Note(context: persistentContainer.viewContext)
        note.text = "Preved ia zametko!"
        note.createdAt = Date()
        note.updatedAt = Date()
        
        saveContext()
        
        fetchNotes()
    }
    
    func deleteNote(note: Note) {
        persistentContainer.viewContext.delete(note)
        
        saveContext()
        
        fetchNotes()
    }
    
    
}
