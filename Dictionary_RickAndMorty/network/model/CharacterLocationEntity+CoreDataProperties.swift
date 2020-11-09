//
//  CharacterLocationEntity+CoreDataProperties.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//
//

import Foundation
import CoreData


extension CharacterLocationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterLocationEntity> {
        return NSFetchRequest<CharacterLocationEntity>(entityName: "CharacterLocationEntity")
    }

    @NSManaged public var url: String?
    @NSManaged public var name: String?

}

extension CharacterLocationEntity : Identifiable {

}
