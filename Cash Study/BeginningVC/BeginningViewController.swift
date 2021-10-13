//
//  BeginningViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/13.
//

import UIKit

class BeginningViewController: UIViewController {
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: Set UI
    func setUI() {
        // Button Layer
        registerBtn.layer.borderWidth = 1
        registerBtn.layer.borderColor = UIColor.darkGray.cgColor
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.darkGray.cgColor
        
    }
    
    
    // MARK: Move Rigster
    @IBAction func moveRegister(_ sender: Any) {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    // MARK: Move Login
    @IBAction func moveLogin(_ sender: Any) {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
}
