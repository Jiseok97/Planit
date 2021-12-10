//
//  PlanitPassViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/10.
//

import UIKit

class PlanitPassViewController: UIViewController {
    
    @IBOutlet weak var planitNameLbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }


    // MARK: Functions
    func setUI() {
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
    }
    
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
