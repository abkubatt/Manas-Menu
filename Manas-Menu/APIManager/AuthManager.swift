//
//  AuthManager.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 28.01.23.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine


class AuthManager {
    
    static let shared = AuthManager()
    
    func registerUser(with email: String, password: String) -> AnyPublisher<User, Error> {
           return Auth.auth().createUser(withEmail: email, password: password)
               .map(\.user)
               .eraseToAnyPublisher()
       }
    
    func loginUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
//
//    public func userExists(with email: String,
//                           completion: @escaping ((Bool) -> Void)){
//        
//        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
//            guard snapshot.value as? String != nil else{
//                completion(false)
//                return
//            }
//            completion(true)
//        })
//    }
//
    
}
