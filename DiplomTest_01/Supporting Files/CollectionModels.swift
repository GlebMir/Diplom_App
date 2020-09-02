//
//  CollectionModels.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 08.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit

class CollectionModels {
    
    var title = ""
    var featuredImage: UIImage
    var color: UIColor
    
    init(title: String, featuredImage: UIImage, color: UIColor ) {
        self.title = title
        self.featuredImage = featuredImage
        self.color = color
    }
    
    static func fetchModels() -> [CollectionModels] {
        return [CollectionModels(title: "Welcome to our Site, Hello World1",                    featuredImage: UIImage(named: "models")!, color: .red),
                CollectionModels(title: "Welcome to our Site, Hello World1", featuredImage: UIImage(named: "models")!, color: .red),
                CollectionModels(title: "Welcome to our Site, Hello World1", featuredImage: UIImage(named: "models")!, color: .red),
                CollectionModels(title: "Welcome to our Site, Hello World1", featuredImage: UIImage(named: "models")!, color: .red)]
        
    }
    
}
