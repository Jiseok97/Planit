//
//  InputBirthdayViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/27.
//

import UIKit

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
    
    @objc private func textLengthLimit(_ noti: Notification) {
        let maxLength : Int = 10
        if let textField = noti.object as? UITextField {
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
                
                switch text.count{
                    case 4:
                        textField.text = text + "/"
                    case 7:
                        textField.text = text + "/"
                    default:
                        return
                }
            }
        }
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
