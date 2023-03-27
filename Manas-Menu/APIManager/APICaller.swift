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


//struct Mennu: Codable {
//    let id: Int
//    let image: String
//    let name: String
//    let type: String
//    let calorie: Int
//}

class APICaller {
    static let shared = APICaller()
    // "https://drink.free.beeceptor.com/drink"
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
//        self.getttt { result in
//            print("---------------------------------------\(result)")
//        }
//        let menu = Mennu(id: 12, image: "udpated", name: "name up", type: "dinner", calorie: 312)
//        self.putRequest(url: URL(string: "http://192.168.241.114:8080/api/Menus/12")!, menu: menu) { res in
//            print("-------------------\(res)")
//        }
        
        
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
    
    func getAllMenuFood(completion: @escaping (Result<[Menu], Error>) -> Void) {
        guard let url = URL(string: "http://192.168.241.114:8080/api/Menus") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Menu].self, from: data)
                _ = "---------------------->>>>>>>>>>> \(results)"
//                print("---------------------->>>>>>>>>>> \(results)")
                completion(.success(results))
            }catch let error{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getAllMenusPerDay(completion: @escaping (Result<[MenuPerDay], Error>) -> Void) {
        guard let url = URL(string: "http://192.168.241.114:8080/api/OneDayMenus") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([MenuPerDay].self, from: data)
                _ = "---------------------->>>>>>>>>>> \(results)"
//                print("---------------------->>>>>>>>>>> \(results)")
                completion(.success(results))
            }catch let error{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func getAllCanteenFoods(completion: @escaping (Result<[Canteen], Error>) -> Void) {
        guard let url = URL(string: "http://192.168.241.114:8080/api/Canteens") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Canteen].self, from: data)
                _ = "---------------------->>>>>>>>>>> \(results)"
//                print("---------------------->>>>>>>>>>> \(results)")
                completion(.success(results))
            }catch let error{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func saveMenuFood(with menuFood: Menu, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = URL(string: "http://192.168.241.114:8080/api/Menus")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            let encoder = JSONEncoder()
            let httpBody = try encoder.encode(menuFood)
            request.httpBody = httpBody
        } catch {
            completion(.failure(error))
            return
        }
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let error = URLError(.badServerResponse)
                completion(.failure(error))
                return
            }
            guard let responseData = data else {
                let error = URLError(.badServerResponse)
                completion(.failure(error))
                return
            }
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                    // Handle the response JSON as needed.
                    // For example, you might extract an ID field and pass it to the completion handler.
                    if jsonResponse["id"] is Int {
                        completion(.success(true))
                    } else {
                        let error = URLError(.badServerResponse)
                        completion(.failure(error))
                    }
                } else {
                    let error = URLError(.badServerResponse)
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func saveMenuPerDay(with menuFood: MenuPerDay, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = URL(string: "http://192.168.241.114:8080/api/OneDayMenus")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            let encoder = JSONEncoder()
            let httpBody = try encoder.encode(menuFood)
            request.httpBody = httpBody
        } catch {
            completion(.failure(error))
            return
        }
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let error = URLError(.badServerResponse)
                completion(.failure(error))
                return
            }
            guard let responseData = data else {
                let error = URLError(.badServerResponse)
                completion(.failure(error))
                return
            }
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                    // Handle the response JSON as needed.
                    // For example, you might extract an ID field and pass it to the completion handler.
                    if jsonResponse["id"] is Int {
                        completion(.success(true))
                    } else {
                        let error = URLError(.badServerResponse)
                        completion(.failure(error))
                    }
                } else {
                    let error = URLError(.badServerResponse)
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
    
    func updateMenuFood(url: URL, menu: Menu, completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        do {
            let jsonData = try JSONEncoder().encode(menu)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                    return
                }

                if (200...299).contains(httpResponse.statusCode) {
                    completion(.success(()))
                } else {
                    let error = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error))
                }
            }
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateMenuPerDay(url: URL, menu: MenuPerDay, completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        do {
            let jsonData = try JSONEncoder().encode(menu)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                    return
                }

                if (200...299).contains(httpResponse.statusCode) {
                    completion(.success(()))
                } else {
                    let error = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error))
                }
            }
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }


    
    func delete(with deleteURL: String, completion: @escaping (Result<Bool, Error>) -> Void){
        guard let url = URL(string: "\(deleteURL)") else {
            // handle invalid URL
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
//                    print("statusCode: \(httpResponse.statusCode)")
                let statusCode = httpResponse.statusCode
                
                if (200...299).contains(httpResponse.statusCode) {
                    completion(.success(true))
//                    print("success")
                } else {
                    let error = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error as Error))
//                    print("error")
                }
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
//                print(error.localizedDescription)
                _ = error.localizedDescription
            }
        }
        task.resume()
    }
}
