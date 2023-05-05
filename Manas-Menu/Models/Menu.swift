//
//  Menu.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 10.03.23.
//

import Foundation
import FirebaseFirestoreSwift


struct Menu: Codable {
    let id: Int
    let image: String
    let name: String
    let type: String
    let calorie: Int
    
    internal init(id: Int, image: String, name: String, type: String, calorie: Int) {
        self.id = id
        self.image = image
        self.name = name
        self.type = type
        self.calorie = calorie
    }
}
