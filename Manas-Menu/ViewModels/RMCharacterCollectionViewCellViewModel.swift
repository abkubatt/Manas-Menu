//
//  RMCharacterCollectionViewCellViewModel.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 05.02.23.
//

import Foundation


final class RMCharacterCollectionViewCellViewModel{
    
    public let characterName: String
    private let characterStatus: String
    private let characterImageUrl: URL?
    
    init(characterName: String, CharacterStatuss: String, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = CharacterStatuss
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText: String{
        return "Calories: \(characterStatus)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = characterImageUrl else{
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
        
    }
    
}
