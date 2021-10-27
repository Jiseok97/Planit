//
//  UIViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/24.
//

import UIKit

extension UIViewController {
    
    
    // MARK: Show Indicator
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: DisMiss Indicator
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }

    
    // MARK: 왼쪽 제스처 dismiss
    func swipeRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                self.navigationController?.popViewController(animated: true)
            default: break
            }
        }
    }
    
}
