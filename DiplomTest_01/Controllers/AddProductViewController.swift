//
//  AddProductViewController.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 22.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import DTTextField
import Firebase
import ProgressHUD

class AddProductViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker = UIImagePickerController()
    
    @IBOutlet weak var nameTextField: DTTextField!
    
    @IBOutlet weak var descriptionTextField: DTTextField!
    
    @IBOutlet weak var categoryTextFiled: DTTextField!
    
    
    @IBOutlet weak var priceTextField: DTTextField!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addButtonAction(_ sender: UIButton) {
       
        guard let nameOfProduct = nameTextField.text, nameTextField.text != "", let descriptionOfProduct = descriptionTextField.text, descriptionTextField.text != "", let categoryOfProduct = categoryTextFiled.text, categoryTextFiled.text != "", let priceOfProduct = priceTextField.text, priceTextField.text != "" else {
            print("Поля не заполнены")
            return
            
        }
        
        ProgressHUD.show("Загрузка..", interaction: false)
        
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        let storage = Storage.storage().reference(forURL: "gs://diplomtest01.appspot.com")
        var name = "User"
        
        //Выгружаем имя дизайнера
        ref.child("users").child(uid).observe(.value, with: { (dataSnapshot) in
            
            if let dictionary = dataSnapshot.value as? [String : AnyObject] {
                name = dictionary["name"] as! String
            }
            
            
        }, withCancel: nil)
        
        let key = ref.child("products").childByAutoId().key
        let imageRef = storage.child("products").child(uid).child("\(key!).jpg")
        
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
                                "name" : nameOfProduct,
                                "description" : descriptionOfProduct,
                                "category" : categoryOfProduct,
                                "price" : priceOfProduct,
                                "pathToImage" : url.absoluteString,
                                "designer" : name,
                                "productsID" : key!]  as [String : Any]
                    
                    let product = ["\(key!)" : feed]
                    
                    ref.child("products").updateChildValues(product)
                    ProgressHUD.dismiss()
                    self.dismiss(animated: true, completion: nil)
                }
            })
        
        }
        
        uploadTask.resume()
        
        
        /* Выгружаем имя из базы данных
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("users").child(uid!).observe(.value, with: { (dataSnapshot) in
            
            if let dictionary = dataSnapshot.value as? [String : AnyObject] {
                let name = dictionary["name"] as? String
                print(name!)
            }
            
            
        }, withCancel: nil)
        
       */
            
        print("Добавить товар")
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        
        addButton.layer.cornerRadius = 5
        addButton.layer.masksToBounds = true
        
        //Name
        nameTextField.placeholder = "Название"
        nameTextField.placeholderColor = .lightGray
        nameTextField.floatPlaceholderActiveColor = .red
        nameTextField.floatPlaceholderColor = .red
        nameTextField.animateFloatPlaceholder = true
        nameTextField.borderColor = .black
        
        //Desc
        descriptionTextField.placeholder = "Описание"
        descriptionTextField.placeholderColor = .lightGray
        descriptionTextField.floatPlaceholderActiveColor = .red
        descriptionTextField.floatPlaceholderColor = .red
        descriptionTextField.animateFloatPlaceholder = true
        descriptionTextField.borderColor = .black
        
        //Category
        categoryTextFiled.placeholder = "Категория"
        categoryTextFiled.placeholderColor = .lightGray
        categoryTextFiled.floatPlaceholderActiveColor = .red
        categoryTextFiled.floatPlaceholderColor = .red
        categoryTextFiled.animateFloatPlaceholder = true
        categoryTextFiled.borderColor = .black
        
        //Price
        priceTextField.placeholder = "Цена"
        priceTextField.placeholderColor = .lightGray
        priceTextField.floatPlaceholderActiveColor = .red
        priceTextField.floatPlaceholderColor = .red
        priceTextField.animateFloatPlaceholder = true
        priceTextField.borderColor = .black
        
        
        
        nameTextField.delegate = self
        descriptionTextField.delegate = self
        priceTextField.delegate = self
        categoryTextFiled.delegate = self
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
               if self.view.frame.origin.y == 0 {
                   self.view.frame.origin.y -= 75
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
    
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       nameTextField.resignFirstResponder()
       descriptionTextField.resignFirstResponder()
       priceTextField.resignFirstResponder()
       return true
   }
 
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
     
    
    
    

}
