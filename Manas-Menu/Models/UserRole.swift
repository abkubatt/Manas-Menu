//
//  UserRole.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 16.03.23.
//

import Foundation


struct UserRole: Codable {
    let email: String?
    let user_role: String?
    
    
    init(email: String? = nil, user_role: String? = nil) {
        self.email = email
        self.user_role = user_role
    }
}
