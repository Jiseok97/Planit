//
//  UIViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/24.
//

import UIKit
import Lottie

extension UIViewController {
    
    // MARK: Change Root VC
    func changeRootVC(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    
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
    
    
    
    
    // MARK: Add Dday VC
    func setElseBtnColors(_ btn1: UIButton, _ btn2: UIButton, _ btn3: UIButton, _ btn4: UIButton) {
        setBtnColors(btn1, false)
        setBtnColors(btn2, false)
        setBtnColors(btn3, false)
        setBtnColors(btn4, false)
    }
    func setBtnColors(_ btn: UIButton, _ checkClicked: Bool) {
        if checkClicked {
            btn.backgroundColor = UIColor.link
        } else {
            btn.backgroundColor = UIColor.homeBorderColor
        }
    }
    
    
    // MARK: Change Bool Value for UIButton
    func changeBoolValue(buttonChecked: Bool) -> Bool {
        if !buttonChecked {
            return true
        } else {
            return false
        }
    }
    
    // Register - Select Job
    func setElseBtnColor(_ btn1: UIButton, _ btn2: UIButton, _ btn3: UIButton, _ btn4: UIButton, _ btn5: UIButton, _ btn6: UIButton, _ btn7: UIButton) {
        setBtnColor(btn1, false)
        setBtnColor(btn2, false)
        setBtnColor(btn3, false)
        setBtnColor(btn4, false)
        setBtnColor(btn5, false)
        setBtnColor(btn6, false)
        setBtnColor(btn7, false)
    }
    func setBtnColor(_ btn: UIButton, _ checkClick: Bool) {
        if checkClick {
            btn.backgroundColor = UIColor.link
            btn.setTitleColor(UIColor.myGray, for: .normal)
        } else {
            btn.backgroundColor = UIColor.disabledColor.withAlphaComponent(1.0)
            btn.setTitleColor(UIColor.placeHolderColor, for: .normal)
        }
    }
    
    
    
    // MARK: Add Study VC
    func setElseDaysBtnColor(_ btn1: UIButton, _ btn2: UIButton, _ btn3: UIButton, _ btn4: UIButton, _ btn5: UIButton, _ btn6: UIButton, _ btn7: UIButton) {
        tappedDayBtn(btn1, false)
        tappedDayBtn(btn2, false)
        tappedDayBtn(btn3, false)
        tappedDayBtn(btn4, false)
        tappedDayBtn(btn5, false)
        tappedDayBtn(btn6, false)
        tappedDayBtn(btn7, false)
    }
    func tappedDayBtn(_ btn: UIButton, _ check: Bool) {
        if !check {
            btn.backgroundColor = UIColor.homeBorderColor
            btn.setTitleColor(UIColor.placeHolderColor, for: .normal)
        } else {
            btn.backgroundColor = UIColor.link
            btn.setTitleColor(UIColor.myGray, for: .normal)
        }
    }
    
    
    
    func setEnableBtn(_ btn: UIButton) {
        btn.backgroundColor = UIColor.enableBtnColor
        btn.isEnabled = false
    }
    
    func setAbleBtn(_ btn: UIButton) {
        btn.backgroundColor = UIColor.white
        btn.isEnabled = true
    }
    
    
    func sethiddenLblImg(_ imgView: UIImageView, _ lbl: UILabel) {
        lbl.isHidden = true
        imgView.isHidden = true
    }
    
    func setShowErrorLblImg(_ imgView: UIImageView, _ lbl: UILabel, _ txt: String) {
        lbl.text = txt
        lbl.isHidden = false
        imgView.isHidden = false
    }
    
    
    
    // InputUserNameVC
    func tfIsEmpty(_ tf: UITextField, _ btn: UIButton) {
        if tf.text?.isEmpty == true {
            setEnableBtn(btn)
        } else {
            setAbleBtn(btn)
        }
    }
    
    
    func setGradation() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.colors = [UIColor.gradationStartColor.cgColor, UIColor.mainNavy.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.zPosition = 0
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func limitBtnSetup(_ btn: UIButton) {
        btn.backgroundColor = .mainNavy
        btn.setTitleColor(UIColor.homeBorderColor, for: .normal)
        btn.isEnabled = false
    }
    
    
    
    // MARK: For Lottie
    func bgLottie(lottieView: AnimationView, view: UIView) {
        let centerX = NSLayoutConstraint(item: lottieView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: lottieView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: lottieView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 35)
        let height = NSLayoutConstraint(item: lottieView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 35)
        
        view.addConstraints([ centerX, centerY, width, height ])
        
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.contentMode = .scaleAspectFill
        lottieView.loopMode = .loop
        lottieView.play()
    }
    
    func actionLottie(lottieView: AnimationView, view: UIView) {
        let centerX = NSLayoutConstraint(item: lottieView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: lottieView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: lottieView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: lottieView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
        
        view.addConstraints([ centerX, centerY, width, height ])
        view.isUserInteractionEnabled = false
        lottieView.contentMode = .scaleAspectFill
    }
    
    func satisfyLottie(lottieView: AnimationView, view: UIView) {
        let centerX2 = NSLayoutConstraint(item: lottieView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY2 = NSLayoutConstraint(item: lottieView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        let width2 = NSLayoutConstraint(item: lottieView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        let height2 = NSLayoutConstraint(item: lottieView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
        
        view.addConstraints([ centerX2, centerY2, width2, height2 ])
        
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.contentMode = .scaleAspectFill
        lottieView.loopMode = .loop
        lottieView.play()
    }
    
    
    func eachDeviceHeight() {
        let height = UIScreen.main.bounds.size.height
        
        switch height {
        case 926:
            print("iPhone 12 Pro Max, iPhone 13 Pro Max")
            
        case 780:
            print("iPhone 12 mini")
            
        case 844:
            print("iPhone 12, 12 Pro, iPhone 13, 13 Pro, ")
            
        case 667:
            print("iPhone 2SE, iPhone 7, iPhone 8")
            
        case 896:
            print("iPhone 11 Pro Max, iPhone 11, iPhone Xs Max, iPhone XR")
            
        case 812:
            print("iPhone 11 Pro, iPhone X, Xs, iPhone 13 mini")
            
        case 736:
            print("iPHone 6+, 6+s, 7+, 8+")
            
        default:
            print("제일작은 사이즈 가정( iPhone SE)")
        }
    }
    
}
