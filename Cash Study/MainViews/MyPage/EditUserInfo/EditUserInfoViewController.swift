//
//  EditUserInfoViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

import UIKit

class EditUserInfoViewController: UIViewController, UITextFieldDelegate {
    
    
//    @IBOutlet weak var nameView: UIView!
//    @IBOutlet weak var nameTF: UITextField! {
//        didSet {
//            nameTF.delegate = self
//        }
//    }
    
    
    @IBOutlet weak var nicknameView: UIView!
    @IBOutlet weak var nicknameTF: UITextField! {
        didSet {
            nicknameTF.delegate = self
        }
    }
    @IBOutlet weak var nicknameErrorImgView: UIImageView!
    @IBOutlet weak var nicknameErrorLbl: UILabel!
    
    @IBOutlet var categoryBtns: [UIButton]!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var fifthBtn: UIButton!
    @IBOutlet weak var sixthBtn: UIButton!
    @IBOutlet weak var seventhBtn: UIButton!
    @IBOutlet weak var eighthBtn: UIButton!
    
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    var nicknameError: Bool = false
    
    var firstBtnClicked: Bool = false
    var secondBtnClicked: Bool = false
    var thirdBtnClicked: Bool = false
    var fourthBtnClicked: Bool = false
    var fifthBtnClicked: Bool = false
    var sixthBtnClicked: Bool = false
    var seventhBtnClicked: Bool = false
    var eighthBtnClicked: Bool = false
    
