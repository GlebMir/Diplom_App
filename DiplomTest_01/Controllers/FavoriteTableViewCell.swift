//
//  FavoriteTableViewCell.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 12.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import SwiftyButton

class FavoriteTableViewCell: UITableViewCell {
    
    
    
    let mainImage: UIImageView = {
        let iv = UIImageView()
       // iv.image = UIImage(named: "internal-like-false")
        return iv
    }()
    
    let nameProductLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Список пуст"
        lb.font = UIFont(name: "Noah-Bold", size: 17)
        lb.textAlignment = .left
        lb.textColor = .black
        return lb
    }()
    
    let priceProductLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.font = UIFont(name: "Noah-Bold", size: 17)
        lb.textAlignment = .left
        lb.textColor = .black
        return lb
    }()
    
    let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Добавьте товар из каталога"
        tv.textAlignment = .left
        tv.textColor = .darkGray
        tv.font = UIFont(name: "Noah-Regular", size: 15)
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = false
    
        return tv
    }()
    
    let toBuyButton: FlatButton = {
        let button = FlatButton(type: .custom)
        button.setTitle("Добавить в корзину", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Noah-Bold", size: 12)
        button.color = .white
        button.highlightedColor = .orange
        button.selectedColor = .purple
        button.setTitleColor(.white, for: .highlighted)
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(mainImage)
        setupMainImage()
        
        addSubview(nameProductLabel)
        setupNameLabel()
        
        addSubview(descriptionTextView)
        setupDescriptionTextView()
        
        addSubview(priceProductLabel)
        setupPriceLabel()
        
        addSubview(toBuyButton)
        setupToBuyButton()
        
        toBuyButton.addBorder(side: .top, color: .orange, width: 2)
        toBuyButton.addBorder(side: .left, color: .orange, width: 2)
        toBuyButton.addBorder(side: .right, color: .orange, width: 2)
        toBuyButton.addBorder(side: .bottom, color: .orange, width: 2)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupMainImage() {
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 7).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mainImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        mainImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
    }
    
    private func setupNameLabel() {
        nameProductLabel.translatesAutoresizingMaskIntoConstraints = false
        nameProductLabel.leftAnchor.constraint(equalTo: mainImage.rightAnchor, constant: 7).isActive = true
        nameProductLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameProductLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        nameProductLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func setupDescriptionTextView() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.leftAnchor.constraint(equalTo: mainImage.rightAnchor, constant: 5).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -9).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: nameProductLabel.bottomAnchor, constant: -8).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    
    private func setupPriceLabel() {
        priceProductLabel.translatesAutoresizingMaskIntoConstraints = false
        priceProductLabel.leftAnchor.constraint(equalTo: mainImage.rightAnchor, constant: 7).isActive = true
        priceProductLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        priceProductLabel.topAnchor.constraint(equalTo: nameProductLabel.bottomAnchor, constant: 20).isActive = true
        priceProductLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    
    private func setupToBuyButton() {
        toBuyButton.translatesAutoresizingMaskIntoConstraints = false
        toBuyButton.leftAnchor.constraint(equalTo: mainImage.rightAnchor, constant: 7).isActive = true
        toBuyButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        toBuyButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 0).isActive = true
        toBuyButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
    }
    
    
    
}


public enum BorderSide {
    case top, bottom, left, right
}

extension UIView {
    public func addBorder(side: BorderSide, color: UIColor, width: CGFloat) {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = color
        self.addSubview(border)

        let topConstraint = topAnchor.constraint(equalTo: border.topAnchor)
        let rightConstraint = trailingAnchor.constraint(equalTo: border.trailingAnchor)
        let bottomConstraint = bottomAnchor.constraint(equalTo: border.bottomAnchor)
        let leftConstraint = leadingAnchor.constraint(equalTo: border.leadingAnchor)
        let heightConstraint = border.heightAnchor.constraint(equalToConstant: width)
        let widthConstraint = border.widthAnchor.constraint(equalToConstant: width)


        switch side {
        case .top:
            NSLayoutConstraint.activate([leftConstraint, topConstraint, rightConstraint, heightConstraint])
        case .right:
            NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, widthConstraint])
        case .bottom:
            NSLayoutConstraint.activate([rightConstraint, bottomConstraint, leftConstraint, heightConstraint])
        case .left:
            NSLayoutConstraint.activate([bottomConstraint, leftConstraint, topConstraint, widthConstraint])
        }
    }
}



