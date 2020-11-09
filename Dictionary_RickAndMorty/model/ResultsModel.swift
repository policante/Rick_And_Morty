//
//  ResultsModel.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 05/11/20.
//

import Foundation

struct ResultsModel<T: Codable>: Codable {
    
    let info: InfoModel
    let results: [T]
    
}