    var userCategory : String = ""
    var checkUserNickName: Bool = true
    var isSuccess: Bool = false {
        didSet {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    var userInfoData : ShowUserInfoEntity?
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        swipeRecognizer()
        
        showIndicator()
        ShowUserInfoDataManager().showUserInfoEditVC(viewController: self)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textLengthLimit(_:)), name: UITextField.textDidChangeNotification, object: nicknameTF)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nicknameTF)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    // MARK: Functions
    
    func setUI() {
//        self.nameView.layer.cornerRadius = 11
        self.nicknameView.layer.cornerRadius = 11
        
        self.categoryBtns.forEach {
            $0.layer.cornerRadius = 11
        }
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        
        if nicknameError {
            setShowErrorLblImg(self.nicknameErrorImgView, self.nicknameErrorLbl, "닉네임 형식이 올바르지 않습니다.")
            setEnableBtn(self.confirmBtn)
            
        } else {
            sethiddenLblImg(self.nicknameErrorImgView, self.nicknameErrorLbl)
            setAbleBtn(self.confirmBtn)
        }
        
        setEnableBtn(confirmBtn)
        
    }
    
    @objc private func textLengthLimit(_ noti: Notification) {
        let maxLength : Int = 8
        if let textField = noti.object as? UITextField {
            if let text = textField.text {
                if text.count > maxLength {
                    setShowErrorLblImg(nicknameErrorImgView, nicknameErrorLbl, "닉네임은 8글자 이내로 입력해주세요.")
                    setEnableBtn(confirmBtn)
                } else {
                    guard let userNickName = self.nicknameTF.text else { return }
                    guard let userPreNickName = self.userInfoData?.nickname else { return }
                    sethiddenLblImg(nicknameErrorImgView, nicknameErrorLbl)
                    
                    let input = EditnicknameInput(nickname: userNickName, previousNickname: userPreNickName)
                    NickNameDataManager().validateEditNickName(input, viewController: self)
                }
            }
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        if string.hasCharacters() || isBackSpace == -92{
            return true
        }
        return false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == nameTF {
//            nicknameTF.becomeFirstResponder()
//        } else {
//            textField.resignFirstResponder()
//        }
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func selectCategoryBtns(_ sender: UIButton) {
        
        switch sender {
        case firstBtn:
            self.firstBtnClicked = changeBoolValue(buttonChecked: firstBtnClicked)
            setBtnColor(firstBtn, firstBtnClicked)
            setElseBtnColor(secondBtn, thirdBtn, fourthBtn, fifthBtn, sixthBtn, seventhBtn, eighthBtn)
            
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false

            setAbleConfirmBtn()
            userCategory = "ELEMENTARY_SCHOOL"
            
            
        case secondBtn:
            self.secondBtnClicked = changeBoolValue(buttonChecked: secondBtnClicked)
            setBtnColor(secondBtn, secondBtnClicked)
            setElseBtnColor(firstBtn, thirdBtn, fourthBtn, fifthBtn, sixthBtn, seventhBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false

            setAbleConfirmBtn()
            userCategory = "MIDDLE_SCHOOL"
            
            
        case thirdBtn:
            self.thirdBtnClicked = changeBoolValue(buttonChecked: thirdBtnClicked)
            setBtnColor(thirdBtn, thirdBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, fourthBtn, fifthBtn, sixthBtn, seventhBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false
            
            setAbleConfirmBtn()
            userCategory = "HIGH_SCHOOL"
            
            
        case fourthBtn:
            self.fourthBtnClicked = changeBoolValue(buttonChecked: fourthBtnClicked)
            setBtnColor(fourthBtn, fourthBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, thirdBtn, fifthBtn, sixthBtn, seventhBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false

            setAbleConfirmBtn()
            userCategory = "NNTH_EXAM"
            
        case fifthBtn:
            self.fifthBtnClicked = changeBoolValue(buttonChecked: fifthBtnClicked)
            setBtnColor(fifthBtn, fifthBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, thirdBtn, fourthBtn, sixthBtn, seventhBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false

            setAbleConfirmBtn()
            userCategory = "UNIVERSITY"
            
        case sixthBtn:
            self.sixthBtnClicked = changeBoolValue(buttonChecked: sixthBtnClicked)
            setBtnColor(sixthBtn, sixthBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, thirdBtn, fourthBtn, fifthBtn, seventhBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false

            setAbleConfirmBtn()
            userCategory = "EXAM_PREP"
            
        case seventhBtn:
            self.seventhBtnClicked = changeBoolValue(buttonChecked: seventhBtnClicked)
            setBtnColor(seventhBtn, seventhBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, thirdBtn, fourthBtn, fifthBtn, sixthBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.eighthBtnClicked = false
            
            setAbleConfirmBtn()
            userCategory = "JOB_PREP"
            
        default:
            self.eighthBtnClicked = changeBoolValue(buttonChecked: eighthBtnClicked)
            setBtnColor(eighthBtn, eighthBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, thirdBtn, fourthBtn, fifthBtn, sixthBtn, seventhBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            
            setAbleConfirmBtn()
            userCategory = "WORKER"
        }
        
    }
    
    func setAbleConfirmBtn() {
        if firstBtnClicked || secondBtnClicked || thirdBtnClicked || fourthBtnClicked || fifthBtnClicked || sixthBtnClicked || seventhBtnClicked || eighthBtnClicked {
            checkConfirmBtn(check: true)
        } else {
            checkConfirmBtn(check: false)
        }
    }
    
    func checkConfirmBtn(check: Bool) {
//        if self.nameTF.text?.isEmpty == false && checkUserNickName == true && check == true {
//            setAbleBtn(confirmBtn)
//        } else {
//            setEnableBtn(confirmBtn)
//        }
        
        if checkUserNickName == true && check == true {
            setAbleBtn(confirmBtn)
        } else {
            setEnableBtn(confirmBtn)
        }
    }
    
    
    @IBAction func confirmBtnTapped(_ sender: Any) {
//        guard let name = self.nameTF.text else { return }
        guard let name = userInfoData?.name else { return }
        guard let nickname = self.nicknameTF.text else { return }
        
        let input = EditUserInfoInput(name: name, nickname: nickname, category: self.userCategory)
        EditUserInfoDataManager().editUserInfo(input, viewController: self)
        
    }
    
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension EditUserInfoViewController {
    func showUserInfo(result: ShowUserInfoEntity) {
        self.dismissIndicator()
        self.userInfoData = result
        if userInfoData != nil {
//            guard let userName = userInfoData?.name else { return }
            guard let userNickName = userInfoData?.nickname else { return }
            
//            self.nameTF.text = userName
            self.nicknameTF.text = userNickName
        }
        
    }
}
