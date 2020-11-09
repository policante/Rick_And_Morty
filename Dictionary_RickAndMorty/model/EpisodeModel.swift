//
//  EpisodeModel.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 05/11/20.
//

import Foundation

struct EpisodeModel: Codable, Identifiable {
    
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
}
