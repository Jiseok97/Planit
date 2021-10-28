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
        let maxLength : Int = 8
        if let textField = noti.object as? UITextField {
            if let text = textField.text {
                if text.count >= maxLength {
                    let idx = text.index(text.startIndex, offsetBy: maxLength)
                    let newText = text[text.startIndex..<idx]
                    textField.text = String(newText)
                }
                switch text.count{
                    case 2:
                        textField.text = text + "/"
                    case 5:
                        textField.text = text + "/"
                    default:
                        return
                }
            }
        }
    }
    
    
    
    func setUI() {
        self.birthView.layer.cornerRadius = 11
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        self.birthTF.setPlaceHolderColor(UIColor.placeHolderColor)
        swipeRecognizer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    @IBAction func moveSelectJobVC(_ sender: Any) {
        guard let sjVC = self.storyboard?.instantiateViewController(identifier: "SelectJobViewController") as? SelectJobViewController else { return }
        
        self.navigationController?.pushViewController(sjVC, animated: false)
    }
    
}
