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
    
    var pointTxt : String = ""
    
    init(pointTxt: String) {
        self.pointTxt = pointTxt
        
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
        self.contentView.layer.cornerRadius = 8
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        self.pointAlertLbl.text = "\(pointTxt)별을 획득했어요!"
    }
    
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name("dismissPass"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("reloadReward"), object: nil)
    }
    
}
