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
    
    var name: String?
    var nickName: String?
    
    
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
        
        nextBtn.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        nextBtn.isEnabled = false
    }
    
    
    func alreadyExistNickName() {
        self.nickNameError.isHidden = false
        self.nickNameErrorLbl.isHidden = false
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
        let sbName = UIStoryboard(name: "SelectGender", bundle: nil)
        let sgSB = sbName.instantiateViewController(identifier: "SelectGenderViewController")
        
        self.navigationController?.pushViewController(sgSB, animated: false)
        
    }
    
    
    @IBAction func editChange(_ sender: UITextField) {
        switch sender {
        case nameTF:
            if sender.text?.isEmpty == true {
                self.isNotEmpty = false
                print("isNotEmpty = false")
            } else {
                self.isNotEmpty = true
                print("isNotEmpty = true")
            }
            
        default:
            if sender.text?.isEmpty == false && isNotEmpty == true {
                self.nextBtn.backgroundColor = UIColor.white
                self.nextBtn.isEnabled = true
            }
        }
    }

}


