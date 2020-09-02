//
//  ProfileViewController.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 13.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    private var userName = "User"
    private let titles1 = ["Мои заказы", "Изменить пароль", "Способы оплаты"]
    private let titles2 = ["Правила", "Справка"]
    
    private let images1 = ["bag-pink", "lock-pink", "card-pink"]
    private let images2 = ["book-pink", "info-pink"]
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Настройки"
        lb.textAlignment = .center
        lb.textColor = .black
        //lb.backgroundColor = .black
        lb.font = UIFont(name: "Noah-Bold", size: 16)
        return lb
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let secondLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    
    private let topContainerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .black
        return cv
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "SUNRISE"
        label.font = UIFont(name: "Noah-Bold", size: 30)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let helloLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать, Глеб"
        label.font = UIFont(name: "Noah-Bold", size: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(ProfileTableViewCell.self, forCellReuseIdentifier: "profile")
        tv.separatorStyle = .singleLine
        tv.rowHeight = 100
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    @IBOutlet weak var addNewProduct: UIBarButtonItem!
    
    @IBAction func addNewProductAction(_ sender: UIBarButtonItem) {
        
        print("+++")
        
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            print("Log out")
            }
            catch let logOutError {
            print(logOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSettings()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addNewProduct.isEnabled = false
        view.backgroundColor = .white
        
        //Здесь должна быть проверка на то дизайнер или покупатель данный пользователь
        // и в зависимости от этого показываться кнопка
    
        view.addSubview(topContainerView)
        setupTopContainerView()
        view.addSubview(lineView)
        //setupLineView()
        view.addSubview(mainLabel)
        setupMainLabel()
        view.addSubview(secondLineView)
        setupSecondLineView()
        
        view.addSubview(helloLabel)
        setupHelloLabel()
        
        view.addSubview(titleLabel)
        setupTitleLabel()
        
        view.addSubview(tableView)
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .white
        
        
    }
    
    
    private func getSettings() {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("users").child(uid!).observe(.value, with: { (dataSnapshot) in
            
            if let dictionary = dataSnapshot.value as? [String : AnyObject] {
                let name = dictionary["name"] as? String
                let status = dictionary["isDesigner"] as? String
                if status == "true" {
                    self.addNewProduct.isEnabled = true
                }else {
                    self.addNewProduct.isEnabled = false
                }
                self.helloLabel.text = "Добро пожаловать, \(name!)"
               
            }
            
            
        }, withCancel: nil)
        
        
    }
    
    
    
    
    private func setupTopContainerView() {
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        topContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setupMainLabel() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 0).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        mainLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func setupLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 4).isActive = true
        lineView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        lineView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setupSecondLineView() {
        secondLineView.translatesAutoresizingMaskIntoConstraints = false
        secondLineView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 2).isActive = true
        secondLineView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        secondLineView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        secondLineView.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    private func setupHelloLabel() {
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        helloLabel.leftAnchor.constraint(equalTo: topContainerView.leftAnchor, constant: 30).isActive = true
        helloLabel.rightAnchor.constraint(equalTo: topContainerView.rightAnchor, constant: -30).isActive = true
        helloLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        helloLabel.topAnchor.constraint(equalTo: secondLineView.bottomAnchor, constant: 20).isActive = true
        
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 3).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else {
            return 2
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Личные данные"
        }else {
            return "О сервисе"
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as! ProfileTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        
              
        
        if indexPath.section == 0 {
            let imageName = images1[indexPath.item]
            cell.mainImageView.image = UIImage(named: imageName)
            cell.descriptionLabel.text = titles1[indexPath.item]
        }else {
            let imageName = images2[indexPath.item]
            cell.mainImageView.image = UIImage(named: imageName)
            cell.descriptionLabel.text = titles2[indexPath.item]
        }
      
        
        
        
        return cell
    }
    
    
    /*
        Кастомный header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.red
        
        return vw
    }
    */
    
    
    
    
}
