//
//  UberSegmentedControl.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 9/13/23.
//

import UIKit


class UberSegmentedControl: UISegmentedControl {
    
    private let segmentInset: CGFloat = 5.3
    private let segmentImage: UIImage? = UIImage(color: UIColor.white)
    
    override init(items: [Any]?) {
        super.init(items: items)
        // properties
        backgroundColor = Color.textField_bg
        isSelected = true
        selectedSegmentIndex = 0
        clipsToBounds = true
        layer.masksToBounds = true
        setTitleTextAttributes([.font: UIFont(name: Font.medium.rawValue, size: 15)!], for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //background
        layer.cornerRadius = bounds.height/2
        //foreground
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView
        {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            foregroundImageView.image = segmentImage    //substitute with our own colored image
            foregroundImageView.layer.removeAnimation(forKey: "SelectionBounds")    //this removes the weird scaling animation!
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.layer.cornerRadius = foregroundImageView.bounds.height/2
        }
    }
}

extension UIImage{
    //creates a UIImage given a UIColor
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
