//
//  UINavigationController+Extensions.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import UIKit
import Foundation

extension UINavigationController {
    
    func pushFadeAnimation(viewController: UIViewController) {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
        view.layer.removeAllAnimations()
    }
    
    func popFadeAnimation() {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.layer.add(transition, forKey: nil)
        popViewController(animated: false)
        view.layer.removeAllAnimations()
    }
}


