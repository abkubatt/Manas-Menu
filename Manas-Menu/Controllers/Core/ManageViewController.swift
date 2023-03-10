//
//  ManageViewController.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 10.03.23.
//

import UIKit
import FirebaseFirestore



class ManageViewController: UIViewController {
    
    private let dbReference = Firestore.firestore().collection("menu")
    private var menus = [Menu]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Manage"
        view.backgroundColor = .systemBackground
    /// fetch menus
        fetchMenus()
        
        
        /// addDocument
        //        addDocumentToFirestore(menu: menuData) { error in
        //            if let error = error {
        //                print("Error adding document: \(error.localizedDescription)")
        //            } else {
        //                print("Document added successfully!")
        //            }
        //        }
        
        
        
        /// Update
        
        //        let menuData = Menu(id: nil, name: "Turk Pilavi", calorie: "453", image: "https://plovnaya1.com/thumb/2/NcOqCNLPeEzcWnn7QN_RsA/r/d/plov_chajhana_375.jpg")
        //
        //        updateData(documentID: "cuo456lx94Wk2vYzZbH4", updateMenu: menuData) { error in
        //            if let error = error {
        //                print("Error updating document: \(error.localizedDescription)")
        //            }else{
        //                print("Document updated successfully!")
        //            }
        //        }
        
        
        /// Delete function
        
        //        deleteDocument(documentID: "cuo456lx94Wk2vYzZbH4", collectionName: "menu") { error in
        //            if let error = error {
        //                print("Error deleting document: \(error.localizedDescription)")
        //            } else {
        //                print("Document deleted successfully.")
        //            }
        //        }

        
    }
    
    func fetchMenus() {
        dbReference.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }
            self.menus = documents.compactMap{ document in
                do {
                    let menu = try document.data(as: Menu.self)
                    return menu
                } catch {
                    print("Error decoding Menu: \(error.localizedDescription)")
                    return nil
                }
            }
            print("Fetched Menus: \(self.menus)")
        }
    }
    
    
    
    
    func addDocumentToFirestore(menu: Menu, completion: @escaping (Error?) -> Void) {
        do {
            _ = try  dbReference.addDocument(from: menu) { error in
                if let error = error {
                    print("Error")
                    completion(error)
                } else {
                    print("Successfully added to fireStore")
                    completion(nil)
                }
            }
            
        }catch let error{
            print("Error while adding to firestore \(error)")
        }
        
    }
    
    
    
    func updateData(documentID: String, updateMenu: Menu, completion: @escaping (Error?) -> Void) {
        
        do{
            _ = try dbReference.document(documentID).setData(from: updateMenu) { error in
                if let error = error {
                    print("Error \(error)")
                    completion(error)
                } else {
                    print("Document successfully updated")
                    completion(nil)
                }
            }
        }catch let error{
            print("Error while updateing Menu \(error)")
        }
        
    }
    
    
    

    func deleteDocument(documentID: String, collectionName: String, completion: @escaping (Error?) -> Void) {
//        let db = Firestore.firestore()
//        let documentRef = db.collection(collectionName).document(documentID)

        dbReference.document(documentID).delete() { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Document deleted successfully.")
                completion(nil)
            }
        }
    }

    
    
    
    
    
    
}
    
    

    // collection: String mene jazsada BOLOT
    
    
//    func deleteDocument(documentID: String, collectionName: String, completion: @escaping (Error?) -> Void) {
//        let db = Firestore.firestore()
//        let documentRef = db.collection(collectionName).document(documentID)
//
//        documentRef.delete() { error in
//            if let error = error {
//                print("Error deleting document: \(error.localizedDescription)")
//                completion(error)
//            } else {
//                print("Document deleted successfully.")
//                completion(nil)
//            }
//        }
//    }
    


    
    
    
    
    
    
    
    
    
    
    
    
    
   

    
    
    
    
    
    
//    func addDocumentToFirestore() {
//
//        // Define the data you want to add to Firestore
//        let mennu: Menu =
//            Menu(id: nil, name: "Uzbek Pilavi", calorie: "234", image: "https://eda.yandex.ru/images/3772784/95bb969beb85352c9868ccb7679ddded-800x800.jpeg")
//
//        // Add the document to Firestore
//        dbReference.addDocument(from: mennu) { error in
//            do{
//
//            }
//            if let error = error {
//                // Handle any errors that occur while adding the document
//                print("Error adding document: \(error)")
//            } else {
//                // Print a success message and the document ID
//                print("Document added")
//            }
//        }
//    }





