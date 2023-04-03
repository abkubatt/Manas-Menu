//
//  RMCharacterDetailViewViewModel.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 05.02.23.
//

import Foundation


final class RMCharacterDetailViewViewModel {
    private var character: Menu
    
    init(character: Menu) {
        self.character = character
    }
    
    public var title: String{
        character.name.uppercased()
    }
}
