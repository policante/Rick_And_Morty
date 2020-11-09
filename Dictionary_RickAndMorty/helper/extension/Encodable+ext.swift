//
//  Encodable+ext.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 05/11/20.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
