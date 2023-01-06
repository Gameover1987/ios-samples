
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()
    
    private init() {
        
    }
    
    func addJoke(_ joke: Joke) {
        persistentContainer.performBackgroundTask { context in
            
            if self.isJokeExists(joke, in: context) {
                return
            }
            
            let jokeEntity = JokeEntity(context: context)
            jokeEntity.uid = joke.id
            jokeEntity.createdAt = Date()
            jokeEntity.text = joke.value
            
            do {
                try context.save()
            }
            catch {
                print(error)
            }
        }
    }
    
    func deleteJoke(joke: JokeEntity) {
        persistentContainer.viewContext.delete(joke)
        saveContext()
    }
    
    private func isJokeExists(_ joke: Joke, in context: NSManagedObjectContext) -> Bool {
        let request = JokeEntity.fetchRequest()
        request.fetchLimit =  1
        request.predicate = NSPredicate(format: "uid == %@", joke.id)

        do {
            let count = try context.count(for: request)
            return count > 0
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ChuckNorrisJokes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
