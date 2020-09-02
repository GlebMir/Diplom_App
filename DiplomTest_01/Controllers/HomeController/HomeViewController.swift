//
//  MainViewController.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 06.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1000)
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.frame = self.view.bounds
        sv.contentSize = contentViewSize
        sv.backgroundColor = .white
        sv.delegate = self
        return sv
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        view.backgroundColor = .white
        return view
    }()
    
    private let saleContainerView = UIView()
    private let modelsContainerView = UIView()
    
    private let topNewslabel: UILabel = {
        let lb = UILabel()
        lb.text = "Скидка для студентов 10％"
        lb.textAlignment = .center
        lb.font = UIFont(name: "MontDemo-Heavy", size: 20)
        lb.textColor = .white
        lb.backgroundColor = .black
        return lb
    }()
    
    private let saleImageView: UIImageView = {
           let iv = UIImageView()
           iv.image = UIImage(named: "sale-bg2")
           iv.alpha = 0.8
           return iv
       }()
    
    private let modelsImageView: UIImageView = {
          let iv = UIImageView()
          iv.image = UIImage(named: "models")
          return iv
      }()
    
    
    //TABLE
    
    private let tableViewContainer = UIView()
    
    var tableView = UITableView()
    
    private func configureTableView() {
        tableViewContainer.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.rowHeight = 100
        
        setUpTableView()
    }
    
    
    //COLLECTION VIEW MODELS
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        cv.register(ModelsCollectionViewCell.self, forCellWithReuseIdentifier: ModelsCollectionViewCell.reuseId)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .orange
        return cv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(topNewslabel)
        setUpLabel()
        
        containerView.addSubview(saleContainerView)
        setUpSaleContainerView()
        
        saleContainerView.addSubview(saleImageView)
        setUpSaleImageView()
        
        containerView.addSubview(modelsContainerView)
        setUpModelsContainerView()
        
        //modelsContainerView.addSubview(modelsImageView)
        //setUpModelsImageView()
        
        containerView.addSubview(tableViewContainer)
        setUpTableViewContainer()
        
        //Table
        configureTableView()
        
        
        //Colection
        modelsContainerView.addSubview(collectionView)
        setUpCollectionView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setUpCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: modelsContainerView.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: modelsContainerView.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: modelsContainerView.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: modelsContainerView.bottomAnchor).isActive = true
        
    }
  
    private func setUpLabel() {
        topNewslabel.translatesAutoresizingMaskIntoConstraints = false
        topNewslabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        topNewslabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 18).isActive = true
        topNewslabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18).isActive = true
        topNewslabel.heightAnchor.constraint(equalToConstant: 33).isActive = true
    }
    
    
    private func setUpSaleContainerView(){
        saleContainerView.translatesAutoresizingMaskIntoConstraints = false
        saleContainerView.topAnchor.constraint(equalTo: topNewslabel.bottomAnchor, constant: 15).isActive = true
        saleContainerView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 18).isActive = true
        saleContainerView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -18).isActive = true
        saleContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        saleContainerView.backgroundColor = .black
        
    }
    
    private func setUpSaleImageView() {
        saleImageView.translatesAutoresizingMaskIntoConstraints = false
        saleImageView.topAnchor.constraint(equalTo: saleContainerView.topAnchor).isActive = true
        saleImageView.bottomAnchor.constraint(equalTo: saleContainerView.bottomAnchor).isActive = true
        saleImageView.leftAnchor.constraint(equalTo: saleContainerView.leftAnchor).isActive = true
        saleImageView.rightAnchor.constraint(equalTo: saleContainerView.rightAnchor).isActive = true
    }
    
    private func setUpModelsContainerView() {
        modelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        modelsContainerView.topAnchor.constraint(equalTo: saleContainerView.bottomAnchor, constant: 15).isActive = true
        modelsContainerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        modelsContainerView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        modelsContainerView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        //modelsContainerView.layer.cornerRadius = 8
        //modelsContainerView.layer.masksToBounds = true
    }
    
    private func setUpModelsImageView() {
        modelsImageView.translatesAutoresizingMaskIntoConstraints = false
        modelsImageView.topAnchor.constraint(equalTo: modelsContainerView.topAnchor).isActive = true
        modelsImageView.bottomAnchor.constraint(equalTo: modelsContainerView.bottomAnchor).isActive = true
        modelsImageView.leftAnchor.constraint(equalTo: modelsContainerView.leftAnchor).isActive = true
        modelsImageView.rightAnchor.constraint(equalTo: modelsContainerView.rightAnchor).isActive = true
       }
    
   
    //TABLE VIEW
    
    private func setUpTableViewContainer() {
        tableViewContainer.translatesAutoresizingMaskIntoConstraints = false
        tableViewContainer.topAnchor.constraint(equalTo: modelsContainerView.bottomAnchor, constant: 20).isActive = true
        tableViewContainer.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive = true
        tableViewContainer.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive = true
        tableViewContainer.heightAnchor.constraint(equalToConstant: 600).isActive = true
        tableViewContainer.backgroundColor = .black
    }
    
    private func setUpTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: tableViewContainer.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tableViewContainer.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: tableViewContainer.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: tableViewContainer.rightAnchor).isActive = true
    }

    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else {
            return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        cell.set(imageName: "sale-bg", text: "Hello")
        return cell
    }
    
    
}

//CollectionView


extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 1.4, height: collectionView.frame.height / 1.1)
    }
     
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModelsCollectionViewCell.reuseId, for: indexPath) as! ModelsCollectionViewCell
        cell.mainImageView.image = UIImage(named: "models")
        return cell
        
    }
    
    

    
}


