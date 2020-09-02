//
//  ProductCell.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 08.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    var productImageView = UIImageView()
    var productNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(productImageView)
        addSubview(productNameLabel)
        
        setUpImageView()
        setUpNameLabel()
        
        configureImageView()
        configureNameLabel()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(imageName: String, text: String) {
        productImageView.image = UIImage(named: imageName)
        productNameLabel.text = text
    }
    
    
    private func configureImageView() {
        productImageView.layer.cornerRadius = 10
        productImageView.layer.masksToBounds = true
        
    }
    
    
    private func configureNameLabel() {
        productNameLabel.numberOfLines = 0
        productNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setUpImageView() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor, multiplier: 16/9).isActive = true
        
    }
    
    private func setUpNameLabel() {
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20).isActive = true
        productNameLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }
    

}
