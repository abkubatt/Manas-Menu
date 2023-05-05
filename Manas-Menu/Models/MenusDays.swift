//
//  MenusPerDay.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 05.05.23.
//

import Foundation


struct SingleMenu: Codable {
    let id: Int
    let image, name, type: String
    let calorie: Int
    internal init(id: Int, image: String, name: String, type: String, calorie: Int) {
        self.id = id
        self.image = image
        self.name = name
        self.type = type
        self.calorie = calorie
    }
}

struct MenusDays: Codable {
    let id: Int
    let date: String
    let menus: [Menu]
}
typealias MainStruct = [MenusDays]
