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
    
    // MARK: - Life Cycle
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
    
    
    // MARK: - Custom Method
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
    
    /// 텍스트 필드 관련 delegate
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    /// 키보드 리턴 타입
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /// 텍스트가 수정되는 동안도 버튼 비활성화, Done이 되었을 때 버튼 판별 여부 확인
    /// 22.01.25 수정 시작
    func textFieldDidEndEditing(_ textField: UITextField) {
        let nickname = UserInfoData.nickname
        let writeNickname = textField.text
        print("nickname = \(nickname) && writeNickname = \(writeNickname)")
        if nickname == writeNickname {
            setEnableBtn(confirmBtn)
            setShowErrorLblImg(errorImageView, errorLbl, "추천하신 분의 닉네임을 입력해주세요.")
        }
    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        /// 텍스트 필드가 비어있을 때 → 버튼 비활성화
//        if textField.text == "" {
//            setEnableBtn(confirmBtn)
//            sethiddenLblImg(errorImageView, errorLbl)
//        }
//        return false
//    }
    
    
    /// 뒤로가기
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func finishBtn(_ sender: UIButton) {
        /// 추천인 있는 경우
        if UserInfoData.name == "" {
            UserInfoData.name = "사용자"
        }
        let input =  HaveReceiverInput(email: UserInfoData.email, name: UserInfoData.name, nickname: UserInfoData.nickname, sex: UserInfoData.sex, birth: UserInfoData.birth, category: UserInfoData.category, personalInformationAgree: UserInfoData.personalInformationAgree, marketingInformationAgree: UserInfoData.marketingInformationAgree, receiverNickname: recommander, device: UserInfoData.device)
        
        showIndicator()
        HaveReceiverDataManager().user(input ,viewController: self)
        
    }
    
    @IBAction func skipInputRecommander(_ sender: UIButton) {
        /// 추천인이 없는 경우, 스킵 → 홈 이동
        if UserInfoData.name == "" {
            UserInfoData.name = "사용자"
        }
        let input =  noReceiverInput(email: UserInfoData.email, name: UserInfoData.name, nickname: UserInfoData.nickname, sex: UserInfoData.sex, birth: UserInfoData.birth, category: UserInfoData.category, personalInformationAgree: UserInfoData.personalInformationAgree, marketingInformationAgree: UserInfoData.marketingInformationAgree, device: UserInfoData.device)

        showIndicator()
        noReceiverDataManager().user(input ,viewController: self)
    }
    

}
