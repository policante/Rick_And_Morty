//
//  NetworkManager.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 05/11/20.
//

import Foundation


enum Api {
    case characters(Int? = nil)
    case locations
    case episodes(Int? = nil, EpisodeFilter? = nil)
    
    var path: String {
        switch self {
        case .characters(let id):
            var param = ""
            if let id = id {
                param = "/\(id)"
            }
            return "/character" + param
        case .locations:
            return "/location"
        case .episodes(let id, _):
            var param = ""
            if let id = id {
                param = "/\(id)"
            }
            return "/episode" + param
        }
    }
    
    var query: String?{
        var component = URLComponents(string: "")
        var items: [URLQueryItem] = []
        
        switch self {
        case .episodes(_, let filter):
            filter?.toDictionary()?.forEach({ (key, value) in
                if let safeValue = value as? String {
                    items.append(URLQueryItem(name: key, value: safeValue))
                }else if let safeValue = value as? Int {
                    items.append(URLQueryItem(name: key, value: String(safeValue)))
                }
            })
            break
        default:
            return nil
        }
        
        component?.queryItems = items
        let encodedQuery = component?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        component?.percentEncodedQuery = encodedQuery
        return component?.query
    }
}

protocol NetworkManager {
    
    func performByApi<T: Decodable>(api: Api, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
    
    func performByUrl<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkManagerImpl: NetworkManager {
    
    static let shared: NetworkManager = NetworkManagerImpl()
    
    private init(){}
    
    func performByApi<T: Decodable>(api: Api, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void){
        let baseUrl = ConfigApp.apiBaseUrl + api.path
        var component = URLComponents(string: baseUrl)
        if let query = api.query {
            component?.query = query
        }
        performByUrl(url: component?.url?.absoluteString ?? "", type: type, completion: completion)
    }
    
    func performByUrl<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void){
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        print("URL FETCH: \(url)")
        fetchData(url: url) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidResponse))
                    }
                    return
                }
                
                guard let result: T = self.decodeJSONData(data: data) else {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    completion(.failure(.apiError))
                }
                break
            }
        }
    }
    
    private func decodeJSONData<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
    private func fetchData(url: URL, completion: @escaping (_ result: Result<(URLResponse, Data), Error>) -> Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            completion(.success((response, data)))
        }
        task.resume()
        
    }
    
}
