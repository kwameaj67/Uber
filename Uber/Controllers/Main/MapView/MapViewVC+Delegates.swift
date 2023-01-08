//
//  MapViewVC+Delegates.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 07/01/2023.
//

import UIKit

extension MapViewVC: OverLayLocationInputViewDelegate{
    func animateOverlayViews(){
        UIView.animate(withDuration: 0.5) {
            self.overlayLocationInputView.isHidden = false
            self.overlayLocationInputView.alpha = 1
            self.overlayLocationInputView.transform = .identity
        } completion: { _ in
            print("DEBUG: presents locationInputView...")
            // animate right after inputView is shown
            UIView.animate(withDuration: 0.3) {
                self.overlayLocationTableView.transform = .identity
                self.overlayLocationTableView.isHidden = false
                self.overlayLocationTableView.alpha = 1
            } completion: { _ in
                print("DEBUG: presents locationTableView...")
            }
        }
    }
    func hideOverlayViews(){
        UIView.animate(withDuration: 0.4) {
            self.overlayLocationInputView.transform = CGAffineTransform(translationX: 0, y: -200)
            self.overlayLocationTableView.transform = CGAffineTransform(translationX: 0, y: 800)
        } completion: { _ in
            self.overlayLocationInputView.isHidden = true
            self.overlayLocationInputView.alpha = 0
            
            self.overlayLocationTableView.isHidden = true
            self.overlayLocationTableView.alpha = 0
            print("DEBUG: hides locationInputView...")
        }
    }
    func dismissLocationInputView() {
        hideOverlayViews()
        dismiss(animated: true, completion: nil)
    }
}
extension MapViewVC: OverlayDestinationViewDelegate{
    func didTapSearchButton() {
        animateOverlayViews()
    }
}
