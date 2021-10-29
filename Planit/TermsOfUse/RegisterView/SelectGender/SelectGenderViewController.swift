//
//  SelectGenderViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/27.
//

import UIKit

class SelectGenderViewController: UIViewController {

    @IBOutlet weak var manView: UIView!
    @IBOutlet weak var womanView: UIView!
    
    @IBOutlet weak var manBtn: UIButton!
    @IBOutlet weak var womanBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var manBtnClicked: Bool = false
    var womanBtnClicked: Bool = false
    var myGenderIs: String = ""
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        self.manView.layer.cornerRadius = 11
        self.womanView.layer.cornerRadius = 11
        self.manBtn.layer.cornerRadius = 11
        self.womanBtn.layer.cornerRadius = 11
        self.manBtn.contentHorizontalAlignment = .left
        self.womanBtn.contentHorizontalAlignment = .left
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        swipeRecognizer()
        
        confirmBtn.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        confirmBtn.isEnabled = false
    }
    
    @IBAction func selectedGender(_ sender: UIButton) {
        switch sender {
        case manBtn:
            self.manBtnClicked = changeBoolValue(buttonChecked: manBtnClicked)
            setBtnColor(manBtn, manBtnClicked)
            self.womanBtnClicked = false
            setBtnColor(womanBtn, womanBtnClicked)
            myGenderIs = "MALE"
            setAbleBtn()
        default:
            self.womanBtnClicked = changeBoolValue(buttonChecked: womanBtnClicked)
            setBtnColor(womanBtn, womanBtnClicked)
            self.manBtnClicked = false
            setBtnColor(manBtn, manBtnClicked)
            myGenderIs = "FEMALE"
            setAbleBtn()
        }
    }
    
    
    func setAbleBtn() {
        if manBtnClicked || womanBtnClicked {
            confirmBtn.backgroundColor = UIColor.white
            confirmBtn.isEnabled = true
        } else {
            confirmBtn.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
            confirmBtn.isEnabled = false
        }
        
    }
    
    
    @IBAction func moveInputBirthdatVC(_ sender: Any) {
        let sbName = UIStoryboard(name: "InputBirthday", bundle: nil)
        let ibSB = sbName.instantiateViewController(identifier: "InputBirthdayViewController")
        
        
        print("사용자의 성별은 \(myGenderIs)입니다.")
        self.navigationController?.pushViewController(ibSB, animated: false)
    }
    
    
}
