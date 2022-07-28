//
//  NetworkModel.swift
//  DesignPatterns
//
//  Created by Nicolas on 25/07/22.
//

import Foundation

final class NetworkModel {
      
    static let shared = NetworkModel()
    
    var heroes: [HeroModel] = []
    
    private init() {}
    
    private func networkCall(
        uri: String,
        method: String,
        authentication: String,
        credentials: String,
        jsonRequest: Bool,
        body: Data?,
        completion: @escaping (Data?, NetworkError?) -> Void
    ) {
        
        guard let url = URL(string: uri) else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.setValue("\(authentication) \(credentials)", forHTTPHeaderField: "Authorization")
        
        if jsonRequest {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = body
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                completion(nil, NetworkError.errorResponse)
                return
            }
          
            if let httpResponse = (response as? HTTPURLResponse) {
                if httpResponse.statusCode == 401 {
                    completion(data, NetworkError.notAuthenticated)
                    return
                }
                guard httpResponse.statusCode == 200 else {
                    completion(data, NetworkError.errorCode((response as? HTTPURLResponse)?.statusCode))
                    return
                }
            }
            
            completion(data, nil)
            
        }
        
        task.resume()
    }
    
    
    func getHeroes(name: String = "", completion: @escaping ([HeroModel], String?) -> Void) {
        
        struct Body: Encodable {
          let name: String
        }
        
        let body = try? JSONEncoder().encode(Body(name: name))
        
        networkCall(
            uri: ApiURL.HEROS_ALL,
            method: "POST",
            authentication: "Bearer",
            credentials: ApiURL.TOKEN,
            jsonRequest: true,
            body: body) { data, error in
                
                guard error == nil else {
                    completion([],"Network Error")
                    return
                }
              
                guard let data = data else {
                    completion([],"Network Error Response")
                    return
                }
                
                guard let heroesResponse = try? JSONDecoder().decode([HeroModel].self, from: data) else {
                  completion([], "Internal Error")
                  return
                }
                let response = heroesResponse.sorted(by: { $0.name < $1.name })
                completion(response, nil)
            }
    }
    
}
