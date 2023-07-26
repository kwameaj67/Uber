//
//  UIImage+Ext.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 7/26/23.
//

import UIKit



extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: size))
        self.withTintColor(.white)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
