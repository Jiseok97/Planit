//
//  TermsOfUseViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/25.
//

import UIKit

class TermsOfUseViewController: UIViewController {

    @IBOutlet weak var allCheckView: UIView!
    @IBOutlet weak var allCheckBtn: UIButton!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    var isCheck : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    // MARK: Set UI
    func setUI() {
        view.backgroundColor = UIColor.mainNavy
//        self.allCheckView.backgroundColor = UIColor.disabledColor
        
        
        // Set Button
        self.confirmBtn.isEnabled = false
        self.confirmBtn.layer.cornerRadius = 30
        self.setBtnColor()
    }
    
    
    func setBtnColor() {
        DispatchQueue.main.async {
            if !self.confirmBtn.isEnabled {
                self.confirmBtn.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
            } else {
                self.confirmBtn.backgroundColor = UIColor.white
            }
        }
    }
    
    @IBAction func testAct(_ sender: Any) {
        print("Tapped Button")
        
        if !confirmBtn.isEnabled {
            print("Confrim Button is True")
            self.confirmBtn.isEnabled = true
            self.confirmBtn.backgroundColor = UIColor.white
        } else {
            print("Confirm Button is False")
            self.confirmBtn.isEnabled = false
            self.confirmBtn.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        }
    }
    @IBAction func tappedBtn(_ sender: UIButton) {
        
        
        if !isCheck {
            if let image = UIImage(named: "Check") {
                sender.setImage(image, for: .normal)
                isCheck = true
            }
        } else {
            if let image = UIImage(systemName: "noCheck") {
                sender.setImage(image, for: .normal)
                isCheck = false
            }
        }
        
    }
    
}
