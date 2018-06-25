//
//  ViewController.swift
//  Todoey
//
//  Created by Hye sun Chung on 22/6/2018.
//  Copyright © 2018 Hye sun Chung. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "a"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "b"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "c"
        itemArray.append(newItem3)
        
       if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
        itemArray = items
        }
    
    }

 // Mark TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    
    
    }
    //Mark TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       
      
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
// Mark - add new item
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //What happen when user presse the add item button.
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.tableView.reloadData()
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat New"
            textField = alertTextField
           
           
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    


}

