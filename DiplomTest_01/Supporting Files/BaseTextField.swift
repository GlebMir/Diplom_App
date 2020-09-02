//
//  BaseTextField.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 05.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    init(placeHolder: String? = nil) {
        super.init(frame: CGRect.zero)
        font = UIFont.systemFont(ofSize: 16)
        returnKeyType = .next
        
        attributedPlaceholder = NSAttributedString(string: placeHolder ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        autocorrectionType = .no
        autocapitalizationType = .none
        enablesReturnKeyAutomatically = true
        
        tintColor = .lightGray
        textColor = UIColor.white
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 45)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
