//
//  UberButton.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 16/11/2022.
//

import UIKit

class UberButton: UIButton {

    private var animator: UIViewPropertyAnimator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK:  properties -
        translatesAutoresizingMaskIntoConstraints = false
        // setup button targets
        addTarget(self, action: #selector(handleTouchDown), for: .touchDown)
        addTarget(self, action: #selector(handleTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(handleTouchUpOutside), for: .touchUpOutside)
        
        addTarget(self, action: #selector(handleHoverIn), for: .touchDragEnter)
        addTarget(self, action: #selector(handleHoverOut), for: .touchDragExit)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTouchDown(){
        animateButton(scaleX: 0.97, scaleY: 0.97)
    }
    
    @objc func handleTouchUpInside(){
        animateButton(scaleX: 1.0, scaleY: 1.0)
    }
    
    @objc func handleTouchUpOutside(){
        animateButton(scaleX: 1.0, scaleY: 1.0)
    }
    
    @objc func handleHoverIn(){
        animateButton(scaleX: 1.02, scaleY: 1.02)
    }
    
    @objc func handleHoverOut(){
        animateButton(scaleX: 1.0, scaleY: 1.0)
    }
    
    private func animateButton(scaleX: CGFloat, scaleY: CGFloat){
        animator?.stopAnimation(true)
        
        animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.8,animations: {
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        })
        
        animator?.startAnimation()
    }
}
