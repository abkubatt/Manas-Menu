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

struct Canten: Codable {
    let id: Int
    let name: String
    let type: String
    let price: Int
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
        
        self.delete()
        
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
    
   

    func postRequest() {

      // declare the parameter as a dictionary that contains string as key and value combination. considering inputs are valid

//      let parameters: [String: Any] = ["id": 13, "name": "jack"]

      // create the url with URL
      let url = URL(string: "http://192.168.241.114:8080/api/Menus")! // change server url accordingly

      // create the session object
      let session = URLSession.shared

      // now create the URLRequest object using the url object
      var request = URLRequest(url: url)
      request.httpMethod = "PUT" //set http method as POST

      // add headers for the request
      request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
      request.addValue("application/json", forHTTPHeaderField: "Accept")
        let menu = Menu(id: 12, image: "Abdulmajit IMAGE", name: "ASH", type: "Main", calorie: 234)

      do {
        // convert parameters to Data and assign dictionary to httpBody of request
//        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
          let encoder = JSONEncoder()
              guard let httpBody = try? encoder.encode(menu) else {
                  return
              }
              request.httpBody = httpBody
      } catch let error {
          _  = error.localizedDescription
//        print(error.localizedDescription)
        return
      }

      // create dataTask using the session object to send data to the server
      let task = session.dataTask(with: request) { data, response, error in

        if let error = error {
            _ = "Post Request Error: \(error.localizedDescription)"
//          print("Post Request Error: \(error.localizedDescription)")
          return
        }

        // ensure there is valid response code returned from this HTTP response
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
            _ = "Invalid Response received from the server"
//          print("Invalid Response received from the server")
          return
        }

        // ensure there is data returned
        guard let responseData = data else {
            _ = "nil Data received from the server"
//          print("nil Data received from the server")
          return
        }

        do {
          // create json object from data or use JSONDecoder to convert to Model stuct
          if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
              _ = jsonResponse
//            print(jsonResponse)
            // handle json response
          } else {
            print("data maybe corrupted or in wrong format")
            throw URLError(.badServerResponse)
          }
        } catch let error {
            _ = error.localizedDescription
//          print(error.localizedDescription)
        }
      }
      // perform the task
      task.resume()
    }
    
    
    
    func putRequest(url: URL, menu: Menu, completion: @escaping (Result<Void, Error>) -> Void) {
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
    func delete(){
        
        
        guard let url = URL(string: "http://192.168.241.114:8080/api/Menus/7") else {
            // handle invalid URL
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                _ = "statusCode: \(httpResponse.statusCode)"
//                    print("statusCode: \(httpResponse.statusCode)")
                
                
                if (200...299).contains(httpResponse.statusCode) {
//                    completion(.success(()))
                    _ = "success"
//                    print("success")
                } else {
                    let error = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
//                    completion(.failure(error))
                    _ = "error \(error)"
//                    print("error \(error)")
                }
            }
        }
        
        task.resume()
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
