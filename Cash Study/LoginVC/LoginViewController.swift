//
//  LoginViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/13.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var kakaoLoginView: UIView!
    @IBOutlet weak var facebookLoginView: UIView!
    @IBOutlet weak var appleLoginView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: Set UI
    func setUI() {
        kakaoLoginView.layer.cornerRadius = 25
        facebookLoginView.layer.cornerRadius = 25
        appleLoginView.layer.cornerRadius = 25
        
    }
    
    
}
