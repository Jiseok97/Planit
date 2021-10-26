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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
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
    
    
    // MARK: 빈화면 키보드 내려가기
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    
    
    // MARK: 왼쪽 제스처 dismiss
    func swipeRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                self.navigationController?.popViewController(animated: true)
            default: break
            }
        }
    }
    
    
    
    
    
    // MARK: 성별 선택 뷰 이동
    @IBAction func moveSelectGenderVC(_ sender: Any) {
        let sgVC = SelectGenderViewController(nibName: "SelectGenderViewController", bundle: nil)
        
        self.navigationController?.pushViewController(sgVC, animated: true)
    }
    
}
