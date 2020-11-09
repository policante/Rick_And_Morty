//
//  FavoriteViewModel.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//

import Foundation

class FavoriteViewModel {

    private let repository: Repository
    
    init(repository: Repository = RepositoryImpl()) {
        self.repository = repository
    }
    
    func loadFavorites(completion: @escaping ([CharacterModel]) -> Void){
        repository.retrieveFavorites { (result) in
            switch result {
            case.success(let model):
                completion(model)
                break
            case .failure(_):
                completion([])
                break
            }
        }
    }
    
}
