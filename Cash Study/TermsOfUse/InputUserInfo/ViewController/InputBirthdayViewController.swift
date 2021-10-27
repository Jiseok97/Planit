//
//  InputBirthdayViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/27.
//

import UIKit

class InputBirthdayViewController: UIViewController {
    
    @IBOutlet weak var birthView: UIView!
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        self.birthView.layer.cornerRadius = 11
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        swipeRecognizer()
        
    }
    
    
    @IBAction func moveSelectJobVC(_ sender: Any) {
        guard let sjVC = self.storyboard?.instantiateViewController(identifier: "SelectJobViewController") as? SelectJobViewController else { return }
        
        self.navigationController?.pushViewController(sjVC, animated: false)
    }
    
}
