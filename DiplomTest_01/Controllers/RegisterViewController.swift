//
//  RegisterViewController.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 05.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate {
   
    var name = ""
    var isDesigner = true
    var uRef: DatabaseReference!
    
    private let nameContainerView = UIView()
    private let emailContainerView = UIView()
    private let passwordContainerView = UIView()
    private let confirmPasswordContainerView = UIView()
    
    @IBOutlet weak var logoNameLabel: UILabel!
    
    @IBOutlet weak var BackButton: UIButton!
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var warnLabel: UILabel!
    
    
    //Обработка ошибки
    func displayWarningLabel(withText text: String) {
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }) { [weak self] complete in
            self?.warnLabel.alpha = 0
        }
    }
    
    //Зарегистрироваться
    @IBAction func regButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        
        var stringIsDesigner = ""
        if isDesigner {
            stringIsDesigner = "true"
        }else {
            stringIsDesigner = "false"
        }
        
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, nameTextField.text != "", emailTextField.text != "", passwordTextField.text != "", confirmPasswordTextField.text != "" else {
            self.displayWarningLabel(withText: "Поля не заполнены")
            return
        }
        
        if passwordTextField.text == confirmPasswordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) {[weak self] (user, error) in
                if error != nil {
                    self?.displayWarningLabel(withText: "Неправильные данные")
                }else {
                    ProgressHUD.show("Регистрация", interaction: false)
                    guard let userId = user?.user.uid else {return}
                    
                    let values = ["name" : name, "email" : email, "isDesigner" : stringIsDesigner]
                    let ref = Database.database(url: "https://diplomtest01.firebaseio.com/")
                    self?.uRef = ref.reference().child("users").child(userId)
                    self?.uRef.updateChildValues(values) {[weak self] (err, ref) in
                        
                        if err != nil {
                            self?.displayWarningLabel(withText: "Ошибка сохранения")
                            return
                        }else {
                            ProgressHUD.dismiss()
                            self?.performSegue(withIdentifier: "registerSegue", sender: nil)
                            print("Успешно!")
                        }
                        
                        
                       
                        
                    }
                }
                
            }
            
        
        }else {
            ProgressHUD.dismiss()
            self.displayWarningLabel(withText: "Пароли не совпадают")
        }
        
        
    }
    
    
    //Image views
    private let nameImageView: UIImageView = {
           let iv = UIImageView()
           iv.image = UIImage(named: "name")
           return iv
    }()
    
    private let emailImageView: UIImageView = {
           let iv = UIImageView()
           iv.image = UIImage(named: "mail")
           return iv
    }()
       
    private let passowrdImageView: UIImageView = {
           let iv = UIImageView()
           iv.image = UIImage(named: "pass")
           return iv
    }()
    
    private let confirmPassowrdImageView: UIImageView = {
           let iv = UIImageView()
           iv.image = UIImage(named: "pass2")
           return iv
    }()
    
    
    //Text Fields
    private lazy var nameTextField: BaseTextField = {
        let tf = BaseTextField(placeHolder: "Имя")
        tf.backgroundColor = .clear
        tf.delegate = self as UITextFieldDelegate
        return tf
    }()
    
    private lazy var emailTextField: BaseTextField = {
        let tf = BaseTextField(placeHolder: "Email")
        tf.backgroundColor = .clear
        tf.keyboardType = .emailAddress
        tf.delegate = self as UITextFieldDelegate
        return tf
    }()
    
    private lazy var passwordTextField: BaseTextField = {
        let tf = BaseTextField(placeHolder: "Пароль")
        tf.isSecureTextEntry = true
        tf.delegate = self as UITextFieldDelegate
        return tf
    }()
    
    private lazy var confirmPasswordTextField: BaseTextField = {
        let tf = BaseTextField(placeHolder: "Подтвердите пароль")
        tf.backgroundColor = .clear
        tf.isSecureTextEntry = true
        tf.keyboardType = .default
        tf.delegate = self as UITextFieldDelegate
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        warnLabel.alpha = 0
        
        view.addSubview(nameContainerView)
        setupNameContainerView()
        view.addSubview(emailContainerView)
        setupEmailContainerView()
        view.addSubview(passwordContainerView)
        setupPasswordContainerView()
        view.addSubview(confirmPasswordContainerView)
        setupConfirmPasswordContainerView()
        
        nameContainerView.addSubview(nameImageView)
        setupNameImageView()
        nameContainerView.addSubview(nameTextField)
        setupNameTextField()
        nameContainerView.addSeparatorLine(color: .lightGray)
        
        emailContainerView.addSubview(emailImageView)
        setupEmailImageView()
        emailContainerView.addSubview(emailTextField)
        setupEmailTextField()
        emailContainerView.addSeparatorLine(color: .lightGray)
        
        passwordContainerView.addSubview(passowrdImageView)
        setupPasswordImageView()
        passwordContainerView.addSubview(passwordTextField)
        setupPasswordTextField()
        passwordContainerView.addSeparatorLine(color: .lightGray)
        
        confirmPasswordContainerView.addSubview(confirmPassowrdImageView)
        setupConfirmPasswordImageView()
        confirmPasswordContainerView.addSubview(confirmPasswordTextField)
        setupConftirmPasswordTextField()
        confirmPasswordContainerView.addSeparatorLine(color: .lightGray)
        
        BackButton.layer.cornerRadius = 12
        BackButton.layer.masksToBounds = true
        
        registerButton.layer.cornerRadius = 8
        registerButton.layer.masksToBounds = true
        
        //Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 154
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
          emailTextField.resignFirstResponder()
          passwordTextField.resignFirstResponder()
          confirmPasswordTextField.resignFirstResponder()
           return true
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    //Name
    func setupNameContainerView() {
        nameContainerView.translatesAutoresizingMaskIntoConstraints = false
        nameContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameContainerView.topAnchor.constraint(equalTo: logoNameLabel.bottomAnchor, constant: 86).isActive = true
        nameContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    func setupNameImageView() {
        nameImageView.translatesAutoresizingMaskIntoConstraints = false
        nameImageView.leadingAnchor.constraint(equalTo: nameContainerView.leadingAnchor).isActive = true
        nameImageView.centerYAnchor.constraint(equalTo: nameContainerView.centerYAnchor).isActive = true
        nameImageView.heightAnchor.constraint(equalTo: nameContainerView.heightAnchor, multiplier: 0.5).isActive = true
        nameImageView.widthAnchor.constraint(equalTo: nameContainerView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupNameTextField() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: nameContainerView.topAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameContainerView.bottomAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: nameContainerView.leadingAnchor, constant: 30).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: nameContainerView.trailingAnchor, constant: -20).isActive = true
    }
    
    //-----------------------------------------------------------
    
    //Email
    func setupEmailContainerView() {
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emailContainerView.topAnchor.constraint(equalTo: nameContainerView.bottomAnchor, constant: 14).isActive = true
        emailContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    func setupEmailImageView() {
        emailImageView.translatesAutoresizingMaskIntoConstraints = false
        emailImageView.leadingAnchor.constraint(equalTo: emailContainerView.leadingAnchor).isActive = true
        emailImageView.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor).isActive = true
        emailImageView.heightAnchor.constraint(equalTo: emailContainerView.heightAnchor, multiplier: 0.5).isActive = true
        emailImageView.widthAnchor.constraint(equalTo: emailContainerView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupEmailTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: emailContainerView.topAnchor).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: emailContainerView.bottomAnchor).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: emailContainerView.leadingAnchor, constant: 30).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: emailContainerView.trailingAnchor, constant: -20).isActive = true
    }
    
    //-----------------------------------------------------------
    
    
    //Password
    func setupPasswordContainerView() {
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        passwordContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        passwordContainerView.topAnchor.constraint(equalTo: emailContainerView.bottomAnchor, constant: 14).isActive = true
        passwordContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    func setupPasswordImageView() {
        passowrdImageView.translatesAutoresizingMaskIntoConstraints = false
        passowrdImageView.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor).isActive = true
        passowrdImageView.centerYAnchor.constraint(equalTo: passwordContainerView.centerYAnchor).isActive = true
        passowrdImageView.heightAnchor.constraint(equalTo: passwordContainerView.heightAnchor, multiplier: 0.5).isActive = true
        passowrdImageView.widthAnchor.constraint(equalTo: passwordContainerView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupPasswordTextField() {
           passwordTextField.translatesAutoresizingMaskIntoConstraints = false
           passwordTextField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor).isActive = true
           passwordTextField.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor).isActive = true
           passwordTextField.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor, constant: 30).isActive = true
           passwordTextField.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor, constant: -20).isActive = true
       }
    
   
    
    //------------------------------------------------------------
    
    //Confirm Password
    func setupConfirmPasswordContainerView() {
        confirmPasswordContainerView.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        confirmPasswordContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        confirmPasswordContainerView.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: 14).isActive = true
        confirmPasswordContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    func setupConfirmPasswordImageView() {
           confirmPassowrdImageView.translatesAutoresizingMaskIntoConstraints = false
           confirmPassowrdImageView.leadingAnchor.constraint(equalTo: confirmPasswordContainerView.leadingAnchor).isActive = true
           confirmPassowrdImageView.centerYAnchor.constraint(equalTo: confirmPasswordContainerView.centerYAnchor).isActive = true
           confirmPassowrdImageView.heightAnchor.constraint(equalTo: confirmPasswordContainerView.heightAnchor, multiplier: 0.54).isActive = true
           confirmPassowrdImageView.widthAnchor.constraint(equalTo: confirmPasswordContainerView.heightAnchor, multiplier: 0.54).isActive = true
       }
    
    func setupConftirmPasswordTextField() {
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordContainerView.topAnchor).isActive = true
        confirmPasswordTextField.bottomAnchor.constraint(equalTo: confirmPasswordContainerView.bottomAnchor).isActive = true
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: confirmPasswordContainerView.leadingAnchor, constant: 30).isActive = true
        confirmPasswordTextField.trailingAnchor.constraint(equalTo: confirmPasswordContainerView.trailingAnchor, constant: -20).isActive = true
    }
       
 
    
    
    

}
