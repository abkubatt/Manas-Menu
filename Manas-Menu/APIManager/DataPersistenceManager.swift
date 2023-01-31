//
//  DataPersistenceManager.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 31.01.23.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DataBaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
//    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void){
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
//            return
//        }
//
//        let context = appDelegate.persistentContainer.viewContext
//
//        let item = TitleItem(context: context)
//
//        item.id = Int64(model.id)
//        item.original_title = model.original_title
//        item.vote_count = Int64(model.vote_count)
//        item.original_name = model.original_name
//        item.overview = model.overview
//        item.vote_average = model.vote_average
//        item.poster_path = model.poster_path
//        item.media_type = model.media_type
//        item.release_date = model.release_data
//
//
//        do{
//            try context.save()
//            completion(.success(()))
//        }catch{
//            completion(.failure(DataBaseError.failedToSaveData))
//        }
//    }
//
//    func fetchingTitlesFromDataBase(completion: @escaping (Result<[TitleItem], Error>) -> Void){
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//
//        let context = appDelegate.persistentContainer.viewContext
//
//        let request: NSFetchRequest<TitleItem>
//
//        request = TitleItem.fetchRequest()
//
//        do{
//
//            let titles = try context.fetch(request)
//            completion(.success(titles))
//        }catch{
//            completion(.failure(DataBaseError.failedToFetchData))
//        }
//    }
//    
//    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void){
//        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//        
//        let context = appDelegate.persistentContainer.viewContext
//        
//        context.delete(model)
//        
//        do{
//            try context.save()
//            completion(.success(()))
//        }catch{
//            completion(.failure(DataBaseError.failedToDeleteData))
//        }
//    }
}

