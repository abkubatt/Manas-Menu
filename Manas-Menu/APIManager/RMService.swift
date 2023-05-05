//
//  RMService.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 05.02.23.
//

import Foundation


final class RMService {
    static let shared = RMService()
    
    private init() {}
    
    enum RMSerivceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        guard let urlRequest = self.request(from: request) else{
            completion(.failure(RMSerivceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? RMSerivceError.failedToGetData))
                return
            }
            do{
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    

    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else{
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
