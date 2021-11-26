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
    
    var mainMsg : String = ""
    var subMsg : String = ""
    var btnTitle : String = ""
    var isTimer : Bool = false
    
    init(mainMsg: String, subMsg: String, btnTitle: String, isTimer : Bool) {
        self.mainMsg = mainMsg
        self.subMsg = ""
        self.btnTitle = btnTitle
        self.isTimer = isTimer
        
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
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
