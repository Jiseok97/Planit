//
//  ObAlertViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/26.
//

import UIKit

class ObAlertViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var alertViewHeight: NSLayoutConstraint!
    @IBOutlet weak var subConstraint: NSLayoutConstraint!
    
    
    var mainMsg : String = ""
    var subMsg : String = ""
    var btnTitle : String = ""
    var isTimer : Bool = false
    var isMypage : Bool = false
    var networkConnect: Bool = false
    var heightValue : Double = 0.0
    
    init(mainMsg: String, subMsg: String, heightValue: Double, btnTitle: String, isTimer : Bool, isMypage: Bool, networkConnect: Bool) {
        self.mainMsg = mainMsg
        self.subMsg = subMsg
        self.btnTitle = btnTitle
        self.isTimer = isTimer
        self.isMypage = isMypage
        self.heightValue = heightValue
        self.networkConnect = networkConnect
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        alertViewHeight.constant = view.frame.height * heightValue
    }

    
    // MARK: Functions
    func setUI() {
        self.contentView.layer.cornerRadius = 20
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        
        self.msgLbl.text = mainMsg
        self.subLbl.text = subMsg
        self.confirmBtn.setTitle(self.btnTitle, for: .normal)
        
        if isTimer {
            self.confirmBtn.backgroundColor = UIColor.link
            self.confirmBtn.setTitleColor(.myGray, for: .normal)
        }
        
        if isMypage {
            self.subConstraint.constant = CGFloat(10)
            self.subLbl.textColor = .placeHolderColor
            self.subLbl.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        }
        
        if networkConnect {
            self.subConstraint.constant = CGFloat(8)
            self.subLbl.textColor = .placeHolderColor
            self.subLbl.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        }
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        if networkConnect {
            changeRootVC(SplashViewController())
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
}
