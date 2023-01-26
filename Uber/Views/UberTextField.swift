//
//  UberTextField.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 17/11/2022.
//

import UIKit

class UberTextField: UITextField {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.textField_bg
        autocapitalizationType = .none
        autocorrectionType = .no
        font = UIFont(name: Font.medium.rawValue, size: 15)
        attributedPlaceholder = NSAttributedString(string: "", attributes: [.foregroundColor: UIColor.systemGray3,.font: UIFont(name: Font.regular.rawValue, size: 16)!])
        borderStyle = .none
        textColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        clearButtonMode = .whileEditing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UberTextField {
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 20, dy: 0)
        }
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 20, dy: 0)
        }
}
