
import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init () {
        fetchNotes()
        fetchFolders()
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
    var folders: [Folder] = []
    
    private func fetchNotes() {
        let request = Note.fetchRequest()
        do {
            request.sortDescriptors = [
            NSSortDescriptor(key: "updatedAt", ascending: false),
            NSSortDescriptor(key: "createdAt", ascending: true)
            ]
            self.notes = try persistentContainer.viewContext.fetch(request)
        }
        catch {
            print(error)
        }
    }
    
    func addNote(to folder: Folder?) -> Note {
        let note = Note(context: persistentContainer.viewContext)
        note.text = "Preved ia zametko!"
        note.createdAt = Date()
        note.updatedAt = Date()
        note.folder = folder
        folder?.updatedAt = Date()
        
        saveContext()
        
        fetchNotes()
        
        return note
    }
    
    private func fetchFolders() {
        let request = Folder.fetchRequest()
        do {
            request.sortDescriptors = [
            NSSortDescriptor(key: "updatedAt", ascending: false),
            NSSortDescriptor(key: "name", ascending: true)
            ]
            folders = try persistentContainer.viewContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func deleteNote(note: Note) {
        persistentContainer.viewContext.delete(note)
        
        saveContext()
        
        fetchNotes()
    }
    
    func addFolder(name: String) {
        let folder = Folder(context: persistentContainer.viewContext)
        folder.createAt = Date()
        folder.updatedAt = Date()
        folder.name = name
        saveContext()
        fetchFolders()
    }
    
    func deleteFolder(folder: Folder) {
        persistentContainer.viewContext.delete(folder)
        saveContext()
        fetchFolders()
        fetchNotes()
    }
}
