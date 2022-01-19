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
        NotificationCenter.default.addObserver(self, selector: #selector(inputRecommender(_:)), name: UITextField.textDidChangeNotification, object: recommenderTF)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: recommenderTF)
    }
    
    @objc private func inputRecommender(_ noti: Notification) {
        let maxLength: Int = 8
        if let textField = noti.object as? UITextField {
            if let text = textField.text {
                if text.isEmpty {
                    setEnableBtn(confirmBtn)
                } else {
                    recommander = text
                    setAbleBtn(confirmBtn)
                }
                
                if text.count > maxLength {
                    setShowErrorLblImg(errorImageView, errorLbl, "닉네임 형식이 올바르지 않습니다.")
                    setEnableBtn(confirmBtn)
                } else {
                    sethiddenLblImg(errorImageView, errorLbl)
                }
            }
        }
    }
    
    
    func setUI() {
        self.tfView.layer.cornerRadius = 11
        self.skipBtn.layer.borderWidth = 1
        self.skipBtn.layer.borderColor = UIColor.white.cgColor
        self.skipBtn.layer.cornerRadius = skipBtn.frame.height / 2
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
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
    
    
    
    // MARK: Function Move VC
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func finishBtn(_ sender: UIButton) {
        // 추천인 있는 경우
        if UserInfoData.name == "" {
            UserInfoData.name = "사용자"
        }
        let input =  HaveReceiverInput(email: UserInfoData.email, name: UserInfoData.name, nickname: UserInfoData.nickname, sex: UserInfoData.sex, birth: UserInfoData.birth, category: UserInfoData.category, personalInformationAgree: UserInfoData.personalInformationAgree, marketingInformationAgree: UserInfoData.marketingInformationAgree, receiverNickname: recommander, device: UserInfoData.device)
        
        showIndicator()
        HaveReceiverDataManager().user(input ,viewController: self)
        
    }
    
    @IBAction func skipInputRecommander(_ sender: UIButton) {
        // 스킵 → 홈 이동
        if UserInfoData.name == "" {
            UserInfoData.name = "사용자"
        }
        let input =  noReceiverInput(email: UserInfoData.email, name: UserInfoData.name, nickname: UserInfoData.nickname, sex: UserInfoData.sex, birth: UserInfoData.birth, category: UserInfoData.category, personalInformationAgree: UserInfoData.personalInformationAgree, marketingInformationAgree: UserInfoData.marketingInformationAgree, device: UserInfoData.device)

        showIndicator()
        noReceiverDataManager().user(input ,viewController: self)
    }
    

}
