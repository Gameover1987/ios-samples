
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {
        fetchArticles()
    }
    
    var articles: [ArticleEntity] = []
    
    private lazy var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    private  lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    func addArticles(articles: [Article], completion: (() -> Void)?) {
        
        backgroundContext.perform {
            for article in articles {
                if self.isArticleExists(url: article.url) {
                    continue
                }
                
                let articleEntity = ArticleEntity(context: self.backgroundContext)
                articleEntity.author = article.author
                articleEntity.descr = article.description
                articleEntity.url = article.url
                articleEntity.urlToImage = article.urlToImage
                articleEntity.publishedAt = article.publishedAt
                articleEntity.content = article.content
                articleEntity.title = article.title
                
                articleEntity.isFavorite = false
            }
            
            self.saveBackgroundContext()
            
            self.fetchArticles()
            
            completion?()
        }
    }
    
    func toggleFavoriteArticle(article: ArticleEntity) {
        article.isFavorite.toggle()
        
        saveMainContext()
    }
    
    func searchArticlesByTitle(title: String) -> [ArticleEntity] {
        let request = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title contains[c] %@", title)
        return (try? mainContext.fetch(request)) ?? []
    }
    
    private func isArticleExists(url: String?) -> Bool {
        guard let url = url else {
            return true
        }
        
        let request = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        
        if let _ = (try? backgroundContext.fetch(request))?.first {
            return true
        }
        
        return false
    }
    
    private func fetchArticles() {
        let request = ArticleEntity.fetchRequest()
        
        do {
            articles = try mainContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsParser")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveMainContext () {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error in main context \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func saveBackgroundContext () {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error in background context \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
