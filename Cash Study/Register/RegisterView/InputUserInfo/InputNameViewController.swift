//
//  InputNameViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/26.
//

import UIKit

class InputNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nickNameView: UIView!
    @IBOutlet weak var nickNameTF: UITextField! {
        didSet {
            nickNameTF.delegate = self
        }
    }
    @IBOutlet weak var nickNameError: UIImageView!
    @IBOutlet weak var nickNameErrorLbl: UILabel!
    
    var nameEmpty: Bool = true
    var checkUserNickName : Bool = false
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(textLengthLimit(_:)), name: UITextField.textDidChangeNotification, object: nickNameTF)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nickNameTF)
    }
    
    @objc private func textLengthLimit(_ noti: Notification) {
        let maxLength : Int = 8
        if let textField = noti.object as? UITextField {
            if let text = textField.text {
                if text.count > maxLength {
                    setShowErrorLblImg(nickNameError, nickNameErrorLbl, "닉네임은 8글자 이내로 입력해주세요.")
                    setEnableBtn(nextBtn)
                } else {
                    guard let userNickName = self.nickNameTF.text else { return }
                    let input = nickNameInput(nickname: userNickName)
                    NickNameDataManager().validateNickName(input, viewController: self)
                    sethiddenLblImg(nickNameError, nickNameErrorLbl)
                }
            }
        }
    }
    
    
    // MAKR: Functions
    func setUI() {
        self.nickNameTF.setPlaceHolderColor(UIColor.placeHolderColor)
        self.nickNameView.layer.cornerRadius = 11
        self.nextBtn.layer.cornerRadius = nextBtn.frame.height / 2
        
        sethiddenLblImg(self.nickNameError, self.nickNameErrorLbl)
        
        setEnableBtn(nextBtn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        if string.hasCharacters() || isBackSpace == -92{
            return true
        }
        return false
    }
    
    
    @IBAction func editChange(_ sender: UITextField) {
        tfIsEmpty(sender, nextBtn)
    }
    
    
    
    
    // MARK: 성별 선택 뷰 이동
    @IBAction func moveSelectGenderVC(_ sender: UIButton) {
        guard let userNickName = nickNameTF.text else { return }
        
        if checkUserNickName {
            UserInfoData.nickname = userNickName
            
            let sbName = UIStoryboard(name: "SelectGender", bundle: nil)
            let sgSB = sbName.instantiateViewController(identifier: "SelectGenderViewController")
            self.navigationController?.pushViewController(sgSB, animated: false)
        } else {
            return
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        changeRootVC(LoginViewController())
    }
    
}


