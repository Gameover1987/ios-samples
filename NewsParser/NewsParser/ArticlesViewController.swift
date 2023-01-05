
import UIKit

class ArticlesViewController: UITableViewController, UISearchResultsUpdating {
    var articles: [ArticleEntity] {
        if searchController.searchBar.text.isNullOrWhiteSpace() {
            return CoreDataManager.shared.articles
        }
        
        return CoreDataManager.shared.searchArticlesByTitle(title: searchController.searchBar.text!)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text.isNullOrWhiteSpace() {
            tableView.reloadData()
        }
        
        NetworkManager.shared.downloadJson(query: searchController.searchBar.text!) { articles in
            CoreDataManager.shared.addArticles(articles: articles ?? []) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Newsapi.org articles"
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search article by header"
        navigationItem.searchController = searchController
        
        NetworkManager.shared.downloadJson(query: "") { articles in
            guard let articles = articles else { return }
            
            CoreDataManager.shared.addArticles(articles: articles) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = articles.count
        return count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let article = articles[indexPath.row]
        
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.content
        
        if article.isFavorite {
            cell.imageView?.image = UIImage(systemName: "star.fill")
        } else {
            cell.imageView?.image = UIImage(systemName: "star")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        
       performSegue(withIdentifier: "goToOneArticle", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow else {return}
        
        (segue.destination as? OneArticleViewController)?.setArticle(article: articles[indexPathForSelectedRow.row])
    }
}
