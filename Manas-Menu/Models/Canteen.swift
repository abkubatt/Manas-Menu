//
//  Canteen.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 23.03.23.
//

import Foundation


struct Canteen: Codable {
    let id: Int
    let name: String
    let type: String
    let price: Int
    let image: String
    var amountForFree: Int
    
    internal init(id: Int, name: String, type: String, price: Int, image: String, amountForFree: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.price = price
        self.image = image
        self.amountForFree = amountForFree
    }
}
