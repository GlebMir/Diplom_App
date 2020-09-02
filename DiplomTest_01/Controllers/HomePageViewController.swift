//
//  HomePageViewController.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 09.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import CHIPageControl

class HomePageViewController: UIViewController {
    
    private let topContainerView = UIView()
    
    let pages = [Page(imageName: "page3-photo", topLabelText: "Летняя коллекция", saleText:              "20％ OFF", descriptionText: "Модные шорты для летнего сезона, успей                купить скорее"),
                Page(imageName: "page2-photo", topLabelText: "Новая коллекция", saleText: "15％ OFF", descriptionText: "Модные шорты для летнего сезона, успей купить скорее"),
                Page(imageName: "product18", topLabelText: "Зимняя коллекция", saleText: "35％ OFF", descriptionText: "Модные шорты для летнего сезона, успей купить скорее")
    ]
    
    let sectionNames = ["Новинки", "Скидки", "Коллекция SS12", "Коллекция WR1", "Fashion Season", "Коллекция G5"]
    
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 3
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        cv.isPagingEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProdCell")
        tv.register(ShowAllTableViewCell.self, forCellReuseIdentifier: "showAll")
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        //tv.rowHeight = 230
        return tv
    }()
    
    let pControl: CHIPageControlPaprika = {
        let pc = CHIPageControlPaprika()
        pc.radius = 4
        pc.tintColor = .white
        return pc
    }()
    
    private let mainLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Каталог"
        lb.font = UIFont(name: "MontDemo-Heavy", size: 30)
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    

    
    
    func setupPControl() {
        pControl.translatesAutoresizingMaskIntoConstraints = false
        pControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        pControl.widthAnchor.constraint(equalToConstant: 130).isActive = true
        pControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 260).isActive = true
        pControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pControl.set(progress: Int(x / view.frame.width), animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        view.backgroundColor = .white
        view.addSubview(topContainerView)
        setupTopContainerView()
        topContainerView.addSubview(collectionView)
        setupCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        
       //Page Control
        view.addSubview(pControl)
        setupPControl()
        pControl.numberOfPages = pages.count
        
        
        
        //Table View
        view.addSubview(tableView)
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.clear
        view.addSubview(mainLabel)
        setupMainLabel()
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupTopContainerView() {
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        topContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topContainerView.heightAnchor.constraint(equalToConstant: 260).isActive = true
    }
    
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topContainerView.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: topContainerView.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: topContainerView.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        collectionView.backgroundColor = .white
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 55).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    private func setupMainLabel() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 4).isActive = true
        mainLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
    }
    
    
    //TABLE VIEW
    
    func sdf() {

    }
    
    
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.mainImageView.image = UIImage(named: page.imageName)
        cell.topLabelText.text = page.topLabelText
        cell.toBuyButton.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        cell.saleLabelText.text = page.saleText
        // cell.mainImageView.image =
        cell.mainImageView.alpha = 0.9
    
        return cell
    }
    
    
    @objc func handleButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = storyboard.instantiateViewController(withIdentifier: "DetailProductViewController") as! DetailProductViewController
        self.navigationController?.pushViewController(vc2, animated: true)
        print("Купить")
    }
    
    

}


//Table View

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row != 5 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProdCell", for: indexPath) as! ProductTableViewCell
            cell.selectionStyle = .none
        cell.showAllButton.addTarget(self, action: #selector(handleShowAll), for: .touchUpInside)
            
            cell.sectionLabel.text = sectionNames[indexPath.item]
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "showAll", for: indexPath) as! ShowAllTableViewCell
            cell.selectionStyle = .none
            cell.containerView.addTarget(self, action: #selector(handleShowAll), for: .touchUpInside)
            return cell
        }
        
        
        
        
    }
    
    @objc func handleShowAll() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = storyboard.instantiateViewController(withIdentifier: "DetailProductViewController") as! DetailProductViewController
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
    
   
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row != 5 {
            return 230
        }else {
            return 80
        }
    }

    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("table")
    }
     */
    
    
    
    
 }
