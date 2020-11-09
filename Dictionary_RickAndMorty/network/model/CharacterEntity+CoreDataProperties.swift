//
//  CharacterEntity+CoreDataProperties.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 09/11/20.
//
//

import Foundation
import CoreData


extension CharacterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterEntity> {
        return NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
    }

    @NSManaged public var created: String?
    @NSManaged public var episode: [String]?
    @NSManaged public var gender: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?
    @NSManaged public var id: Int64
    @NSManaged public var location: CharacterLocationEntity?
    @NSManaged public var origin: CharacterOriginEntity?

}

extension CharacterEntity : Identifiable {

}
