//
//  CharacterOriginEntity+CoreDataProperties.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//
//

import Foundation
import CoreData


extension CharacterOriginEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterOriginEntity> {
        return NSFetchRequest<CharacterOriginEntity>(entityName: "CharacterOriginEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?

}

extension CharacterOriginEntity : Identifiable {

}
