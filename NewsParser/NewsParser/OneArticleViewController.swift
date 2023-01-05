
import UIKit

class OneArticleViewController: UITableViewController {

//    static func push(in viewController: UIViewController, with article: ArticleEntity) {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let oneArticleViewController = storyboard.instantiateViewController(withIdentifier: "articleControllerSID") as! OneArticleViewController
//        
//        oneArticleViewController.setArticle(article: article)
//        
//        viewController.navigationController?.pushViewController(oneArticleViewController, animated: true)
//    }
    
    private var article: ArticleEntity!
    
    func setArticle(article:ArticleEntity) {
        self.article = article
    }
    
    @IBOutlet weak var buttonStar: UIBarButtonItem!
    
    @IBAction func pushStarAction(_ sender: Any) {
        
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if article.isFavorite {
            buttonStar.image = UIImage(systemName: "star.fill")
        }
        else {
            buttonStar.image = UIImage(systemName: "star")
        }
        
        titleLabel.text = article.title
        
        imageView.image = UIImage(systemName: "exclamationmark.icloud.fill")
        if let urlToImage = article.urlToImage {
            if let url = URL(string: urlToImage) {
                let data = try? Data(contentsOf: url)
                if let data = data {
                    let image = UIImage(data: data)
                    imageView.image = image
                    imageView.contentMode = .scaleAspectFit
                }
            }
        }
        
        textView.text = article.content
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
