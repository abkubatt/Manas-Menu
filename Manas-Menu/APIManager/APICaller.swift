//
//  APICaller.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 31.01.23.
//

import Foundation

import Foundation

enum APIError: Error {
    case failedToGetData
}

struct Constant {
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeAPI_KEY = "AIzaSyDp5RXNUArtwoGXFA05zM9zi-_JgjiOGcY"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

class APICaller {
    static let shared = APICaller()
    // "https://drink.free.beeceptor.com/drink"
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "https://abkubatt.free.beeceptor.com/drinks") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    //"https://drink.free.beeceptor.com/desserts"
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "https://freef.free.beeceptor.com/free") else {return}
        //https://abkubatt.free.beeceptor.com/desserts
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // "https://abkubatt.free.beeceptor.com/bakerproducts
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "https://abkubatt.free.beeceptor.com/bakers") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "https://abkubatt.free.beeceptor.com/others") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // https://manas.free.beeceptor.com/pizzaandpides
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "https://abkubatt.free.beeceptor.com/pizzaandpide") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constant.baseURL)/3/discover/movie?api_key=\(Constant.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) else {return}
        guard let url = URL(string: "\(Constant.baseURL)/3/search/movie?api_key=\(Constant.API_KEY)&query=\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constant.youtubeBaseURL)q=\(query)&key=\(Constant.youtubeAPI_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            }catch{
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
