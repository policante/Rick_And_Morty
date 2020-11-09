//
//  HomeViewModel.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//

import Foundation

class HomeViewModel {
    
    private let repository: Repository
    
    private var info: InfoModel?
    
    init(repository: Repository = RepositoryImpl()) {
        self.repository = repository
    }
    
    func fetchCharacters(completion: @escaping (Result<[CharacterModel], NetworkError>) -> Void){
        repository.retrieveCharacters { result in
            switch result {
            case .success(let model):
                self.info = model.info
                completion(.success(model.results))
                break
            case .failure(let error):
                self.info = nil
                completion(.failure(error))
                break
            }
        }
    }
    
    func fetchNextPage(completion: @escaping (Result<[CharacterModel], NetworkError>) -> Void){
        guard let nextPage = self.info?.next else {
            completion(.success([]))
            return
        }
        repository.retrieveCharacters(byNextPage: nextPage) { (result) in
            switch result {
            case .success(let model):
                self.info = model.info
                completion(.success(model.results))
                break
            case .failure(let error):
                self.info = nil
                completion(.failure(error))
                break
            }
        }
    }
    
}
