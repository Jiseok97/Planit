//
//  SelectGenderViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/27.
//

import UIKit

class SelectGenderViewController: UIViewController {

    @IBOutlet weak var manView: UIView!
    @IBOutlet weak var womanView: UIView!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        self.manView.layer.cornerRadius = 11
        self.womanView.layer.cornerRadius = 11
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        swipeRecognizer()
    }
    
    
    @IBAction func manBtnTapped(_ sender: Any) {
    }
    
    @IBAction func womanBtnTapped(_ sender: Any) {
    }
    
    
    @IBAction func moveInputBirthdatVC(_ sender: Any) {
        guard let ibVC = self.storyboard?.instantiateViewController(identifier: "InputBirthdayViewController") as? InputBirthdayViewController else { return }
        
        self.navigationController?.pushViewController(ibVC, animated: false)
    }
    
    
}
