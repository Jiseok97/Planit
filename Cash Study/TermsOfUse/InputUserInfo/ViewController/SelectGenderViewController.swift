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
    }
    
    @IBAction func selectedGender(_ sender: UIButton) {
        switch sender {
            case manBtn:
                self.manBtnClicked = changeBoolValue(buttonChecked: manBtnClicked)
                setBtnColor(manBtn, manBtnClicked)
                self.womanBtnClicked = false
                setBtnColor(womanBtn, womanBtnClicked)
                myGenderIs = "MALE"
            default:
                self.womanBtnClicked = changeBoolValue(buttonChecked: womanBtnClicked)
                setBtnColor(womanBtn, womanBtnClicked)
                self.manBtnClicked = false
                setBtnColor(manBtn, manBtnClicked)
                myGenderIs = "FEMALE"
        }
    }
    
    
    @IBAction func moveInputBirthdatVC(_ sender: Any) {
        guard let ibVC = self.storyboard?.instantiateViewController(identifier: "InputBirthdayViewController") as? InputBirthdayViewController else { return }
        
        self.navigationController?.pushViewController(ibVC, animated: false)
    }
    
    
}
