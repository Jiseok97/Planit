//
//  InputRecommenderViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/28.
//

import UIKit

class InputRecommenderViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfView: UIView!
    @IBOutlet weak var recommenderTF: UITextField! {
        didSet {
            recommenderTF.delegate = self
        }
    }
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var errorImageView: UIImageView!
    
    var recommander: String = ""
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(knowRecommander(_:)), name: UITextField.textDidChangeNotification, object: recommenderTF)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: recommenderTF)
    }
    
    @objc private func knowRecommander(_ noti: Notification) {
        if let textField = noti.object as? UITextField {
            if let text = textField.text {
                if text.isEmpty {
                    setEnableBtn(confirmBtn)
                } else {
                    recommander = text
                    setAbleBtn(confirmBtn)
                }
            }
        }
    }
    
    
    func setUI() {
        self.tfView.layer.cornerRadius = 11
        self.skipBtn.layer.borderWidth = 1
        self.skipBtn.layer.borderColor = UIColor.white.cgColor
        self.skipBtn.layer.cornerRadius = skipBtn.frame.height / 2 - 5
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        self.recommenderTF.setPlaceHolderColor(UIColor.placeHolderColor)
        swipeRecognizer()
        setEnableBtn(confirmBtn)
        
        self.errorLbl.isHidden = true
        self.errorImageView.isHidden = true
    }
    
    // MARK: TF Delegate
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func finishBtn(_ sender: UIButton) {
        print("사용자의 추천인은 \(recommander)입니다.")
        // 홈 이동
    }
    
    @IBAction func skipInputRecommander(_ sender: UIButton) {
        // 스킵 → 홈 이동
    }
    

}
