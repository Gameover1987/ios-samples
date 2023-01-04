
import UIKit

class CategoriesViewController: UITableViewController {
    
    @IBAction func addFolderAction(_ sender: Any) {
        
        TextPicker.shared.showIn(viewController: self, title: "Add category", placeHolder: "Category") { text in
            CoreDataManager.shared.addFolder(name: text)
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureHandler))
        tableView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let category = CoreDataManager.shared.categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        let details = category.updatedAt!.getFormatted(format: "dd.MM.yyyy HH.mm.ss") + " \(category.notes?.count ?? 0)"
        cell.detailTextLabel?.text = details
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let folder = CoreDataManager.shared.categories[indexPath.row]
            CoreDataManager.shared.deleteCategory(category: folder)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        if editingStyle == .insert {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNotesByCategory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow else {return}
        
        (segue.destination as? NotesViewController)?.setCategory(CoreDataManager.shared.categories[indexPathForSelectedRow.row])
    }
    
    @objc
    private func longPressGestureHandler(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        let longPressPoint = longPressGestureRecognizer.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: longPressPoint) else {return}
        let category = CoreDataManager.shared.categories[indexPath.row]
        
        TextPicker.shared.showIn(viewController: self, title: "Category renaming", message: category.name ?? "") { text in
            category.changeName(newName: text)
            self.tableView.reloadData()
        }
    }
}
