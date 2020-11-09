//
//  CharacterModel.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//

import Foundation

struct CharacterModel: Codable, Identifiable {
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOriginModel
    let location: CharacterLocationModel
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

extension CharacterEntity {
    
    func toModel() -> CharacterModel {
        return CharacterModel(id: Int(id),
                              name: name ?? "",
                              status: status ?? "",
                              species: species ?? "",
                              type: type ?? "",
                              gender: gender ?? "",
                              origin: CharacterOriginModel(name: origin?.name ?? "",
                                                           url: origin?.url ?? ""),
                              location: CharacterLocationModel(name: location?.name ?? "",
                                                               url: location?.url ?? ""),
                              image: image ?? "",
                              episode: episode ?? [],
                              url: url ?? "",
                              created: created ?? "")
    }
    
}

struct CharacterOriginModel: Codable {
    
    let name: String
    let url: String
    
}

struct CharacterLocationModel: Codable {
    
    let name: String
    let url: String
    
}
