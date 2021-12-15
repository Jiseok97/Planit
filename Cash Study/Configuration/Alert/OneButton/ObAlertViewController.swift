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
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var alertViewHeight: NSLayoutConstraint!
    
    
    var mainMsg : String = ""
    var subMsg : String = ""
    var btnTitle : String = ""
    var isTimer : Bool = false
    var heightValue : Double = 0.0
    
    init(mainMsg: String, subMsg: String, heightValue: Double, btnTitle: String, isTimer : Bool) {
        self.mainMsg = mainMsg
        self.subMsg = subMsg
        self.btnTitle = btnTitle
        self.isTimer = isTimer
        self.heightValue = heightValue
        
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
        self.timerLbl.text = subMsg
        self.confirmBtn.setTitle(self.btnTitle, for: .normal)
        
        if isTimer {
            self.confirmBtn.backgroundColor = UIColor.link
            self.confirmBtn.setTitleColor(.myGray, for: .normal)
        }
    }
    
//    private func setConstraintWitouthNotch() {
//        alertViewHeight.constant = UIDevice.current.hasNotch ? view.frame.height * 0.28 : view.frame.height * 0.28
//    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
