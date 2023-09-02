//
//  ApiManager.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import Foundation

enum DataError: Error {
    case invalidData
    case invalidResponse
    case invalidURL
    case network(Error?)
}

typealias Handler = (Result<ApiResponse, DataError>) -> ()

final class ApiManager {
    static let shared = ApiManager()
    ///Object can be made only inside this class.
    private init() {}
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        // Add more HTTP methods as needed
    }

    func fetch<T: Decodable>(url: URL, method: HTTPMethod = .get, parameters: [String: Any]? = nil, completion: @escaping (Result<T, DataError>) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
                
        // Add parameters to the request if provided
        if let parameters = parameters {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            } catch {
                completion(.failure(.network(error)))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }

    

    

    
}
