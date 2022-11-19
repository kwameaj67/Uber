//
//  UIViewController+Ext.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 19/11/2022.
//

import UIKit

extension UIViewController{
    func presentAlertError(title: String, message: String ){
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
}
