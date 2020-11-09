//
//  NSAttributedString+ext.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 09/11/20.
//

import UIKit

extension NSMutableAttributedString {
    
    func bold(_ value: String, size: CGFloat) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: size, weight: .bold)
        ]
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func regular(_ value: String, size: CGFloat) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: size)
        ]
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func newLine() -> NSMutableAttributedString {
        self.append(NSAttributedString(string: "\n"))
        return self
    }
    
}
