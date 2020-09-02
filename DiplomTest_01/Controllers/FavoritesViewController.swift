//
//  FavoritesViewController.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 12.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var arrayOfMainProducts = [MainProduct]()
    var countofElements = 0
    
    
    
    var urlsStrings = [String]()
    
    var images = [UIImage]()
    
    var products = [MainProduct]()
    var mainProduct = MainProduct()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    private let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .black
        return line
    }()
    
    private let items = ["Все товары", "Со скидкой"]
    
    lazy var segmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.tintColor = .black
        return sc
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "favorite")
        tv.separatorStyle = .none
        tv.rowHeight = 150
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayOfMainProducts.count == 0 {
            return 1
        }else {
            return arrayOfMainProducts.count
        }
        
    }
    
    
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite", for: indexPath) as! FavoriteTableViewCell
           
        cell.selectionStyle = .none
        
        if arrayOfMainProducts.count != 0 {
            
            cell.mainImage.downloadImage(from: arrayOfMainProducts[indexPath.row].pathToImage)
            cell.priceProductLabel.text = arrayOfMainProducts[indexPath.row].price
            cell.descriptionTextView.text = arrayOfMainProducts[indexPath.row].desc
            cell.nameProductLabel.text = arrayOfMainProducts[indexPath.row].name
            cell.toBuyButton.addTarget(self, action: #selector(handleToBuy), for: .touchUpInside)
            cell.toBuyButton.tag = indexPath.row
            cell.toBuyButton.isHidden = false
        }else {
            cell.toBuyButton.isHidden = true
        }
        
        
        
        
         return cell
        
    }
       
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(countofElements)
    }
    */
    
    @objc func handleToBuy(sender: UIButton) {
           
          ProgressHUD.show("Добавление", interaction: false)
         
          addImages()
        
         let number = sender.tag
        
         let uid = Auth.auth().currentUser!.uid
         let ref = Database.database().reference()
         let storage = Storage.storage().reference(forURL: "gs://diplomtest01.appspot.com")
            
         let key = ref.child("buskets").childByAutoId().key
         let imageRef = storage.child("buskets").child(uid).child("\(key!).jpg")
       
         let image = images[number]
         let data = image.jpegData(compressionQuality: 0.6)
        
        
         let uploadTask = imageRef.putData(data!, metadata: nil) { (metadata, error) in
                   if error != nil {
                       print(error!.localizedDescription)
                       
                       return
               }
                   
                   imageRef.downloadURL(completion: { (url, error) in
                       if let url = url {
                           let feed = ["userID" : uid,
                                       
                                       "description" : self.arrayOfMainProducts[number].desc!,
                                       "price" : self.arrayOfMainProducts[number].price!,
                                       "pathToImage" : url.absoluteString,
                                       "name" : self.arrayOfMainProducts[number].name!,
                                       "productsID" : key!]  as [String : Any]
                           
                           let product = ["\(key!)" : feed]
                           
                           ref.child("buskets").updateChildValues(product)
                           ProgressHUD.dismiss()
                       }
                   })
               
               }
               
               uploadTask.resume()
        
        
    
           
           
    }
    
    private func addImages() {
        for mainUrl in urlsStrings {
            let url = URL(string: mainUrl)
            if let data = try? Data(contentsOf: url!)
            {
                let image: UIImage = UIImage(data: data) ?? UIImage(named: "product17")!
                images.append(image)
            }
        }
    }
    
    func fetchProducts() {
        
        let uid = Auth.auth().currentUser!.uid
        
        let ref = Database.database().reference()
        ref.child("likes").queryOrderedByKey().observeSingleEvent(of: .value) { snapshot in
            
        let products = snapshot.value as! [String : AnyObject]
         for(_,product) in products {
             let prod = MainProduct()
                if let name = product["name"] as? String, let desc = product["description"] as? String, let price = product["price"] as? String, let pathToImage = product["pathToImage"] as? String, let productID = product["productsID"] as? String, let userID = product["userID"] as? String {
                    
                    prod.name = name
                    prod.desc = desc
                    prod.price = price
                    prod.pathToImage = pathToImage
                    prod.productID = productID
                    prod.userID = userID
                    
                    if uid == userID {
                        
                       self.urlsStrings.append(pathToImage)
                                       
                       self.arrayOfMainProducts.append(prod)
                        
                        
                    }else {
                        print("Don't equals uid")
                    }
                    
                    
                }
                
            }
            
            
            self.tableView.reloadData()
            //self.countofElements = self.arrayOfMainProducts.count
        }
        
        ref.removeAllObservers()
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let product = arrayOfMainProducts[indexPath.row]
        let ref = Database.database().reference()
       
        
           if let productId = product.productID {
            ref.child("likes").child("\(productId)").removeValue { (error, ref) in
                if error != nil {
                    print(error!)
                    return
                }
                
                self.arrayOfMainProducts.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
            
           }
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchProducts()
        view.backgroundColor = .white
        view.addSubview(topLabel)
        //setupTopLabel()
        
        view.addSubview(segmentControl)
        setupSegmentControl()
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        let font = UIFont(name: "Noah-Bold", size: 15)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: font!], for: .normal)
        
        view.addSubview(lineView)
        setupLineView()
        
        view.addSubview(tableView)
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    
    
    
    private func setupTopLabel() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        topLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        topLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        
    }
    
    
    private func setupSegmentControl() {
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        segmentControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        segmentControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    private func setupLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    

}


