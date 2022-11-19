//
//  ViewController.swift
//  ContactsList
//
//  Created by Вячеслав on 20.01.2022.
//

import UIKit

class ViewController: UIViewController {

    var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort { $0.title < $1.title }
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContacts()
    }
    
    @IBAction func showNewContactAlert() {
        
        let alertController = UIAlertController(title: "Создание нового контакта", message: "Введите имя и телефон", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: {textField in
            textField.placeholder = "Имя"
        })
        alertController.addTextField(configurationHandler: {textField in
            textField.placeholder = "Номер телефона"
        })
        
        let createButton = UIAlertAction(title: "Создать", style: .default) {x in
            guard let contactName = alertController.textFields?[0].text, let contactPhone = alertController.textFields?[1].text else {
                return
            }
            let contact = Contact(contact: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alertController.addAction(cancelButton)
        alertController.addAction(createButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func loadContacts() {
        contacts.append(Contact(contact: "Любимая жена", phone: "+79963799595"))
        contacts.append(Contact(contact: "Мама", phone: "+79139011211"))
        contacts.append(Contact(contact: "Папа", phone: "+3832719292"))
    }
}

