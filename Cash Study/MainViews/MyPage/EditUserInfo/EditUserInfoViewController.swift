//
//  EditUserInfoViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

import UIKit

class EditUserInfoViewController: UIViewController {
    
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var nicknameView: UIView!
    @IBOutlet weak var nicknameLbl: UILabel!
    @IBOutlet weak var nicknameErrorImgView: UIImageView!
    @IBOutlet weak var nicknameErrorLbl: UILabel!
    
    @IBOutlet var categoryBtns: [UIButton]!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    var nicknameError: Bool = false
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    // MARK: Functions
    
    func setUI() {
        self.nameView.layer.cornerRadius = 11
        self.nicknameView.layer.cornerRadius = 11
        
        self.categoryBtns.forEach {
            $0.layer.cornerRadius = 11
        }
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        
    }

    @IBAction func dismissBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
