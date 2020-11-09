//
//  InfoModel.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 05/11/20.
//

import Foundation

struct InfoModel: Codable {
    
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    
}
