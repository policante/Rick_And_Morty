//
//  LocalStorage.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 09/11/20.
//

import Foundation
import CoreData

protocol Storage {
    
    func saveFavorite(model: CharacterModel, completion: @escaping (Result<Bool, NetworkError>) -> Void)
    
    func removeFavorite(byId identifier: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void)
    
    func retrieveFavorite(byId identifier: Int, completion: @escaping (Result<CharacterModel, NetworkError>) -> Void)
 
    func retrieveFavorites(completion: @escaping (Result<[CharacterModel], NetworkError>) -> Void)
}

class LocalStorage: Storage {
    
    let container = AppDelegate.shared.persistentContainer
    
    func saveFavorite(model: CharacterModel, completion: @escaping (Result<Bool, NetworkError>) -> Void){
        
        let context = newContext()
        context.performAndWait {
            
            let entity = CharacterEntity(context: context)
            entity.id = Int64(model.id)
            entity.name = model.name
            entity.status = model.status
            entity.species = model.species
            entity.type = model.type
            entity.gender = model.gender
            entity.image = model.image
            entity.episode = model.episode
            entity.created = model.created
            
            let originEntity = CharacterOriginEntity(context: context)
            originEntity.name = model.origin.name
            originEntity.url = model.origin.url
            
            entity.origin = originEntity
            
            let locationEntity = CharacterLocationEntity(context: context)
            locationEntity.name = model.location.name
            locationEntity.url = model.location.url
            
            entity.location = locationEntity
            
            do {
                try context.save()
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }catch {
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(.storageFail))
                }
            }
        }
    }
    
    func removeFavorite(byId identifier: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        let context = newContext()
        context.performAndWait {
        
            let request: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", identifier)
            
            do {
                let entities = try context.fetch(request)
                entities.forEach { (item) in
                    context.delete(item)
                }
                
                try context.save()
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }catch {
                print(error)
                DispatchQueue.main.async {
                    completion(.success(false))
                }
            }
        }
    }
    
    func retrieveFavorite(byId identifier: Int, completion: @escaping (Result<CharacterModel, NetworkError>) -> Void){
        
        let context = container.viewContext
        let request: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id == %d", identifier)
        
        do {
            let entities = try context.fetch(request)
            if let firstModel = entities.first?.toModel() {
                DispatchQueue.main.async {
                    completion(.success(firstModel))
                }
                return
            }
        }catch {
            print(error)
        }
        DispatchQueue.main.async {
            completion(.failure(.notFound))
        }
    }
    
    func retrieveFavorites(completion: @escaping (Result<[CharacterModel], NetworkError>) -> Void){
        
        let context = container.viewContext
        let request: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
        
        do {
            let entities = try context.fetch(request)
            let results = entities.map { item in
                return item.toModel()
            }
            DispatchQueue.main.async {
                completion(.success(results))
            }
        }catch {
            print(error)
            DispatchQueue.main.async {
                completion(.failure(.notFound))
            }
        }
    }
    
    private func newContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.undoManager = nil
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
}
