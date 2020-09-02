//
//  ExtentionsUIVIew.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 05.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    func add(subview: UIView, createConstraints: (_ view: UIView, _ parent: UIView) -> ([NSLayoutConstraint])) {
        addSubview(subview)
        
        subview.activate(constraints: createConstraints(subview, self))
    }
    
    func activate(constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func addSeparatorLine(color: UIColor) {
        let view = UIView()
        view.backgroundColor = color
        if #available(iOS 9.0, *) {
            add(subview: view) { (v, p) in [
                v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
                v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
                v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
                v.heightAnchor.constraint(equalToConstant: 0.5)
                ]}
        }
    }
}
