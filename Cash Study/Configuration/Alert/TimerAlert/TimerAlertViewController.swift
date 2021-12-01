//
//  TimerAlertViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

import UIKit

class TimerAlertViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    
    // MARK: Functions
    func setUI() {
        self.contentView.layer.cornerRadius = 20
        self.noBtn.layer.cornerRadius = noBtn.frame.height / 2
        self.noBtn.layer.borderColor = UIColor.placeHolderColor.cgColor
        self.noBtn.layer.borderWidth = 0.8
        
        self.yesBtn.layer.cornerRadius = yesBtn.frame.height / 2
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name("PutRecordDone"), object: nil)
    }
    
}
