//
//  Repository.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 09/11/20.
//

import Foundation

protocol Repository {
    
    func saveFavorite(model: CharacterModel, completion: @escaping (Result<Bool, NetworkError>) -> Void)
    
    func removeFavorite(byId identifier: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void)
    
    func retrieveFavorite(byId identifier: Int, completion: @escaping (Result<CharacterModel, NetworkError>) -> Void)
    
    func retrieveFavorites(completion: @escaping (Result<[CharacterModel], NetworkError>) -> Void)
    
    func retrieveCharacters(completion: @escaping (Result<ResultsModel<CharacterModel>, NetworkError>) -> Void)
    
    func retrieveCharacters(byNextPage url: String, completion: @escaping (Result<ResultsModel<CharacterModel>, NetworkError>) -> Void)
    
}

class RepositoryImpl: Repository {

    private let network: NetworkManager
    private let disk: Storage
    
    func saveFavorite(model: CharacterModel, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        disk.saveFavorite(model: model, completion: completion)
    }
    
    func removeFavorite(byId identifier: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        disk.removeFavorite(byId: identifier, completion: completion)
    }
    
    func retrieveFavorite(byId identifier: Int, completion: @escaping (Result<CharacterModel, NetworkError>) -> Void) {
        disk.retrieveFavorite(byId: identifier, completion: completion)
    }
    
    func retrieveFavorites(completion: @escaping (Result<[CharacterModel], NetworkError>) -> Void) {
        disk.retrieveFavorites(completion: completion)
    }
    
    func retrieveCharacters(completion: @escaping (Result<ResultsModel<CharacterModel>, NetworkError>) -> Void) {
        network.performByApi(api: .characters(), type: ResultsModel<CharacterModel>.self, completion: completion)
    }
    
    func retrieveCharacters(byNextPage url: String, completion: @escaping (Result<ResultsModel<CharacterModel>, NetworkError>) -> Void) {
        network.performByUrl(url: url, type: ResultsModel<CharacterModel>.self, completion: completion)
    }
    
    init(network: NetworkManager = NetworkManagerImpl.shared,
         disk: Storage = LocalStorage()) {
        self.network = network
        self.disk = disk
    }
    
}
