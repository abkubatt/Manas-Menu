//
//  MenuPerDay.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 26.03.23.
//

import Foundation


struct MenuPerDay: Codable {
    let id: Int
    let date: String
    let soupId: Int
    let withMeetId: Int
    let withoutMeetId: Int
    let dessertId: Int
    
    
    internal init(id: Int, date: String, soupId: Int, withMeetId: Int, withoutMeetId: Int, dessertId: Int) {
        self.id = id
        self.date = date
        self.soupId = soupId
        self.withMeetId = withMeetId
        self.withoutMeetId = withoutMeetId
        self.dessertId = dessertId
    }
}
