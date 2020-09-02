//
//  PayProductsViewController.swift
//  
//
//  Created by Глеб Никитенко on 03.06.2020.
//

import UIKit
import DTTextField

class PayProductsViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameTextField: DTTextField!
    
    @IBOutlet weak var addresTextField: DTTextField!
    
    
    @IBOutlet weak var indexTextField: DTTextField!
    
    
    @IBOutlet weak var numberOfCardTextField: DTTextField!
    
    @IBOutlet weak var buyButton: UIButton!
    
    @IBAction func buyButtonAction(_ sender: UIButton) {
        if nameTextField.text != "" && addresTextField.text != "" && indexTextField.text != "" && numberOfCardTextField.text != "" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc2 = storyboard.instantiateViewController(withIdentifier: "SuccesfulViewController") as! SuccesfulViewController
            self.navigationController?.pushViewController(vc2, animated: true)
        }else {
            print("Поля не заполнены")
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        buyButton.layer.cornerRadius = 8
        buyButton.layer.masksToBounds = true
        
        
        nameTextField.delegate = self
        addresTextField.delegate = self
        indexTextField.delegate = self
        numberOfCardTextField.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 100
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
          addresTextField.resignFirstResponder()
          indexTextField.resignFirstResponder()
          numberOfCardTextField.resignFirstResponder()
          return true
      }
      
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
    

    
}
