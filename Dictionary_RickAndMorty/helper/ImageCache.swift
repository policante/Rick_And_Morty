//
//  ImageCache.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    
    private init(){}
    
    private lazy var decodedCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 1024 * 1024 * 100
        return cache
    }()
    
    private let lock = NSLock()
    
    func image(string path: String) -> UIImage? {
        lock.lock()
        defer {
            lock.unlock()
        }
        
        guard let url = URL(string: path) else {
            return nil
        }
        
        if let img = decodedCache.object(forKey: url as AnyObject) as? UIImage {
            return img
        }
        
        if let data = try? Data(contentsOf: url) {
            let decodedImage = UIImage(data: data)
            decodedCache.setObject(decodedImage as AnyObject, forKey: url as AnyObject)
            return decodedImage
        }
        
        return nil
    }
    
}
