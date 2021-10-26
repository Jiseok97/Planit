//
//  InputBirthdayViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/26.
//

import UIKit

class InputBirthdayViewController: UIViewController {

    @IBOutlet weak var tfView: UIView!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swipeRecognizer()
        setUI()
    }
    
    func setUI() {
        self.tfView.layer.cornerRadius = 11
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        self.dateOfBirth.setPlaceHolderColor(UIColor.placeHolderColor)
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

}
