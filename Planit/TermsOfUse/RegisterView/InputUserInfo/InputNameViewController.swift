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
    
    var isNotEmpty: Bool = false
    var checkNickNameValue : Bool = true
    
    
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
                    nickNameErrorLbl.isHidden = false
                    nickNameErrorLbl.text = "닉네임은 8글자 이내로 입력해주세요."
                    nickNameError.isHidden = false
                } else {
                    nickNameError.isHidden = true
                    nickNameErrorLbl.isHidden = true
                }
                
                if text.count >= maxLength {
                    let idx = text.index(text.startIndex, offsetBy: maxLength)
                    let newText = text[text.startIndex..<idx]
                    textField.text = String(newText)
                }
                
                // 닉네임 중복 추가하기
                
            }
        }
    }
    
    
    // MAKR: Functions
    func setUI() {
        self.nameTF.setPlaceHolderColor(UIColor.placeHolderColor)
        self.nickNameTF.setPlaceHolderColor(UIColor.placeHolderColor)
        self.nameView.layer.cornerRadius = 11
        self.nickNameView.layer.cornerRadius = 11
        self.nextBtn.layer.cornerRadius = nextBtn.frame.height / 2 - 5
        
        self.nickNameError.isHidden = true
        self.nickNameErrorLbl.isHidden = true
        
        let image = UIImageView()
        let imageName = UIImage(named: "textFieldError")
        image.image = imageName
        nameTF.rightView = image
        nameTF.rightViewMode = .always
        
        setEnableBtn(nextBtn)
    }
    
    
    // 이부분은 서버 연동을 통해 false 일 때 가져오기
    func alreadyExistNickName() {
        self.nickNameError.isHidden = false
        self.nickNameErrorLbl.isHidden = false
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    // 텍스트 필드 리턴 타입
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTF {
            nickNameTF.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    // MARK: 텍스트 유효성 체크
    @IBAction func editChange(_ sender: UITextField) {
        guard let userNickName = nickNameTF.text else { return }
        let input = nickNameInput(nickname: userNickName)
        
        switch sender {
        case nameTF:
            if sender.text?.isEmpty == true {
                self.isNotEmpty = false
            } else {
                self.isNotEmpty = true
            }
            
        default:
            if sender.text?.isEmpty == false && isNotEmpty == true {
                NickNameDataManager().validateNickName(input, viewController: self)
            } else {
                NickNameDataManager().validateNickName(input, viewController: self)
            }
        }
    }
    
    
    // MARK: 성별 선택 뷰 이동
    @IBAction func moveSelectGenderVC(_ sender: UIButton) {
        let sbName = UIStoryboard(name: "SelectGender", bundle: nil)
        let sgSB = sbName.instantiateViewController(identifier: "SelectGenderViewController")
        
        guard let userName = nameTF.text else { return }
        guard let userNickName = nickNameTF.text else { return }
        
        print("사용자의 이름은 \(userName)이며, 닉네임은 \(userNickName)입니다.")
        self.navigationController?.pushViewController(sgSB, animated: false)
    }
}


