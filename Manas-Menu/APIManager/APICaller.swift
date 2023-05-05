//
//  APICaller.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 31.01.23.
//


import Foundation

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    func getTrendingMovies(completion: @escaping (Result<[Canteen], Error>) -> Void) {
        guard let url = URL(string: "http://\(Constant.IP):5000/api/Canteens/GetDrinks") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Canteen].self, from: data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getAllMenuFood(with url: String, completion: @escaping (Result<[Menu], Error>) -> Void) {
        guard let url = URL(string: "\(url)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Menu].self, from: data)
                _ = "---------------------->>>>>>>>>>> \(results)"
                completion(.success(results))
            }catch let error{
                completion(.failure(error))
            }
        }
        task.resume()
    }
   
    
    
    func getAllMenusPerDay(completion: @escaping (Result<MainStruct, Error>) -> Void) {
        guard let url = URL(string: "http://\(Constant.IP):5000/api/OneDayMenus") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(MainStruct.self, from: data)
                _ = "---------------------->>>>>>>>>>> \(results)"
                completion(.success(results))
            }catch let error{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func getAllCanteenFoods(completion: @escaping (Result<[Canteen], Error>) -> Void) {
        guard let url = URL(string: "http://\(Constant.IP):5000/api/Canteens") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Canteen].self, from: data)
                _ = "---------------------->>>>>>>>>>> \(results)"
                completion(.success(results))
            }catch let error{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getAllFreeFoods(completion: @escaping (Result<[Canteen], Error>) -> Void) {
        guard let url = URL(string: "http://\(Constant.IP):5000/api/Canteens/GetFreeFoods") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Canteen].self, from: data)
                _ = "---------------------->>>>>>>>>>> \(results)"
                completion(.success(results))
            }catch let error{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func saveMenuFood(with menuFood: Menu, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = URL(string: "http://\(Constant.IP):5000/api/Menus")!
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
        let url = URL(string: "http://\(Constant.IP):5000/api/OneDayMenus")!
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

    func saveCanteenFood(with canteenFood: Canteen, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = URL(string: "http://\(Constant.IP):5000/api/Canteens")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            let encoder = JSONEncoder()
            let httpBody = try encoder.encode(canteenFood)
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
    
    func updateCanteenFood(url: URL, canteen: Canteen, completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        do {
            let jsonData = try JSONEncoder().encode(canteen)
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
    
    func updateFreeFood(canteen: Canteen, id: Int, amount: Int,completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: URL(string:"http://\(Constant.IP):5000/api/Canteens/FreeFood?id=\(id)&amount=\(amount)")!)
    
        request.httpMethod = "PUT"

        do {
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
                let statusCode = httpResponse.statusCode
                
                if (200...299).contains(httpResponse.statusCode) {
                    completion(.success(true))
                } else {
                    let error = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error as Error))
                }
            }
        }
        
        task.resume()
    }





    
    //"https://drink.free.beeceptor.com/desserts"
    func getDesserts(completion: @escaping (Result<[Canteen], Error>) -> Void) {
        guard let url = URL(string: "http://\(Constant.IP):5000/api/Canteens/GetDesserts") else {return}
        //https://abkubatt.free.beeceptor.com/desserts
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Canteen].self, from: data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getFreeFoods(completion: @escaping (Result<[Canteen], Error>) -> Void) {
        guard let url = URL(string: "http://\(Constant.IP):5000/api/Canteens/GetFreeFoods") else {return}
        //https://abkubatt.free.beeceptor.com/desserts
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Canteen].self, from: data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getMenus(completion: @escaping (Result<[MenusPerDay], Error>) -> Void) {
        guard let url = URL(string: "http://localhost:5000/api/OneDayMenus") else {return}
        //https://abkubatt.free.beeceptor.com/desserts
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([MenusPerDay].self, from: data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    


    
    // "https://abkubatt.free.beeceptor.com/bakerproducts
    func getBakeryProducts(completion: @escaping (Result<[Canteen], Error>) -> Void) {
        guard let url = URL(string: "http://\(Constant.IP):5000/api/Canteens/GetBakeryProducts") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Canteen].self, from: data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getOtherFoods(completion: @escaping (Result<[Canteen], Error>) -> Void) {
        guard let url = URL(string: "http://\(Constant.IP):5000/api/Canteens/GetOtherFoods") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Canteen].self, from: data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // https://manas.free.beeceptor.com/pizzaandpides
    func getPaP(completion: @escaping (Result<[Canteen], Error>) -> Void) {
        guard let url = URL(string: "http://\(Constant.IP):5000/api/Canteens/GetPaP") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode([Canteen].self, from: data)
                completion(.success(results))
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
                _ = error.localizedDescription
            }
        }
        task.resume()
    }
}
