//
//  ExtentionsButton.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 04.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func underline() {
        guard let title = self.titleLabel else { return }
        guard let tittleText = title.text else { return }
        let attributedString = NSMutableAttributedString(string: (tittleText))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (tittleText.count)))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}


