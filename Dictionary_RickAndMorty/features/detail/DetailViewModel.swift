//
//  DetailViewModel.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//

import Foundation

class DetailViewModel {
    
    private let repository: Repository
    
    private var favoriteModel: CharacterModel? = nil
    
    init(repository: Repository = RepositoryImpl()) {
        self.repository = repository
    }
    
    func loadFavorite(byId identifier: Int, completion: @escaping (Bool) -> Void){
        repository.retrieveFavorite(byId: identifier) { (result) in
            switch result {
            case.success(let model):
                self.favoriteModel = model
                completion(true)
                break
            case .failure(_):
                self.favoriteModel = nil
                completion(false)
                break
            }
        }
    }
    
    func toggleFavorite(model: CharacterModel, completion: @escaping (Bool) -> Void){
        if let favoriteModel = self.favoriteModel {
            repository.removeFavorite(byId: favoriteModel.id) { (result) in
                self.favoriteModel = nil
                completion(false)
            }
        }else{
            repository.saveFavorite(model: model) { (result) in
                self.favoriteModel = model
                completion(true)
            }
        }
    }
    
}
