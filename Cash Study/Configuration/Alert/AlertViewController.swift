//
//  AlertViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/25.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var subMsgLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var msgStView: UIStackView!
    
    @IBOutlet weak var cancleView: UIView!
    
    var mainMsg : String = ""
    var subMsg : String = ""
    var confirmBtnTxt : String = ""
    
    init(mainMsg: String, subMsg : String, btnTitle : String) {
        self.mainMsg = mainMsg
        self.subMsg = subMsg
        self.confirmBtnTxt = btnTitle
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    
    // MARK: Functions
    func setUI() {
        self.msgLbl.text = mainMsg
        self.subMsgLbl.text = subMsg
        self.confirmBtn.setTitle(confirmBtnTxt, for: .normal)
        
        self.alertView.layer.cornerRadius = 20
        self.confirmBtn.layer.cornerRadius = self.confirmBtn.frame.height / 2
        self.cancelBtn.layer.cornerRadius = self.cancelBtn.frame.height / 2
        self.cancelBtn.layer.borderColor = UIColor.cancleAlertColor.cgColor
        self.cancelBtn.layer.borderWidth = 1
    }
    
    
    @IBAction func confirmBtnTapped(_ sender: Any) {
        switch self.confirmBtnTxt {
        case "삭제":
            NotificationCenter.default.post(name: NSNotification.Name("remove"), object: nil)
            dismiss(animated: true, completion: nil)
            
        case "확인":
            NotificationCenter.default.post(name: NSNotification.Name("setRepresent"), object: nil)
            dismiss(animated: true, completion: nil)
            
        default:
            print("Default")
        }
        
    }
    
}
