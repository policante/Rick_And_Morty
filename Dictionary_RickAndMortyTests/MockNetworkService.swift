//
//  MockNetworkService.swift
//  Dictionary_RickAndMortyTests
//
//  Created by Rodrigo Martins on 09/11/20.
//

import Foundation
@testable import Dictionary_RickAndMorty

class MockNetworkService: NetworkManager {
   
    func performByApi<T>(api: Api, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        completion(.failure(.apiError))
        
    }
    
    func performByUrl<T>(url: String, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        completion(.failure(.apiError))
        
    }
    
}
