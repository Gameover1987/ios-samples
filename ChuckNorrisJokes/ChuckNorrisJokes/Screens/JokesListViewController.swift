
import UIKit
import CoreData

class JokesListViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.fetchedResultsController = createFetchedResultsController()
        
        tableView.reloadData()
    }
    
    static func push(in navigationController: UINavigationController, with category: CategoryEntity) {
        if let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "jokesControllerSID") as? JokesListViewController {
            controller.category = category
            navigationController.pushViewController(controller, animated: true)
            controller.title = category.name!.uppercased()
        }
    }
    
    var category: CategoryEntity?
    
    var fetchedResultsController: NSFetchedResultsController<JokeEntity>!
    
    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search joke by text..."
        return searchController
    }()
    
    private func createFetchedResultsController() -> NSFetchedResultsController<JokeEntity> {
        let request = JokeEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        let searchString = searchController.searchBar.text!
        
        if let category = self.category, searchString != "" {
            request.predicate = NSPredicate(format: "categories contains %@ AND text contains[c] %@", category, searchString)
        } else if let category = self.category {
            request.predicate = NSPredicate(format: "categories contains %@", category)
        } else if searchString != "" {
            request.predicate = NSPredicate(format: "text contains[c] %@", searchString)
        }
        
        let controller = NSFetchedResultsController(fetchRequest: request,
                                                    managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        controller.delegate = self
        
        try? controller.performFetch()
        
        return controller
    }
    
    @IBAction func pushAddaction(_ sender: Any) {
        ChuckNorrisApi.shared.getRandomJoke(byCategory: category?.name) { result in
            DispatchQueue.main.async {                 
                switch result {
                case .failure(let error):
                   print(error)
                    
                case .success(let joke):
                    CoreDataManager.shared.addJoke(joke)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController = createFetchedResultsController()
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let joke = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = joke.text
        cell.detailTextLabel?.text = joke.createdAt?.getFormatted(format: "dd.MM.yyyy HH:mm:ss")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "jokeControllerSID") as? JokeViewController {
            let joke = fetchedResultsController.object(at: indexPath)
            controller.joke = joke
            self.present(controller, animated: true)
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .fade)
            
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        case .move:
            guard let indexPath = indexPath else { return }
            guard let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: indexPath, to: newIndexPath)
            
        case.update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        @unknown default:
            fatalError()
        }
    }
    
   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let joke = fetchedResultsController.object(at: indexPath)
            CoreDataManager.shared.deleteJoke(joke: joke)
        } else if editingStyle == .insert {
            
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
