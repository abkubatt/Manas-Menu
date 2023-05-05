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
    
    
    static let shared = APIFirebase()
    
    private let dbReference = Firestore.firestore().collection("menus")
    
    
    func fetchSubcollection() {
        let docRef = Firestore.firestore().collection("menus").document("9PDAWz2m38LVAmBxUbsv")
        
        let subcollectionRef = docRef.collection("menu")
        
        subcollectionRef.getDocuments() { (querySnapshot, error) in
            if let error = error {
                _ = "-----------------------------Error getting documents: \(error)"
            } else {
                for document in querySnapshot!.documents {
                    _ = "-----------------------\(document.documentID) => \(document.data())"
                }
            }
        }
    }
    
    
    func addDocumentToFirestore(menu: Menu, completion: @escaping (Error?) -> Void) {
        do {
            _ = try  dbReference.addDocument(from: menu) { error in
                if let error = error {
                    completion(error)
                } else {
                    _ = "Successfully added to fireStore"
                    completion(nil)
                }
            }
        }catch let error{
            _ = "Error while adding to firestore \(error)"
        }
    }
    
    
    func updateData(documentID: String, updateMenu: Menu, completion: @escaping (Error?) -> Void) {
        do{
            _ = try dbReference.document(documentID).setData(from: updateMenu) { error in
                if let error = error {
                    completion(error)
                } else {
                    _ = "Document successfully updated"
                    completion(nil)
                }
            }
        }catch let error{
            _ = "Error while updateing Menu \(error)"
        }
    }
    
    func deleteDocument(documentID: String, collectionName: String, completion: @escaping (Error?) -> Void) {
        dbReference.document(documentID).delete() { error in
            if let error = error {
                _ = "Error deleting document: \(error.localizedDescription)"
                completion(error)
            } else {
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
                } else {
                     _ = "----------------------------Document successfully written!"
                }
            }
        }
    }
    
    func addTeacherAddress(address: String, faculty: String) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let dbReference = Firestore.firestore().collection("roomaddresss").document(currentUser.uid)
        dbReference.getDocument { (document, error) in
            guard let document = document, !document.exists else {
                return
            }
            let userToAdd = UserRole(email: currentUser.email, user_role: "user")
            dbReference.setData([
                "email": userToAdd.email as Any,
                "address": address,
                "faculty": faculty,
            ]) { err in
                if let err = err {
                    _ = "-----------------------------Error writing document: \(err)"
                } else {
                     _ = "----------------------------Document successfully written!"
                }
            }
        }
    }
    
}
