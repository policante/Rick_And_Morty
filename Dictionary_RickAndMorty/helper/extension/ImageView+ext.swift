//
//  ImageView+ext.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//

import UIKit

extension UIImageView {
    
    func loadImageByUrl(string path: String){
        if let url = URL(string: path), let data = try? Data(contentsOf: url) {
            self.image = UIImage(data: data)
        }else{
            self.image = nil
        }
    }
    
}
