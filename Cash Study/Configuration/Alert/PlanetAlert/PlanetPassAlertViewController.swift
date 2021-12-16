//
//  PlanetPassAlertViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/16.
//

import UIKit

class PlanetPassAlertViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pointAlertLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    
    // MARK: Functions
    func setUI() {
        self.contentView.layer.cornerRadius = 8
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
    }
    
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
