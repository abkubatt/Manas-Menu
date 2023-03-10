//
//  Menu.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 10.03.23.
//

import Foundation
import FirebaseFirestoreSwift

struct Menu: Codable {
    @DocumentID var id: String?
    var name: String?
    var calorie: String?
    var image: String?
    
    init(id: String? = nil, name: String? = nil, calorie: String? = nil, image: String? = nil) {
        self.id = id
        self.name = name
        self.calorie = calorie
        self.image = image
    }
   
}
