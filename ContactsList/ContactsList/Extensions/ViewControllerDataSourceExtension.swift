//
//  ViewControllerDataSourceExtension.swift
//  ContactsList
//
//  Created by Вячеслав on 20.01.2022.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            print("Испольщуем старую ячейку для строки с индексом \(indexPath.row)")
            cell = reusableCell
        } else {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        configure(cell: cell, for: indexPath)
        return cell
    }
    
    private func configure(cell: UITableViewCell, for indexPath: IndexPath) {
        var configuration =  cell.defaultContentConfiguration()
        configuration.text = contacts[indexPath.row].title
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Ф топку", handler: {x,y,z in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        })
        
        let actions = UISwipeActionsConfiguration(actions: [deleteAction])
        return actions
    }
}
    
