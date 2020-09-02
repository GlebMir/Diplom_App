//
//  BusketViewController.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 31.05.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import Firebase

class BusketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfProducts = [MainProduct]()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(BusketTableViewCell.self, forCellReuseIdentifier: "busket")
         tv.register(ShowAllTableViewCell.self, forCellReuseIdentifier: "showAll")
        tv.separatorStyle = .none
        tv.rowHeight = 130
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    let lineView: UIView = {
        let lv = UIView()
        lv.backgroundColor = .black
        return lv
    }()
    

    let topLalel: UILabel = {
        let lb = UILabel()
        lb.text = "Корзина"
        lb.font = UIFont(name: "MontDemo-Heavy", size: 35)
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    
    func fetchProducts() {
        
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        ref.child("buskets").queryOrderedByKey().observeSingleEvent(of: .value) { snapshot in
            
        let products = snapshot.value as! [String : AnyObject]
         for(_,product) in products {
             let prod = MainProduct()
                if let name = product["name"] as? String, let desc = product["description"] as? String, let price = product["price"] as? String, let pathToImage = product["pathToImage"] as? String, let productID = product["productsID"] as? String, let userID = product["userID"] as? String {
                    
                    
                    prod.desc = desc
                    prod.price = price
                    prod.pathToImage = pathToImage
                    prod.productID = productID
                    prod.name = name
                    prod.userID = userID
                    
                    
                    if uid == userID {
                        self.arrayOfProducts.append(prod)
                    }else {
                        print("Don't equals id")
                    }
                        
                    
                   
                    
                }
                
            }
            
            //Заменять место
            self.tableView.reloadData()
            
        }
        
        ref.removeAllObservers()
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchProducts()
        
        view.backgroundColor = .white
        
        view.addSubview(topLalel)
        setupTopLabel()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        setupTableView()
        
        view.addSubview(lineView)
        setupLineView()
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let product = arrayOfProducts[indexPath.row]
        let ref = Database.database().reference()
        if let productId = product.productID {
            ref.child("buskets").child("\(productId)").removeValue { (error, ref) in
                if error != nil {
                    print(error!)
                    return
                }
                
                self.arrayOfProducts.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
        }
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arrayOfProducts.count == 0 {
            return 1
        }else {
            return arrayOfProducts.count + 1
        }
        
    }
    
    
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
              //first get total rows in that section by current indexPath.
        if indexPath.row == totalRows - 1 && arrayOfProducts.count != 0 {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "showAll", for: indexPath) as! ShowAllTableViewCell
                cell.selectionStyle = .none
                cell.containerView.addTarget(self, action: #selector(handleShowAll), for: .touchUpInside)
                cell.lineView.isHidden = true
                cell.containerView.backgroundColor = .green
                cell.containerView.setTitle("Оплатить", for: .normal)
                cell.containerView.titleLabel?.font = UIFont(name: "MontDemo-Heavy", size: 16)
                return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "busket", for: indexPath) as! BusketTableViewCell
                   
            if arrayOfProducts.count != 0 {
                
                cell.mainImageView.downloadImage(from: arrayOfProducts[indexPath.row].pathToImage)
                cell.nameLabel.text = arrayOfProducts[indexPath.row].name
                cell.priceLabel.text = arrayOfProducts[indexPath.row].price
                cell.categoryLabel.text = arrayOfProducts[indexPath.row].desc
                
            }
                 return cell
        }
        
                        
        
      
        
        
        
        
           
            
        
        
    }
       
    @objc func handleShowAll() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = storyboard.instantiateViewController(withIdentifier: "PayProductsViewController") as! PayProductsViewController
        self.navigationController?.pushViewController(vc2, animated: true)
        
        
        
    }
    
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    
    
    private func setupTopLabel() {
        topLalel.translatesAutoresizingMaskIntoConstraints = false
        topLalel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLalel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        topLalel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        topLalel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    
    private func setupLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: topLalel.bottomAnchor, constant: 7).isActive = true
        lineView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        lineView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    

}
