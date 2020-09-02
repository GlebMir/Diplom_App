//
//  DetailProductViewController.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 15.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import Firebase

class DetailProductViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let ButtonColor = UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1)
    
    var arrayOfMainProducts = [MainProduct]()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Вcе товары"
        label.font = UIFont(name: "MontDemo-Heavy", size: 24)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let lineView: UIView = {
        let lv = UIView()
        lv.backgroundColor = .black
        return lv
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "detailProd")
        cv.isPagingEnabled = true
        cv.showsVerticalScrollIndicator = true
        cv.showsHorizontalScrollIndicator = true
        return cv
    }()
    
    func fetchPhotos() {
        let ref = Database.database().reference()
        ref.child("products").queryOrderedByKey().observeSingleEvent(of: .value) { snapshot in
            
            let products = snapshot.value as! [String : AnyObject]
            for(_,product) in products {
                let prod = MainProduct()
                if let name = product["name"] as? String, let desc = product["description"] as? String, let designer = product["designer"] as? String, let price = product["price"] as? String, let pathToImage = product["pathToImage"] as? String, let productID = product["productsID"] as? String, let userID = product["userID"] as? String {
                    
                    prod.name = name
                    prod.desc = desc
                    prod.price = price
                    prod.pathToImage = pathToImage
                    prod.designer = designer
                    prod.productID = productID
                    prod.userID = userID
                  
                    
                    
                    self.arrayOfMainProducts.append(prod)
                    
                    
                }
                
            }
            
            //Заменять место
            self.collectionView.reloadData()
        }
        
        ref.removeAllObservers()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPhotos()
       // view.addSubview(imageView)
       // setupImageView()
        
        view.addSubview(topLabel)
        setupLabel()
        
        view.addSubview(lineView)
        setupLineView()
        
        view.addSubview(collectionView)
        setupCollectionView()
        
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
    }

      

    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
     
    private func setupLabel() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setupLineView(){
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10).isActive = true
        lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfMainProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailProd", for: indexPath) as! ProductCollectionViewCell
        cell.backgroundColor = .red
        cell.containerView.backgroundColor = .white
        cell.toBuyButton.backgroundColor = ButtonColor
        cell.toBuyButton.setTitleColor(.white, for: .normal)
        cell.toBuyButton.titleLabel?.font = UIFont(name: "Noah-Bold", size: 18)
        cell.toBuyButton.layer.cornerRadius = 5
        cell.toBuyButton.layer.masksToBounds = true
       // cell.toBuyButton.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        cell.toBasketButton.isHidden = false
        cell.toBasketButton.backgroundColor = .clear
        cell.toBasketButton.setBackgroundImage(UIImage(named: "basket2"), for: .normal)
        cell.toBasketButton.addTarget(self, action: #selector(moveToBasket), for: .touchUpInside)
        
        cell.likeImageView.isHidden = true
        cell.internalLikeImageView.isHidden = true
        
        if indexPath.item % 2 == 0 {
            cell.containerView.addBorder(side: .bottom, color: ButtonColor, width: 1)
        }else {
            cell.containerView.addBorder(side: .bottom, color: .black, width: 1)
        }
        
        cell.descriptionLabel.text = arrayOfMainProducts[indexPath.row].name
        cell.priceLabel.text = arrayOfMainProducts[indexPath.row].price
        cell.imageView.downloadImage(from: self.arrayOfMainProducts[indexPath.row].pathToImage)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 240)
    }


   
    @objc func moveToBasket() {
        print("Добавить в корзину")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = storyboard.instantiateViewController(withIdentifier: "BuyProductViewController") as! BuyProductViewController
        vc2.nameOfProduct = arrayOfMainProducts[indexPath.row].name
        vc2.desctext = arrayOfMainProducts[indexPath.row].desc
        vc2.priceText = arrayOfMainProducts[indexPath.row].price
        let img = arrayOfMainProducts[indexPath.row].pathToImage
        vc2.image = img!
        self.navigationController?.pushViewController(vc2, animated: true)
    }
      
    
}



extension UIImageView {
    
    func downloadImage(from imgURL: String!) {
        let url = URLRequest(url: URL(string: imgURL)!)
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
        }
        
        task.resume()
    }
}
