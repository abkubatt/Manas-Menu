//
//  Menus.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 11.03.23.
//

import Foundation
import FirebaseFirestoreSwift


struct Menus: Codable {
    @DocumentID var id: String?
    var dateOfMenu: String?
    var menu: Menu
    
    
    init(id: String? = nil, dateOfMenu: String? = nil, menu: Menu) {
        self.id = id
        self.dateOfMenu = dateOfMenu
        self.menu = menu
    }
}
