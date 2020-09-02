//
//  ProductTableViewCell.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 10.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit


class ProductTableViewCell: UITableViewCell {
    
    var count = 0
    var count2 = 2
    var count3 = 1
    var likecount = 1
    var product: Product?

    let products: [Product] = [
        
                    Product(imageName: "product1", descriotionText: "Жилет", priceText: "1350₽"),
                    Product(imageName: "product12", descriotionText: "Кеды SS12", priceText: "2550₽"),
                    Product(imageName: "product1", descriotionText: "Худи", priceText: "1300₽"),
                    Product(imageName: "product15", descriotionText: "Jeans Back", priceText: "120₽"),
                    Product(imageName: "product16", descriotionText: "Худи - Black", priceText: "3100₽"),
                    Product(imageName: "product16", descriotionText: "Худи - Black", priceText: "3100₽")]
    
    let products2: [Product] = [
    
                Product(imageName: "product16", descriotionText: "Худи - Black", priceText: "1300₽"),
                Product(imageName: "product14", descriotionText: "Кроссовки J01", priceText: "2500₽"),
                Product(imageName: "product15", descriotionText: "Jeans Back", priceText: "1300₽"),
                Product(imageName: "product12", descriotionText: "Jeans Back", priceText: "1300₽"),
                Product(imageName: "product13", descriotionText: "Кеды F2", priceText: "4000₽"),
                Product(imageName: "product13", descriotionText: "Кеды F2", priceText: "4000₽")]
    
    let products3: [Product] = [
    
                Product(imageName: "product15", descriotionText: "Набор - Summer1", priceText: "1300₽"),
                Product(imageName: "product16", descriotionText: "Худи - Black", priceText: "2500₽"),
                Product(imageName: "product13", descriotionText: "Футболка", priceText: "1000₽"),
                Product(imageName: "product12", descriotionText: "T-Short S01", priceText: "2500₽"),
                Product(imageName: "product17", descriotionText: "Jeans Back", priceText: "1300₽"),
                Product(imageName: "product17", descriotionText: "Jeans Back", priceText: "1300₽")]
    
   
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 3)
        cv.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "item")
        //cv.isPagingEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let sectionLabel: UILabel = {
        let lb = UILabel()
        lb.text = "New Collection"
        lb.font = UIFont(name: "MontDemo-Heavy", size: 24)
        lb.textAlignment = .left
        lb.textColor = .black
        return lb
    }()
    
    let showAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Каталог", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Noah-Regular", size: 15)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        setupCollectionView()
        collectionView.backgroundColor = .white
        
        addSubview(sectionLabel)
        setupSectionLabel()
        
        addSubview(showAllButton)
        setupShowAllButton()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bounds = bounds.inset(by: padding)
    }
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    private func setupSectionLabel() {
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        sectionLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        sectionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        sectionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    private func setupShowAllButton() {
        showAllButton.translatesAutoresizingMaskIntoConstraints = false
        showAllButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        showAllButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        showAllButton.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        showAllButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    
    
    

}

extension ProductTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:
        IndexPath) -> UICollectionViewCell {
        
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! ProductCollectionViewCell
        
        switch indexPath.item {
        case 0:
            product = products[count]
            count += 1
        case 1:
            product = products2[count2]
            count2 += 1
        case 2:
            product = products3[count3]
            count3 += 1
        default:
            print("default")
        }
        
        
        
        cell.imageView.image = UIImage(named: product!.imageName)
        cell.descriptionLabel.text = product!.descriotionText
        cell.priceLabel.text = product!.priceText
        
        
        if likecount % 2 == 0 {
            cell.likeImageView.isHidden = true
            cell.internalLikeImageView.isHidden = true
            
        }
        likecount += 1
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc2 = storyboard.instantiateViewController(withIdentifier: "DetailProductViewController") as! DetailProductViewController
        
        
        print(123)
        
    }
    
    

    
    
}
