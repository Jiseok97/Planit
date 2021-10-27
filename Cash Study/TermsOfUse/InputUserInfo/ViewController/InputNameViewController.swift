//
//  InputNameViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/26.
//

import UIKit

class InputNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nickNameView: UIView!
    
    @IBOutlet weak var nameTF: UITextField! {
        didSet {
            nameTF.delegate = self
        }
    }
    @IBOutlet weak var nickNameTF: UITextField! {
        didSet {
            nickNameTF.delegate = self
        }
    }
    
    @IBOutlet weak var nickNameError: UIImageView!
    @IBOutlet weak var nickNameErrorLbl: UILabel!
    
    
    var name: String?
    var nickName: String?
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    
    // MAKR: Functions
    func setUI() {
        self.nameTF.setPlaceHolderColor(UIColor.placeHolderColor)
        self.nickNameTF.setPlaceHolderColor(UIColor.placeHolderColor)
        self.nameView.layer.cornerRadius = 11
        self.nickNameView.layer.cornerRadius = 11
        self.nextBtn.layer.cornerRadius = nextBtn.frame.height / 2
        
//        clearBtnTF()
//        dismissKeyboardWhenTappedAround()
        
        self.nickNameError.isHidden = true
        self.nickNameErrorLbl.isHidden = true
    }
    
    func alreadyExistNickName() {
        self.nickNameError.isHidden = false
        self.nickNameErrorLbl.isHidden = false
    }
    
    
    // MARK: 텍스트 클리어 버튼
    func clearBtnTF() {
        self.nameTF.clearButtonMode = .always
        self.nameTF.clearButtonMode = .whileEditing
        self.nickNameTF.clearButtonMode = .always
        self.nickNameTF.clearButtonMode = .whileEditing
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTF {
            nickNameTF.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    // MARK: 성별 선택 뷰 이동
    @IBAction func moveSelectGenderVC(_ sender: Any) {
        guard let sgVC = self.storyboard?.instantiateViewController(identifier: "SelectGenderViewController") as? SelectGenderViewController else { return }
        
        self.navigationController?.pushViewController(sgVC, animated: false)
    }
    
}
