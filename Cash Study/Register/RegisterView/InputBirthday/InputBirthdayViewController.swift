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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    
    // MARK: - Custom method
    /// Use AnyFormatKit
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /// 글자 수 제한
        let maxLength: Int = 9
        if let textField = self.birthTF {
            if let text = textField.text {
                if text.count >= maxLength {
                    let idx = text.index(text.startIndex, offsetBy: maxLength)
                    let newText = text[text.startIndex..<idx]
                    textField.text = String(newText)
                    textField.resignFirstResponder()
                    setAbleBtn(confirmBtn)
                } else {
                    setEnableBtn(confirmBtn)
                }
            }
        }
        
        /// 텍스트 사이사이 ' / ' 추가 → AnyFormatKit
        guard let text = textField.text else {
            return false
        }
        let formatter = DefaultTextInputFormatter(textPattern: "####/##/##")
        let result = formatter.formatInput(currentText: text, range: range, replacementString: string)
        textField.text = result.formattedText
        
        /// 텍스트 필드가 비어있을 때 → 버튼 비활성화
        if textField.text == "" {
            setEnableBtn(confirmBtn)
        }
        
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
            
            if let birthTxt = self.birthTF.text {
                UserInfoData.birth = birthTxt.replacingOccurrences(of: "/", with: "-")
                print(UserInfoData.birth)
            }
            
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
