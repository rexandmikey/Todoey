//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Hye sun Chung on 26/6/2018.
//  Copyright © 2018 Hye sun Chung. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadCategories()

    }
    
//Mark : TableView Delegate Methods
    
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     performSegue(withIdentifier: "goToItem", sender: self)
    
    
        //     context.delete(categories[indexPath.row])
        //    categories.remove(at: indexPath.row)
        
        //save(category: Category)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
//Mark : TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category add yet"
        
        
        
        return cell
        
    }
  
//Mark : Data Manipulation Methods
    func save(category: Category) {
       
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    func loadCategories() {
        
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }

    
//Mark : Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
    
            self.save(category: newCategory)
        }
        alert.addTextField { (field) in
            
            field.placeholder = "Create New Category"
            textField = field
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    

    
    
    
    
}
