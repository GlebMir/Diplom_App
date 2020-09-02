//
//  ViewController.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 04.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Добавил Git
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logoName: UILabel!
    
    @IBOutlet weak var warnLabel: UILabel!
    
    private let emailContainerView = UIView()
    private let passwordContainerView = UIView()
    
    private let forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Забыли пароль?"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    
    //Обработка ошибки
    func displayWarningLabel(withText text: String) {
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }) { [weak self] complete in
            self?.warnLabel.alpha = 0
        }
    }
    
    //ВХОД
    @IBAction func signInAction(_ sender: UIButton) {
        self.view.endEditing(true)
        ProgressHUD.show("Вход..", interaction: false)
        guard let email = emailTextField.text, let password = passwordTextField.text, emailTextField.text != "", passwordTextField.text != "" else {
            ProgressHUD.dismiss()
            displayWarningLabel(withText: "Поля не заполнены")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                ProgressHUD.dismiss()
                self?.displayWarningLabel(withText: "Error Firebase")
                return
            }
            if user != nil {
                //Успешно
                ProgressHUD.dismiss()
                self?.performSegue(withIdentifier: "loginSegue", sender: nil)
                return
            } else {
                ProgressHUD.dismiss()
                self?.displayWarningLabel(withText: "Пользователь не найден")
            }
            
            
            
        }
        
        
    }
    
    
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
    
     
    private lazy var emailTextField: BaseTextField = {
        let tf = BaseTextField(placeHolder: "Email")
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .clear
        tf.delegate = self as UITextFieldDelegate
        return tf
    }()
    
     private lazy var passwordTextField: BaseTextField = {
        let tf = BaseTextField(placeHolder: "Пароль")
        tf.backgroundColor = .clear
        tf.isSecureTextEntry = true
        tf.delegate = self as UITextFieldDelegate
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 8
        loginButton.layer.masksToBounds = true
        registerButton.underline()
        warnLabel.alpha = 0
        //Email
        view.addSubview(emailContainerView)
        setupEmailContainerView()
        emailContainerView.addSubview(emailImageView)
        setupEmailImageView()
        emailContainerView.addSeparatorLine(color: .lightGray)
        emailContainerView.addSubview(emailTextField)
        setupEmailTextField()
        
        //Password
        view.addSubview(passwordContainerView)
        setupPasswordContainerView()
        passwordContainerView.addSeparatorLine(color: .lightGray)
        passwordContainerView.addSubview(passowrdImageView)
        setupPasswordImageView()
        passwordContainerView.addSubview(passwordTextField)
        setupPasswordTextField()
        
        //Label
        view.addSubview(forgotPasswordLabel)
        setupForgotPasswordLabel()
        
        //KeyBoard
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Запоминаем вход пользователя
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
        
     //Email
     func setupEmailContainerView() {
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emailContainerView.topAnchor.constraint(equalTo: logoName.bottomAnchor, constant: 94).isActive = true
        emailContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
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
    
    //Password
    func setupPasswordContainerView() {
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        passwordContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        passwordContainerView.topAnchor.constraint(equalTo: emailContainerView.bottomAnchor, constant: 20).isActive = true
        passwordContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
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
    
    func setupForgotPasswordLabel() {
        forgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordLabel.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: 7).isActive = true
        forgotPasswordLabel.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor).isActive = true
        forgotPasswordLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        forgotPasswordLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    
    
    

}


