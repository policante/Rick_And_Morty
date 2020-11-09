//
//  NetworkError.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 05/11/20.
//

import Foundation

enum NetworkError: Error {
    
    case invalidUrl
    case invalidResponse
    case apiError
    case decodingError
    case storageFail
    case notFound
    
}
