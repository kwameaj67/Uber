//
//  UILabel+Ext.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 21/11/2022.
//

import UIKit

extension UILabel {
  func letterSpacing(value: Double) {
    if let textString = self.text {
      let attributedString = NSMutableAttributedString(string: textString)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}
