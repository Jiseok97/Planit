//
//  AddDdayViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/10.
//

import UIKit

class AddDdayViewController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var selectDayView: UIView!
    @IBOutlet weak var selectIconView: UIView!
    @IBOutlet weak var checkDdayView: UIView!
    
    @IBOutlet weak var yellowBtn: UIButton!
    @IBOutlet weak var pinkBtn: UIButton!
    @IBOutlet weak var darkBlueBtn: UIButton!
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var lightBlueBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var calendarBtn: UIButton!
    
    @IBOutlet weak var representativeBtn: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    
    func setUI() {
        self.titleView.layer.cornerRadius = 8
        self.selectDayView.layer.cornerRadius = 8
        self.selectIconView.layer.cornerRadius = 8
        self.checkDdayView.layer.cornerRadius = 8
        
        self.yellowBtn.layer.cornerRadius = yellowBtn.frame.height / 2
        self.pinkBtn.layer.cornerRadius = pinkBtn.frame.height / 2
        self.darkBlueBtn.layer.cornerRadius = darkBlueBtn.frame.height / 2
        self.greenBtn.layer.cornerRadius = greenBtn.frame.height / 2
        self.lightBlueBtn.layer.cornerRadius = lightBlueBtn.frame.height / 2
        
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        
        self.representativeBtn.layer.cornerRadius = 8
        
        
        self.yellowBtn.setTitle("", for: .normal)
        self.pinkBtn.setTitle("", for: .normal)
        self.darkBlueBtn.setTitle("", for: .normal)
        self.greenBtn.setTitle("", for: .normal)
        self.lightBlueBtn.setTitle("", for: .normal)
        self.calendarBtn.setTitle("", for: .normal)
        
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
