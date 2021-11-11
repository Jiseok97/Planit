//
//  AddDdayViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/10.
//

import UIKit

class AddDdayViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var inputTitleTF: UITextField!
    @IBOutlet weak var countTfLbl: UILabel!
    
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var dateBtn: UIButton!
    
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var fifthBtn: UIButton!
    
    @IBOutlet weak var representView: UIView!
    @IBOutlet weak var checkRepresentSd: UISlider!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUI()
    }

    
    func setUI() {
        self.titleView.layer.cornerRadius = 8
        self.calendarView.layer.cornerRadius = 8
        self.representView.layer.cornerRadius = 8
        
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        self.firstBtn.layer.cornerRadius = 8
        self.secondBtn.layer.cornerRadius = 8
        self.thirdBtn.layer.cornerRadius = 8
        self.fourthBtn.layer.cornerRadius = 8
        self.fifthBtn.layer.cornerRadius = 8
        
        self.backBtn.setTitle("", for: .normal)
        self.firstBtn.setTitle("", for: .normal)
        self.secondBtn.setTitle("", for: .normal)
        self.thirdBtn.setTitle("", for: .normal)
        self.fourthBtn.setTitle("", for: .normal)
        self.fifthBtn.setTitle("", for: .normal)
    }
    
    @IBAction func addDdayTapped(_ sender: Any) {
        let input = AddDdayInput(title: "테스트 디데이 2", endAt: "2021-11-12", color: "YELLOW", isRepresentative: false)
        AddDdayDataManager().addDday(input, viewController: self)
    }
    
    
}
