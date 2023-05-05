//
//  RMRequest.swift
//  Manas-Menu
//
//  Created by Abdulmajit Kubatbekov on 05.02.23.
//

import Foundation
import UIKit


final class RMRequest {
    
    private struct Constants {
        static let baseURL  = "https://rickandmortyapi.com/api"
    }
    
    private let endpoint: RMEndpoint
    
    private let pathComponents: [String]
        
    private let queryParameters: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseURL
        
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty{
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string = "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    private func currentDate()-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
        
    
    public var url: URL? {
        return URL(string: "http://localhost:5000/api/OneDayMenus/\(currentDate())")
    }
    
    public let httpMethod = "GET"
    public init(
        endpoint: RMEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
}
