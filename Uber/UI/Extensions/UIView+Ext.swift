//
//  UIView+Ext.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 16/11/2022.
//

import UIKit

extension UIView {
    
    func pinToSafeArea(to superview: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func pinToEdges(to superview: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingRight: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil
    ){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(in view: UIView){
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(in view: UIView){
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func addBottomShadowsToView(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3.0
        layer.shadowOffset =  CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
    }
    
    func addConstrainedSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }

    func addConstrainedSubviews(_ views: UIView...) {
        views.forEach { view in addConstrainedSubview(view) }
    }
    
    func hide(){
        ratingsView.isHidden = true
        ratingsView.alpha = 0
    }
    
    func show(){
        ratingsView.isHidden = false
        ratingsView.alpha = 1
    }
}
