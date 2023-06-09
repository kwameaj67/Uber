//
//  Helpers.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 20/11/2022.
//

import Foundation
import UIKit


func delay(duration: Double, completion: @escaping () -> Void ){
    DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: completion)
}

func playHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle){
    let haptic = UIImpactFeedbackGenerator(style: style)
    haptic.impactOccurred()
}
