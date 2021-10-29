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
    
    
    // MARK: 버튼 체크
    func setBtnColor(_ btn: UIButton, _ checkClick: Bool) {
        if checkClick {
            btn.backgroundColor = UIColor.link
            btn.setTitleColor(UIColor.white, for: .normal)
        } else {
            btn.backgroundColor = UIColor.disabledColor
            btn.setTitleColor(UIColor.systemGray2, for: .normal)
        }
    }
    
    func changeBoolValue(buttonChecked: Bool) -> Bool {
        if !buttonChecked {
            return true
        } else {
            return false
        }
    }
    
    func setElseBtnColor(_ btn1: UIButton, _ btn2: UIButton, _ btn3: UIButton, _ btn4: UIButton, _ btn5: UIButton, _ btn6: UIButton, _ btn7: UIButton) {
        setBtnColor(btn1, false)
        setBtnColor(btn2, false)
        setBtnColor(btn3, false)
        setBtnColor(btn4, false)
        setBtnColor(btn5, false)
        setBtnColor(btn6, false)
        setBtnColor(btn7, false)
    }
    
    
    
    func setEnableBtn(_ btn: UIButton) {
        btn.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        btn.isEnabled = false
    }
    
    func setAbleBtn(_ btn: UIButton) {
        btn.backgroundColor = UIColor.white
        btn.isEnabled = true
    }
    
}
