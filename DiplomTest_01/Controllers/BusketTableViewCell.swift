//
//  BusketTableViewCell.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 01.06.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit

class BusketTableViewCell: UITableViewCell {
    
    let mainImageView: UIImageView = {
        let iv = UIImageView()
        //iv.image = UIImage(named: "product16")
        return iv
    }()

    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Корзина пуста"
        lb.font = UIFont(name: "Noah-Bold", size: 20)
        lb.textAlignment = .left
        lb.textColor = .black
        return lb
    }()
    
    let categoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Добавьте товар из каталога"
        lb.font = UIFont(name: "Noah-Bold", size: 18)
        lb.textAlignment = .left
        lb.textColor = .darkGray
        return lb
    }()
    
    let priceLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = UIFont(name: "Noah-Bold", size: 18)
        lb.textAlignment = .left
        lb.textColor = .black
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addSubview(mainImageView)
        setupMainImageView()
        mainImageView.layer.cornerRadius = 6
        mainImageView.layer.masksToBounds = true
        
        addSubview(nameLabel)
        setupNameLabel()
        
        addSubview(categoryLabel)
        setupCategoryLabel()
        
        addSubview(priceLabel)
        setupPriceLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupMainImageView() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: 95).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 95).isActive = true
    }
    
    private func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    private func setupCategoryLabel() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 10).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        categoryLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 6).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
}
