//
//  InputNameViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/26.
//

import UIKit

class InputNameViewController: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nickNameView: UIView!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nickNameTF: UITextField!
    
    @IBOutlet weak var nickNameError: UIImageView!
    @IBOutlet weak var nickNameErrorLbl: UILabel!
    
    
    var name: String?
    var nickName: String?
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
    }
    
    
    
    // MAKR: Functions
    func setUI() {
        self.nameTF.setPlaceHolderColor(UIColor.placeHolderColor)
        self.nickNameTF.setPlaceHolderColor(UIColor.placeHolderColor)
        self.nameView.layer.cornerRadius = 11
        self.nickNameView.layer.cornerRadius = 11
        self.nextBtn.layer.cornerRadius = nextBtn.frame.height / 2
        
        clearBtnTF()
        dismissKeyboardWhenTappedAround()
        
        self.nickNameError.isHidden = true
        self.nickNameErrorLbl.isHidden = true
    }
    
    func alreadyExistNickName() {
        self.nickNameError.isHidden = false
        self.nickNameErrorLbl.isHidden = false
    }
    
    
    // MARK: 텍스트 클리어 버튼
    func clearBtnTF() {
        self.nameTF.clearButtonMode = .always
        self.nameTF.clearButtonMode = .whileEditing
        self.nickNameTF.clearButtonMode = .always
        self.nickNameTF.clearButtonMode = .whileEditing
    }
    
    
    // MARK: 성별 선택 뷰 이동
    @IBAction func moveSelectGenderVC(_ sender: Any) {
        guard let sgVC = self.storyboard?.instantiateViewController(identifier: "SelectGenderViewController") as? SelectGenderViewController else { return }
        
        self.navigationController?.pushViewController(sgVC, animated: false)
    }
    
}
