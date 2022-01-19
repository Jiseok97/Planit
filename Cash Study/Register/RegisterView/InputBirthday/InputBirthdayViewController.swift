//
//  InputBirthdayViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/27.
//

import UIKit
import AnyFormatKit

class InputBirthdayViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var birthView: UIView!
    @IBOutlet weak var birthTF: UITextField! {
        didSet {
            birthTF.delegate = self
        }
    }
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    
    var birthDate : String = ""
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(textLengthLimit(_:)), name: UITextField.textDidChangeNotification, object: birthTF)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: birthTF)
    }
    
    
    // MARK: Functions
    @objc private func textLengthLimit(_ noti: Notification) {
//        let maxLength: Int = 9
//        if let textField = noti.object as? UITextField {
//            if let text = textField.text {
//                if text.count >= maxLength {
//                    let idx = text.index(text.startIndex, offsetBy: maxLength)
//                    let newText = text[text.startIndex..<idx]
//                    textField.text = String(newText)
//                    setAbleBtn(confirmBtn)
//                    birthDate = text
//                } else {
//                    setEnableBtn(confirmBtn)
//                }
//            }
//        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength: Int = 9
        if let textField = self.birthTF {
            if let text = textField.text {
                if text.count >= maxLength {
                    let idx = text.index(text.startIndex, offsetBy: maxLength)
                    let newText = text[text.startIndex..<idx]
                    textField.text = String(newText)
                    setAbleBtn(confirmBtn)
                    birthDate = text
                } else {
                    setEnableBtn(confirmBtn)
                }
            }
        }
        
        guard let text = textField.text else {
            return false
        }
        
        let characterSet = CharacterSet(charactersIn: string)
        if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
            return false
        }

        let formatter = DefaultTextInputFormatter(textPattern: "####/##/##")
        let result = formatter.formatInput(currentText: text, range: range, replacementString: string)
        textField.text = result.formattedText
        let position = textField.position(from: textField.beginningOfDocument, offset: result.caretBeginOffset)!
        textField.selectedTextRange = textField.textRange(from: position, to: position)
        return false
    }
    
    
    func setUI() {
        self.birthView.layer.cornerRadius = 11
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        self.birthTF.setPlaceHolderColor(UIColor.placeHolderColor)
        swipeRecognizer()
        setEnableBtn(confirmBtn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    @IBAction func moveSelectJobVC(_ sender: UIButton) {
        switch sender {
        case confirmBtn:
            let sbName = UIStoryboard(name: "SelectJob", bundle: nil)
            let sjSB = sbName.instantiateViewController(identifier: "SelectJobViewController")
            
            let userBirthDate = birthDate.replacingOccurrences(of: "/", with: "-")
            UserInfoData.birth = userBirthDate
            
            self.navigationController?.pushViewController(sjSB, animated: false)
            
        default:
            let sbName = UIStoryboard(name: "SelectJob", bundle: nil)
            let sjSB = sbName.instantiateViewController(identifier: "SelectJobViewController")
            
            UserInfoData.birth = ""
            
            self.navigationController?.pushViewController(sjSB, animated: false)
        }
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
