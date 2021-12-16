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
    @IBOutlet weak var noSelectBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var manBtnClicked: Bool = false
    var womanBtnClicked: Bool = false
    var noSelectClicked: Bool = false
    var userSex: String = ""
    
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
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        
        self.manBtn.contentHorizontalAlignment = .left
        self.womanBtn.contentHorizontalAlignment = .left
        
        swipeRecognizer()
        setEnableBtn(confirmBtn)
    }
    
    @IBAction func selectedGender(_ sender: UIButton) {
        switch sender {
        case manBtn:
            self.manBtnClicked = changeBoolValue(buttonChecked: manBtnClicked)
            setBtnColor(manBtn, manBtnClicked)
            self.womanBtnClicked = false
            setBtnColor(womanBtn, womanBtnClicked)
            userSex = "MALE"
            setAbleBtnState()
            
        default:
            self.womanBtnClicked = changeBoolValue(buttonChecked: womanBtnClicked)
            setBtnColor(womanBtn, womanBtnClicked)
            self.manBtnClicked = false
            setBtnColor(manBtn, manBtnClicked)
            userSex = "FEMALE"
            setAbleBtnState()
        }
    }
    
    
    func setAbleBtnState() {
        if manBtnClicked || womanBtnClicked {
            setAbleBtn(confirmBtn)
        } else {
            setEnableBtn(confirmBtn)
        }
        
    }
    
    
    @IBAction func moveInputBirthdatVC(_ sender: UIButton) {
        switch sender {
        case confirmBtn:
            let sbName = UIStoryboard(name: "InputBirthday", bundle: nil)
            let ibSB = sbName.instantiateViewController(identifier: "InputBirthdayViewController")
            
            UserInfoData.sex = userSex
            self.navigationController?.pushViewController(ibSB, animated: false)
            
        default:
            let sbName = UIStoryboard(name: "InputBirthday", bundle: nil)
            let ibSB = sbName.instantiateViewController(identifier: "InputBirthdayViewController")
            
            UserInfoData.sex = nil
            self.navigationController?.pushViewController(ibSB, animated: false)
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
