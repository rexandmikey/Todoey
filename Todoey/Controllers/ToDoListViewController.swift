//
//  ViewController.swift
//  Todoey
//
//  Created by Hye sun Chung on 22/6/2018.
//  Copyright © 2018 Hye sun Chung. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    let realm = try! Realm()
    var toDoItems: Results<Item>?
    
    var selectedCategory : Category? {
        didSet{
          loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
      
        
    }

 // Mark TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListCell", for: indexPath)
        if let item = toDoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "No added items"
        }
        
       
        
        
        return cell
    
    
    }
    //Mark TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let item = toDoItems?[indexPath.row] {
            
            do {
                try realm.write {
                    
                 item.done = !item.done
             }
            } catch {
                print("Error saving done status, \(error)")
             }
        }
         tableView.reloadData()
       
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
// Mark - add new item
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //What happen when user presse the add item button.
            
            
            
            
           
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                    }
                } catch {
                        print("Error saving toDoItems \(error)")
                }
                
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
           
            alertTextField.placeholder = "Creat New"
            textField = alertTextField
           
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func loadItems() {
       
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
   }
    

}

extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {

            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }

}
