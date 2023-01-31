//
//  StringExtension.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 31.01.23.
//


import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(0).uppercased() + self.lowercased().dropLast()
    }
}

