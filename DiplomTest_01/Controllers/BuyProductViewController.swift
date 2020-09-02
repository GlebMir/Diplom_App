//
//  BuyProductViewController.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 29.05.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import DTTextField
import Firebase
import ProgressHUD

class BuyProductViewController: UIViewController, UITextFieldDelegate {
    
    var nameOfProduct = ""
    var image = ""
    var desctext = ""
    var priceText = ""
    var isActiveSize = false 
    var isLiked = false
    
    let mainLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Оплата"
        lb.font = UIFont(name: "MontDemo-Heavy", size: 24)
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    let descLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Test ofdf sdfsdf asdasdas d"
        lb.font = UIFont(name: "MontDemo-Heavy", size: 18)
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    let priceLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Price"
        lb.font = UIFont(name: "MontDemo-Heavy", size: 18)
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    let sizeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Размеры:"
        lb.font = UIFont(name: "MontDemo-Heavy", size: 19)
        lb.textAlignment = .left
        lb.textColor = .black
        return lb
    }()
    
    let xsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("XS", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Noah-Regular", size: 18)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(xsHandleSize), for: .touchUpInside)
        return button
    }()
    
    let sButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("S", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Noah-Regular", size: 18)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(sHandleSize), for: .touchUpInside)
        return button
    }()
    
    let mButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("M", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Noah-Regular", size: 18)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(mHandleSize), for: .touchUpInside)
        return button
    }()
    
    let lButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("L", for: .normal)
          button.setTitleColor(.white, for: .normal)
          button.titleLabel?.font = UIFont(name: "Noah-Regular", size: 18)
          button.addTarget(self, action: #selector(lHandleSize), for: .touchUpInside)
          button.backgroundColor = .red
          return button
      }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        return iv
    }()
    
    let addresTextField: DTTextField = {
        let tf = DTTextField()
        
        return tf
    }()
    
    
    let addresLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Адрес:"
        lb.font = UIFont(name: "MontDemo-Heavy", size: 19)
        lb.textAlignment = .left
        lb.textColor = .black
        return lb
    }()
    
    let payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить в корзину", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "MontDemo-Heavy", size: 16)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(payHandle), for: .touchUpInside)
        return button
    }()
    
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "internal-like-false"), for: .normal)
        button.addTarget(self, action: #selector(addToLikes), for: .touchUpInside)
        return button
    }()
    
    @objc func addToLikes() {
        
        if isLiked == false {
            likeButton.setBackgroundImage(UIImage(named: "internal-like"), for: .normal)
            isLiked = true
        }else {
            likeButton.setBackgroundImage(UIImage(named: "internal-like-false"), for: .normal)
            isLiked = false
        }
        
        guard let nameProduct = mainLabel.text, let descProduct = descLabel.text, let priceProduct = priceLabel.text else {
            return
        }
        
        ProgressHUD.show("Добавление", interaction: false)
        
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        let storage = Storage.storage().reference(forURL: "gs://diplomtest01.appspot.com")
                   
        let key = ref.child("likes").childByAutoId().key
        let imageRef = storage.child("likes").child(uid).child("\(key!).jpg")
              
        let image = imageView.image
        let data = image?.jpegData(compressionQuality: 0.6)
            
        let uploadTask = imageRef.putData(data!, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!.localizedDescription)
                
                return
        }
            
            imageRef.downloadURL(completion: { (url, error) in
                if let url = url {
                    let feed = ["userID" : uid,
                                "name" : nameProduct,
                                "description" : descProduct,
                                "price" : priceProduct,
                                "pathToImage" : url.absoluteString,
                                "productsID" : key!]  as [String : Any]
                    
                    let product = ["\(key!)" : feed]
                    
                    ref.child("likes").updateChildValues(product)
                    ProgressHUD.dismiss()
                    self.dismiss(animated: true, completion: nil)
                    
                }
            })
        
        }
        
        uploadTask.resume()
        
          
    }
    
    
    @objc func sHandleSize() {
        sButton.backgroundColor = .green
        //3
        xsButton.backgroundColor = .red
        mButton.backgroundColor = .red
        lButton.backgroundColor = .red
    }
    
    @objc func xsHandleSize() {
        xsButton.backgroundColor = .green
        //3
        sButton.backgroundColor = .red
        mButton.backgroundColor = .red
        lButton.backgroundColor = .red
    }
    
    @objc func mHandleSize() {
           mButton.backgroundColor = .green
           //3
           sButton.backgroundColor = .red
           xsButton.backgroundColor = .red
           lButton.backgroundColor = .red
    }
    
    @objc func lHandleSize() {
        lButton.backgroundColor = .green
        //3
        sButton.backgroundColor = .red
        mButton.backgroundColor = .red
        xsButton.backgroundColor = .red
    }
    
    
    @objc func payHandle() {
        
        guard let nameProduct = mainLabel.text, let descProduct = descLabel.text, let priceProduct = priceLabel.text else {
            return
        }
        
        ProgressHUD.show("Добавление", interaction: false)
        
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        let storage = Storage.storage().reference(forURL: "gs://diplomtest01.appspot.com")
        
        let key = ref.child("buskets").childByAutoId().key
        let imageRef = storage.child("buskets").child(uid).child("\(key!).jpg")
        
        let image = imageView.image
        let data = image?.jpegData(compressionQuality: 0.6)
        
        let uploadTask = imageRef.putData(data!, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!.localizedDescription)
                
                return
        }
            
            imageRef.downloadURL(completion: { (url, error) in
                if let url = url {
                    let feed = ["userID" : uid,
                                "name" : nameProduct,
                                "description" : descProduct,
                                "price" : priceProduct,
                                "pathToImage" : url.absoluteString,
                                "productsID" : key!]  as [String : Any]
                    
                    let product = ["\(key!)" : feed]
                    
                    ref.child("buskets").updateChildValues(product)
                    ProgressHUD.dismiss()
                    self.dismiss(animated: true, completion: nil)
                }
            })
        
        }
        
        uploadTask.resume()
        
    
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
               if self.view.frame.origin.y == 0 {
                   self.view.frame.origin.y -= 160
               }
       }
       
    @objc func keyboardWillHide(notification: NSNotification) {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
    }
       
    override func viewWillDisappear(_ animated: Bool) {
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addresTextField.delegate = self
        
        addresTextField.placeholder = "Адрес"
        addresTextField.placeholderColor = .lightGray
        addresTextField.floatPlaceholderActiveColor = .red
        addresTextField.floatPlaceholderColor = .red
        addresTextField.animateFloatPlaceholder = true
        addresTextField.borderColor = .black
        
        
        view.addSubview(mainLabel)
        setupMainLabel()
        mainLabel.text = nameOfProduct
        imageView.downloadImage(from: image)
        
        view.addSubview(imageView)
        setupImageView()
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        
        view.addSubview(descLabel)
        setupDescLabel()
        
        descLabel.text = "Описание: " + desctext
        priceLabel.text = "Цена: " + priceText + " руб."
        
       view.addSubview(priceLabel)
       setupPriceLabel()
        
        view.addSubview(sizeLabel)
        setupSizeLabel()
        
        view.addSubview(xsButton)
        setupXSButton()
        
        view.addSubview(sButton)
        setupSButton()
        
        view.addSubview(mButton)
        setupMButton()
        
        view.addSubview(lButton)
        setupLButton()
        
        view.addSubview(payButton)
        setupPayButton()
        
        payButton.layer.masksToBounds = true
        payButton.layer.cornerRadius = 10
        
        //view.addSubview(addresTextField)
        //setupAddresTextField()
        
       // view.addSubview(addresLabel)
        // setupAddresLabel()
        
        
        view.addSubview(likeButton)
        setupLikeButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    
    
    private func setupMainLabel() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        mainLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    private func setupDescLabel() {
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        descLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25).isActive = true
        descLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupSizeLabel() {
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        sizeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        sizeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sizeLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 23).isActive = true
        sizeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        priceLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 90).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    
    //Кнопки s, m, l
    
    private func setupXSButton() {
        xsButton.translatesAutoresizingMaskIntoConstraints = false
        xsButton.leftAnchor.constraint(equalTo: sizeLabel.rightAnchor, constant: 10).isActive = true
        xsButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 17).isActive = true
        xsButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        xsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    
    private func setupSButton() {
        sButton.translatesAutoresizingMaskIntoConstraints = false
        sButton.leftAnchor.constraint(equalTo: xsButton.rightAnchor, constant: 10).isActive = true
        sButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 17).isActive = true
        sButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        sButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func setupMButton() {
           mButton.translatesAutoresizingMaskIntoConstraints = false
           mButton.leftAnchor.constraint(equalTo: sButton.rightAnchor, constant: 10).isActive = true
           mButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 17).isActive = true
           mButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
           mButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
           
    }
    
    
    private func setupLButton() {
           lButton.translatesAutoresizingMaskIntoConstraints = false
           lButton.leftAnchor.constraint(equalTo: mButton.rightAnchor, constant: 10).isActive = true
           lButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 17).isActive = true
           lButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
           lButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
           
    }
    
    
    private func setupPayButton() {
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        payButton.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 120).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        payButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupAddresTextField() {
        addresTextField.translatesAutoresizingMaskIntoConstraints = false
        addresTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        addresTextField.widthAnchor.constraint(equalToConstant: 220).isActive = true
        addresTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20).isActive = true
        addresTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    
    private func setupAddresLabel() {
        addresLabel.translatesAutoresizingMaskIntoConstraints = false
        addresLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        addresLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addresLabel.topAnchor.constraint(equalTo: addresTextField.topAnchor, constant: 5).isActive = true
        addresLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    private func setupLikeButton() {
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.leftAnchor.constraint(equalTo: lButton.rightAnchor, constant: 50).isActive = true
        likeButton.topAnchor.constraint(equalTo: lButton.topAnchor, constant: -3).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    
    
}
