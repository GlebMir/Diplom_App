//
//  ProductCollectionViewCell.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 10.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let tv = UIView()
        tv.backgroundColor = .white
        return tv
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
       // iv.image = UIImage(named: "product1")
        return iv
    }()
    
    let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Джинсы S01"
        lb.font = UIFont(name: "Noah-Bold", size: 15)
        lb.textAlignment = .left
        lb.textColor = .black
        return lb
    }()
    
    let priceLabel: UILabel = {
        let lb = UILabel()
        lb.text = "1500₽"
        lb.font = UIFont(name: "Noah-Bold", size: 13)
        lb.textAlignment = .left
        lb.textColor = .darkGray
        return lb
    }()
    
    let likeImageView: UIImageView = {
        let iv = UIImageView()
        //iv.image = UIImage(named: "shop-top2")
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let internalLikeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "internal-like")
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let toBuyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Купить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Noah-Regular", size: 18)
        button.backgroundColor = .orange
        return button
    }()
    
    let toBasketButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .green
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        setupContainerView()
        containerView.addSubview(imageView)
        setupImageView()
        containerView.addSubview(descriptionLabel)
        setupDescriptionLabel()
        
        containerView.addSubview(priceLabel)
        setupPriceLabel()
        imageView.addSubview(likeImageView)
        setupLikeImageView()
        
        imageView.addSubview(internalLikeImageView)
        setupInternalLikeImageView()
        
        containerView.addSubview(toBuyButton)
        setupButton()
        
        containerView.addSubview(toBasketButton)
        setupBasketButton()
        toBasketButton.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        //containerView.backgroundColor = .red 190
    }
    
    
    private func setupImageView(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 146).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 144).isActive = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 13).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    private func setupPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 14).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    
    private func setupLikeImageView() {
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 7).isActive = true
        likeImageView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -12).isActive = true
        likeImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        likeImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        likeImageView.layer.cornerRadius = 13
        likeImageView.layer.masksToBounds = true
        likeImageView.alpha = 0.95
    }
     
    private func setupInternalLikeImageView() {
        internalLikeImageView.translatesAutoresizingMaskIntoConstraints = false
        internalLikeImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 12).isActive = true
        internalLikeImageView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -16).isActive = true
        internalLikeImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        internalLikeImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    
    private func setupButton() {
        toBuyButton.translatesAutoresizingMaskIntoConstraints = false
        toBuyButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 13).isActive =  true
        toBuyButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -13).isActive = true
        toBuyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        toBuyButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    private func setupBasketButton() {
        toBasketButton.translatesAutoresizingMaskIntoConstraints = false
        toBasketButton.widthAnchor.constraint(equalToConstant: 23).isActive = true
        toBasketButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
        toBasketButton.bottomAnchor.constraint(equalTo: toBuyButton.topAnchor, constant: -17).isActive = true
        toBasketButton.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    
    
}
