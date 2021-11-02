//
//  TermsOfUseViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/25.
//

import UIKit

class TermsOfUseViewController: UIViewController {
    
    @IBOutlet weak var allCheckView: UIView!
    @IBOutlet weak var selectiveView: UIView!
    
    @IBOutlet weak var allCheckBtn: UIButton!
    @IBOutlet weak var firstCheckBox: UIButton!
    @IBOutlet weak var secondCheckBox: UIButton!
    @IBOutlet weak var thirdCheckBox: UIButton!
    @IBOutlet weak var fourthCheckBox: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
   
    var allCheck : Bool = false
    var firstCheck : Bool = false
    var secondCheck : Bool = false
    var thirdCheck : Bool = false
    var fourthCheck : Bool = false
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    
    // MARK: Set UI
    func setUI() {
        self.allCheckView.layer.cornerRadius = 11
        self.selectiveView.layer.cornerRadius = 11
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        
        self.confirmBtn.isEnabled = false
        self.confirmBtn.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
    }

    // MARK: 이용약관 체크박스
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        switch sender {
        case allCheckBtn:
            self.allCheck = changeBoolValue(buttonChecked: allCheck)
            
            if sender.isSelected {
                sender.isSelected = false
                firstCheckBox.isSelected = false
                secondCheckBox.isSelected = false
                thirdCheckBox.isSelected = false
                fourthCheckBox.isSelected = false


            } else {
                sender.isSelected = true
                firstCheckBox.isSelected = true
                secondCheckBox.isSelected = true
                thirdCheckBox.isSelected = true
                fourthCheckBox.isSelected = true

            }
            checkButtonStatus()
            
        case firstCheckBox:
            self.allCheckBtn.isSelected = false
            sender.isSelected = changeBoolValue(buttonChecked: sender.isSelected)
            checkButtonStatus()
            
        case secondCheckBox:
            self.allCheckBtn.isSelected = false
            sender.isSelected = changeBoolValue(buttonChecked: sender.isSelected)
            checkButtonStatus()
            
        case thirdCheckBox:
            self.allCheckBtn.isSelected = false
            sender.isSelected = changeBoolValue(buttonChecked: sender.isSelected)
            checkButtonStatus()
            
        default:
            self.allCheckBtn.isSelected = false
            sender.isSelected = changeBoolValue(buttonChecked: sender.isSelected)
            checkButtonStatus()
            
        }
    }
    
    
    func checkButtonStatus() {
        if firstCheckBox.isSelected && secondCheckBox.isSelected {
            self.confirmBtn.backgroundColor = UIColor.white
            self.confirmBtn.isEnabled = true
        } else {
            self.confirmBtn.isEnabled = false
            self.confirmBtn.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        }
    }

    
    
    // MARK: 다음으로 이동
    @IBAction func nextVC(_ sender: Any) {
        
        guard let navigation = UIStoryboard(name: "InputUserInfo", bundle: nil).instantiateViewController(identifier: "NavigationViewController") as? NavigationViewController else { return }
        
        navigation.modalPresentationStyle = .overFullScreen
        self.present(navigation, animated: true, completion: nil)
    }
    
    
    
}
