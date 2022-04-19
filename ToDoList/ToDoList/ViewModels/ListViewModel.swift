//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Manoel Leal on 05/04/22.
//


/*
 CRUD FUNCTIONS
 
 CREATE
 READ
 UPDATE
 DELETE
 
 */

import Foundation

/*
 * This class manage the interaction between View and model
 * Contains all CRUD methods
 * 
 */

class ListViewModel: ObservableObject {
    
    // Everytime the var items is called, didSet execute the function saveItems for persist the data in userDefauls(cache)
    @Published var items: [ItemModel] = [] {
        didSet{
            saveItems()
        }
    }
    
    // this is the cache key for store data in userData
    let itemsKey: String = "items_list"
    
    init(){
        getItems()
    }
    
    func getItems(){
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
        
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
        
    }
    
    func addItem(title: String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)

    }
    
    func updateItem(item: ItemModel){
        
        if let index = items.firstIndex(where: {$0.id == item.id}){
            items[index] = item.updateCompletion()
        }
        
    }
    
    // Function that saves data in UserDefaults (cache)
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
}
