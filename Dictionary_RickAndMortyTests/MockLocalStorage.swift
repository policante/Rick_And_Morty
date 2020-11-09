//
//  MockLocalStorage.swift
//  Dictionary_RickAndMortyTests
//
//  Created by Rodrigo Martins on 09/11/20.
//

import Foundation
@testable import Dictionary_RickAndMorty

class MockLocalStorage: Storage {
    
    private var tempMemory: [Int: CharacterModel] = [:]
    
    func saveFavorite(model: CharacterModel, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        if let _ = tempMemory[model.id] {
            completion(.failure(.storageFail))
            return
        }
        tempMemory[model.id] = model
        completion(.success(true))
    }
    
    func removeFavorite(byId identifier: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        if let _ = tempMemory.removeValue(forKey: identifier){
            completion(.success(true))
            return
        }
        completion(.failure(.storageFail))
    }
    
    func retrieveFavorite(byId identifier: Int, completion: @escaping (Result<CharacterModel, NetworkError>) -> Void) {
        if let item = tempMemory[identifier] {
            completion(.success(item))
        }else{
            completion(.failure(.notFound))
        }
    }
    
    func retrieveFavorites(completion: @escaping (Result<[CharacterModel], NetworkError>) -> Void) {
        let values = tempMemory.values
        completion(.success(Array(values)))
    }
    
}
