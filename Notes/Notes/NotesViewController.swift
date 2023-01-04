//
//  NotesViewController.swift
//  Notes
//
//  Created by Вячеслав on 04.01.2023.
//

import UIKit

class NotesViewController: UITableViewController {

    private var currentNote: Note!
    private var currentFolder: Folder?
    
    private var notes: [Note] {
        if let currentFolder = currentFolder {
            return currentFolder.notesSorted
        }
        
        return CoreDataManager.shared.notes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentFolder = currentFolder {
            navigationItem.title = currentFolder.name
        } else
        {
            navigationItem.title = "Notes"
        }
    }

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }

    @IBAction func pushAddAction(_ sender: Any) {
        self.currentNote = CoreDataManager.shared.addNote(to: currentFolder)
        performSegue(withIdentifier: "goToOneNoteController", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.text
        cell.detailTextLabel?.text = note.updatedAt?.getFormatted(format: "dd.MM.yyyy HH:mm:ss")

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let note = notes[indexPath.row]
            CoreDataManager.shared.deleteNote(note: note)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentNote = notes[indexPath.row]
        performSegue(withIdentifier: "goToOneNoteController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? OneNoteViewController)?.note = currentNote
    }
    
    func setFolder(folder: Folder) {
        self.currentFolder = folder
    }

}
