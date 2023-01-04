
import UIKit

class FoldersViewController: UITableViewController {
    
    @IBAction func addFolderAction(_ sender: Any) {
        
        TextPicker.shared.showIn(viewController: self, title: "Add folder", placeHolder: "Folder name") { text in
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
        return CoreDataManager.shared.folders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let folder = CoreDataManager.shared.folders[indexPath.row]
        
        cell.textLabel?.text = folder.name
        let details = folder.updatedAt!.getFormatted(format: "dd.MM.yyyy HH.mm.ss") + " \(folder.notes?.count ?? 0)"
        cell.detailTextLabel?.text = details
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let folder = CoreDataManager.shared.folders[indexPath.row]
            CoreDataManager.shared.deleteFolder(folder: folder)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        if editingStyle == .insert {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNotesByFolder", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow else {return}
        
        (segue.destination as? NotesViewController)?.setFolder(folder: CoreDataManager.shared.folders[indexPathForSelectedRow.row])
    }
    
    @objc
    private func longPressGestureHandler(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        let longPressPoint = longPressGestureRecognizer.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: longPressPoint) else {return}
        let folder = CoreDataManager.shared.folders[indexPath.row]
        
        TextPicker.shared.showIn(viewController: self, title: "Folder renaming", message: folder.name ?? "") { text in
            folder.changeName(newName: text)
            self.tableView.reloadData()
        }
    }
}
