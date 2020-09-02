//
//  PreRegisterViewController.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 06.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit

class PreRegisterViewController: UIViewController, UITextViewDelegate{

    
    @IBOutlet weak var shopperButton: UIButton!
    @IBOutlet weak var designerButton: UIButton!
    
    @IBOutlet weak var textView1: UITextView!
    @IBOutlet weak var textView2: UITextView!
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shopperButton.layer.cornerRadius = 4
        shopperButton.layer.masksToBounds = true
        designerButton.layer.cornerRadius = 4
        designerButton.layer.masksToBounds = true
        textView1.isEditable = false
        textView2.isEditable = false
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReg" {
            if let destination = segue.destination as? RegisterViewController {
                if let button = sender as? UIButton {
                    destination.name = button.currentTitle!
                    if button.currentTitle! == "Покупатель" {
                        destination.isDesigner = false
                    }else {
                        destination.isDesigner = true
                    }
                }
            }
        }
        
    }
    

    

}
