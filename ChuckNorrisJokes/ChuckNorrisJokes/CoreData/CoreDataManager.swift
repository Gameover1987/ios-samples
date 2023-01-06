
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()
    
    private init() {
        
    }
    
    func addJoke(_ joke: Joke) {
        persistentContainer.performBackgroundTask { context in
            
            let jokeEntity = self.getOrCreateJoke(joke: joke, in: context)
            
            for categoryAsString in joke.categories {
                let categoryEntity = self.getOrCreateCategory(byName: categoryAsString, in: context)
                
                categoryEntity.addToJokes(jokeEntity)
                jokeEntity.addToCategories(categoryEntity)
            }
            
            self.save(in: context)
        }
    }
    
    func deleteJoke(joke: JokeEntity) {
        persistentContainer.viewContext.delete(joke)
        save(in: persistentContainer.viewContext)
    }
    
    private func getOrCreateCategory(byName name: String, in context: NSManagedObjectContext) -> CategoryEntity {
        let request = CategoryEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        
        if let category = (try? context.fetch(request))?.first {
            return category
        }
        else {
            let category = CategoryEntity(context: context)
            category.name = name
            return category
        }
    }
    
    private func getOrCreateJoke(joke: Joke, in context: NSManagedObjectContext) -> JokeEntity {
        let request = JokeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "uid == %@", joke.id)
        
        if let jokeEntity = (try? context.fetch(request))?.first {
            return jokeEntity
        }
        else {
            let jokeEntity = JokeEntity(context: context)
            jokeEntity.uid = joke.id
            jokeEntity.createdAt = Date()
            jokeEntity.text = joke.value
            
            return jokeEntity
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

    private func save(in context: NSManagedObjectContext) {
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
