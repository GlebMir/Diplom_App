//
//  ModelsCollectionViewCell.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 09.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit

class ModelsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "ModelsCollectionViewCell"
    
    let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImageView)
        setUpMainImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpMainImageView() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainImageView.layer.cornerRadius = 10
        mainImageView.layer.masksToBounds = true
    }
    
    
}
