//
//  SelectJobViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/27.
//

import UIKit

class SelectJobViewController: UIViewController {
    
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var fifthBtn: UIButton!
    @IBOutlet weak var sixthBtn: UIButton!
    @IBOutlet weak var seventhBtn: UIButton!
    @IBOutlet weak var eighthBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    var firstBtnClicked: Bool = false 
    var secondBtnClicked: Bool = false
    var thirdBtnClicked: Bool = false
    var fourthBtnClicked: Bool = false
    var fifthBtnClicked: Bool = false
    var sixthBtnClicked: Bool = false
    var seventhBtnClicked: Bool = false
    var eighthBtnClicked: Bool = false
    
    var myJobIs : String = ""

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        let size : CGFloat = 11
        
        self.firstBtn.layer.cornerRadius = size
        self.secondBtn.layer.cornerRadius = size
        self.thirdBtn.layer.cornerRadius = size
        self.fourthBtn.layer.cornerRadius = size
        self.fifthBtn.layer.cornerRadius = size
        self.sixthBtn.layer.cornerRadius = size
        self.seventhBtn.layer.cornerRadius = size
        self.eighthBtn.layer.cornerRadius = size
        
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        
        swipeRecognizer()
    }
    
    @IBAction func selectedBtn(_ sender: UIButton) {
        switch sender {
        case firstBtn:
            self.firstBtnClicked = changeBoolValue(buttonChecked: firstBtnClicked)
            setBtnColor(firstBtn, firstBtnClicked)
            setElseBtnColor(secondBtn, thirdBtn, fourthBtn, fifthBtn, sixthBtn, seventhBtn, eighthBtn)
            
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false
            
            myJobIs = "ELEMENTARY_SCHOOL"
            
            
        case secondBtn:
            self.secondBtnClicked = changeBoolValue(buttonChecked: secondBtnClicked)
            setBtnColor(secondBtn, secondBtnClicked)
            setElseBtnColor(firstBtn, thirdBtn, fourthBtn, fifthBtn, sixthBtn, seventhBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false
            
            myJobIs = "MIDDLE_SCHOOL"
            
            
        case thirdBtn:
            self.thirdBtnClicked = changeBoolValue(buttonChecked: thirdBtnClicked)
            setBtnColor(thirdBtn, thirdBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, fourthBtn, fifthBtn, sixthBtn, seventhBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false
            
            myJobIs = "HIGH_SCHOOL"
            
            
        case fourthBtn:
            self.fourthBtnClicked = changeBoolValue(buttonChecked: fourthBtnClicked)
            setBtnColor(fourthBtn, fourthBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, thirdBtn, fifthBtn, sixthBtn, seventhBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false
            
            myJobIs = "NNTH_EXAM"
            
        case fifthBtn:
            self.fifthBtnClicked = changeBoolValue(buttonChecked: fifthBtnClicked)
            setBtnColor(fifthBtn, fifthBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, thirdBtn, fourthBtn, sixthBtn, seventhBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false
            
            myJobIs = "UNIVERSITY"
            
        case sixthBtn:
            self.sixthBtnClicked = changeBoolValue(buttonChecked: sixthBtnClicked)
            setBtnColor(sixthBtn, sixthBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, thirdBtn, fourthBtn, fifthBtn, seventhBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.seventhBtnClicked = false
            self.eighthBtnClicked = false
            
            myJobIs = "EXAM_PREP"
            
        case seventhBtn:
            self.seventhBtnClicked = changeBoolValue(buttonChecked: seventhBtnClicked)
            setBtnColor(seventhBtn, seventhBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, thirdBtn, fourthBtn, fifthBtn, sixthBtn, eighthBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.eighthBtnClicked = false
            
            myJobIs = "JOB_PREP"
            
        default:
            self.eighthBtnClicked = changeBoolValue(buttonChecked: eighthBtnClicked)
            setBtnColor(eighthBtn, eighthBtnClicked)
            setElseBtnColor(firstBtn, secondBtn, thirdBtn, fourthBtn, fifthBtn, sixthBtn, seventhBtn)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            self.sixthBtnClicked = false
            self.seventhBtnClicked = false
            
            myJobIs = "WORKER"
        }
    }
    
    
    @IBAction func moveRecommenderVC(_ sender: Any) {
        guard let rcVC = self.storyboard?.instantiateViewController(identifier: "InputRecommenderViewController") as? InputRecommenderViewController else { return }
        
        print("사용자의 직업은 \(myJobIs)입니다.")
        
        self.navigationController?.pushViewController(rcVC, animated: false)
    }
    
}
