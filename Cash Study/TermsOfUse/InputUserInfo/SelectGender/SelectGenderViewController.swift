//
//  SelectGenderViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/26.
//

import UIKit

class SelectGenderViewController: UIViewController {
    
    @IBOutlet weak var manView: UIView!
    @IBOutlet weak var womanView: UIView!
    
    @IBOutlet weak var manBtn: UIButton!
    @IBOutlet weak var womanBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var manBtnTap: Bool = false
    var womanBtnTap: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swipeRecognizer()
        setUI()
    }
    
    func setUI() {
        self.manView.layer.cornerRadius = 11
        self.womanView.layer.cornerRadius = 11
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        self.confirmBtn.isEnabled = false
//        setBtnUI()
    }

    func setBtnUI() {
        if self.confirmBtn.isEnabled {
            self.confirmBtn.backgroundColor = UIColor.white
        } else {
            self.confirmBtn.backgroundColor = UIColor.disabledColor
        }
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
    
    
    // MARK: 성별 선택
    @IBAction func manBtnTapped(_ sender: Any) {
        self.womanBtn.isEnabled = false
        self.confirmBtn.isEnabled = true
        self.manView.backgroundColor = UIColor.link
    }
    
    @IBAction func womanBtnTapped(_ sender: Any) {
        self.manBtn.isEnabled = false
        self.confirmBtn.isEnabled = true
        self.womanView.backgroundColor = UIColor.link
    }
    
    
    // MARK: 생년월일 페이지
    @IBAction func moveInputBirthday(_ sender: Any) {
        let brVC = InputBirthdayViewController(nibName: "InputBirthdayViewController", bundle: nil)
        
        self.navigationController?.pushViewController(brVC, animated: true)
    }
    
}
