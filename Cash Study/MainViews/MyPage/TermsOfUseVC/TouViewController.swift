//
//  TouViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/30.
//

import UIKit

class TouViewController: UIViewController {

    @IBOutlet weak var touView: UIView!
    @IBOutlet weak var infoFirstView: UIView!
    @IBOutlet weak var infoSecondView: UIView!
    @IBOutlet weak var marketingView: UIView!
    @IBOutlet weak var leaveView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUI()
        addGesture()
    }
    
    
    // MARK: Functions
    func setUI() {
        leaveView.isHidden = true
        
        touView.layer.addBorder([.bottom], color: .homeBorderColor, width: 0.5)
        infoFirstView.layer.addBorder([.bottom], color: .homeBorderColor, width: 0.5)
        infoSecondView.layer.addBorder([.bottom], color: .homeBorderColor, width: 0.5)
        marketingView.layer.addBorder([.bottom], color: .homeBorderColor, width: 0.5)
    }
    
    func addGesture() {
        
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
