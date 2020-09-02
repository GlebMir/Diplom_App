//
//  ProfileTableViewCell.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 14.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        bounds = bounds.inset(by: padding)
    }
    
    
    let mainImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Мой профиль"
        label.font = UIFont(name: "Noah-Regular", size: 17)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        
        addSubview(mainImageView)
        setupMainImageView()
        
        addSubview(descriptionLabel)
        setupDescriptionLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMainImageView() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: 38).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 23).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 39).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    
    
    
}
