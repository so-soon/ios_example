//
//  AnimalInfo.swift
//  CompanionAnimals
//
//  Created by soonhyuk on 2020/02/27.
//  Copyright © 2020 soonhyuk. All rights reserved.
//

import UIKit

struct AnimalInfo: Codable {
    let name: String
    let animalDescription: String
    let imageName: String
    
    static func decode(from assetName: String) -> AnimalInfo? {
        guard let asset: NSDataAsset = NSDataAsset(name: assetName) else{
            print("fail to load asset")
            return nil
        }
        
        do {
            let decoder: PropertyListDecoder = PropertyListDecoder()
            return try decoder.decode(AnimalInfo.self, from: asset.data)
        } catch {
            print("fail to decode data")
            print(error.localizedDescription)
            return nil
        }
    }
}
