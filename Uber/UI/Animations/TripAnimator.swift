//
//  TripAnimator.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 8/11/23.
//

import Foundation
import UIKit

class TripAnimator {
    class func animate(cell: UITableViewCell, indexPath: IndexPath){
        let view = cell.contentView
        view.transform = CGAffineTransform(translationX: 0, y: 20)
        view.alpha = 0
        let delay = 0.2 * Double(indexPath.row)
        UIView.animateKeyframes(withDuration: 2, delay: delay, options: [], animations: {
            view.transform = CGAffineTransform(translationX: 0, y: 0)
            view.alpha = 1
        }, completion: nil)
    }
}
