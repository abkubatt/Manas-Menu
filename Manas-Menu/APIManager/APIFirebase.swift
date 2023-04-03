//
//  APIFirebase.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 11.03.23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


class APIFirebase {
    
    //    fetch menus
    //        fetchMenus()
    //       fetchSubcollection()
    
    
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
    
    
    static let shared = APIFirebase()
    
    private let dbReference = Firestore.firestore().collection("menus")
//    private var menus = [Menus]()
    
    
    func fetchSubcollection() {
        // Assuming you have a reference to the document containing the subcollection
        let docRef = Firestore.firestore().collection("menus").document("9PDAWz2m38LVAmBxUbsv")
        
        // Get the subcollection reference
        let subcollectionRef = docRef.collection("menu")
        
        // Query the subcollection for documents
        subcollectionRef.getDocuments() { (querySnapshot, error) in
            if let error = error {
//                print("-----------------------------Error getting documents: \(error)")
                _ = "-----------------------------Error getting documents: \(error)"
            } else {
                for document in querySnapshot!.documents {
//                    print("-----------------------\(document.documentID) => \(document.data())")
                    _ = "-----------------------\(document.documentID) => \(document.data())"
                }
            }
        }
    }
    
    
    
    
    
    
    
    func addDocumentToFirestore(menu: Menu, completion: @escaping (Error?) -> Void) {
        do {
            _ = try  dbReference.addDocument(from: menu) { error in
                if let error = error {
//                    print("Error")
                    completion(error)
                } else {
//                    print("Successfully added to fireStore")
                    _ = "Successfully added to fireStore"
                    completion(nil)
                }
            }
        }catch let error{
//            print("Error while adding to firestore \(error)")
            _ = "Error while adding to firestore \(error)"
        }
    }
    
    
    func updateData(documentID: String, updateMenu: Menu, completion: @escaping (Error?) -> Void) {
        do{
            _ = try dbReference.document(documentID).setData(from: updateMenu) { error in
                if let error = error {
//                    print("Error \(error)")
                    completion(error)
                } else {
//                    print("Document successfully updated")
                    _ = "Document successfully updated"
                    completion(nil)
                }
            }
        }catch let error{
//            print("Error while updateing Menu \(error)")
            _ = "Error while updateing Menu \(error)"
        }
    }
    
    
    func deleteDocument(documentID: String, collectionName: String, completion: @escaping (Error?) -> Void) {
        //        let db = Firestore.firestore()
        //        let documentRef = db.collection(collectionName).document(documentID)
        dbReference.document(documentID).delete() { error in
            if let error = error {
//                print("Error deleting document: \(error.localizedDescription)")
                _ = "Error deleting document: \(error.localizedDescription)"
                completion(error)
            } else {
//                print("Document deleted successfully.")
                _ = "Document deleted successfully."
                completion(nil)
            }
        }
    }
    
    
    func addDocumentToFirestore() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let dbReference = Firestore.firestore().collection("roles").document(currentUser.uid)
        dbReference.getDocument { (document, error) in
            guard let document = document, !document.exists else {
                return
            }
            let userToAdd = UserRole(email: currentUser.email, user_role: "user")
            dbReference.setData([
                "email": userToAdd.email as Any,
                "user_role": "user",
            ]) { err in
                if let err = err {
                    _ = "-----------------------------Error writing document: \(err)"
//                    print("-----------------------------Error writing document: \(err)")
                } else {
                     _ = "----------------------------Document successfully written!"
//                    print("----------------------------Document successfully written!")
                }
            }
        }
    }
    
}
