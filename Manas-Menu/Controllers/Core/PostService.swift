//
//  PostService.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 07.04.23.
//

import UIKit
import Firebase

struct TodoItem {
    var title: String
    var isComplete: Bool
    var id: String
    
    init(keyID: String, dictionary: [String:Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.isComplete = dictionary["isComplete"] as? Bool ?? false
        self.id = keyID
    }
}


struct PostService {
    
    static let shared = PostService()
    
    let DB_REF = Database.database().reference()
    
    
    func fetchAllItems(completion: @escaping([TodoItem]) -> Void) {
        var allItems = [TodoItem]()
        
        DB_REF.child("items")
            .queryOrdered(byChild: "isComplete")
            .observe(.childAdded) { (snapshot) in
            fetchSingleItem(id: snapshot.key) { (item) in
                allItems.append(item)
                completion(allItems)
            }
        }
    }
    
    func fetchSingleItem(id: String, completion: @escaping(TodoItem) -> Void) {
        DB_REF.child("items").child(id).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else {
                return
            }
            
            let todoItem = TodoItem(keyID: id, dictionary: dictionary)
            completion(todoItem)
        }
    }
    
    func uploadTodoItem(delivery: DrinksDelivery, completion: @escaping(Error?, DatabaseReference) -> Void) {
//        let values = ["title": text, "isComplete": false] as [String: Any]
        let values = ["name": delivery.name, "amount": delivery.amount, "orderedPersonEmail": delivery.orderedPersonEmail, "roomName": delivery.roomName]
        let id = DB_REF.child("items").childByAutoId()
        id.updateChildValues(values, withCompletionBlock: completion)
        id.updateChildValues(values) { (err, ref) in
            let value = ["id": id.key!]
            DB_REF.child("items").child(id.key!).updateChildValues(value, withCompletionBlock: completion)
        }
    }
    
    func updateItemStatus(todoid: String, isComplete: Bool, completion: @escaping(Error?, DatabaseReference) -> Void) {
        let value = ["isComplete": isComplete]
        
        DB_REF.child("items").child(todoid).updateChildValues(value, withCompletionBlock: completion)
    }
    
    
}

struct DrinksDelivery: Codable {
    let id: Int
    let name: String
    let amount: String
    let orderedPersonEmail: String
    let roomName: String
}
