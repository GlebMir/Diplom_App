//
//  PageCell.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 09.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    
    let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    let topLabelText: UILabel = {
        let lb = UILabel()
        lb.text = "Летняя коллекция"
        lb.font = UIFont(name: "MontDemo-Heavy", size: 16)
        lb.textAlignment = .center
        lb.textColor = .white
        return lb
    }()
    
    let saleLabelText: UILabel = {
        let lb = UILabel()
        lb.text = "20％ OFF"
        lb.font = UIFont(name: "MontDemo-Heavy", size: 50)
        lb.textAlignment = .center
        lb.textColor = .white
        return lb
    }()
    
   private let lineView: UIView = {
        let lv = UIView()
        
        return lv
    }()
    
    let descriptionLabelText: UILabel = {
        let lb = UILabel()
        lb.text = "Модные шорты для летнего сезона, успей купить скорее"
        lb.font = UIFont(name: "Noah-Bold", size: 20)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .white
        return lb
        
    }()
    
    
    private let likeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "shop-top2")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let shopImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "shop-top3")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let toBuyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Купить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Noah-Regular", size: 18)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImageView)
        setupMainImageView()
        addSubview(topLabelText)
        setupTopLabelText()
        addSubview(saleLabelText)
        setupSaleLabelText()
        addSubview(lineView)
        setupLineView()
        addSubview(descriptionLabelText)
        setupDescriptionLabelText()
        addSubview(shopImageView)
        setupShopImageView()
        addSubview(likeImageView)
        setupLikeImageView()
        
        addSubview(toBuyButton)
        setupBuyButton()
        
        
        
      
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
    
    
    private func setupMainImageView() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupTopLabelText() {
        topLabelText.translatesAutoresizingMaskIntoConstraints = false
        topLabelText.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        topLabelText.widthAnchor.constraint(equalToConstant: 180).isActive = true
        topLabelText.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        topLabelText.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupSaleLabelText() {
        saleLabelText.translatesAutoresizingMaskIntoConstraints = false
        saleLabelText.leftAnchor.constraint(equalTo: leftAnchor, constant: 17).isActive = true
        saleLabelText.widthAnchor.constraint(equalToConstant: 250).isActive = true
        saleLabelText.topAnchor.constraint(equalTo: topLabelText.bottomAnchor, constant: 10).isActive = true
        saleLabelText.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 45).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 125).isActive = true
        lineView.topAnchor.constraint(equalTo: topLabelText.bottomAnchor, constant: 5).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.backgroundColor = .white
    }
    
    private func setupDescriptionLabelText() {
        descriptionLabelText.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabelText.leftAnchor.constraint(equalTo: leftAnchor, constant: 17).isActive = true
        descriptionLabelText.widthAnchor.constraint(equalToConstant: 350).isActive = true
        descriptionLabelText.topAnchor.constraint(equalTo: saleLabelText.bottomAnchor, constant: 0).isActive = true
        descriptionLabelText.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupShopImageView(){
        shopImageView.translatesAutoresizingMaskIntoConstraints = false
        shopImageView.topAnchor.constraint(equalTo: topAnchor, constant: 34).isActive = true
        shopImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -53).isActive = true
        shopImageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        shopImageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
    }
    
    
    private func setupLikeImageView(){
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 33).isActive = true
        likeImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        likeImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        likeImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
    }
    
    private func setupBuyButton() {
        toBuyButton.translatesAutoresizingMaskIntoConstraints = false
        toBuyButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -27).isActive = true
        toBuyButton.widthAnchor.constraint(equalToConstant: 84).isActive = true
        toBuyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        toBuyButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        toBuyButton.backgroundColor = .white
        toBuyButton.layer.cornerRadius = 15
        toBuyButton.layer.masksToBounds = true
        toBuyButton.alpha = 1
    }
    
    
    
    
}
