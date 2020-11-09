//
//  AppDelegate+ext.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 09/11/20.
//

import UIKit

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

