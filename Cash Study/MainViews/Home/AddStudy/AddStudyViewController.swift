//
//  AddStudyViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/13.
//

import UIKit

class AddStudyViewController: UIViewController {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var textCntLbl: UILabel!
    
    @IBOutlet weak var repeatSd: UISlider!
    @IBOutlet weak var sdBtn: UIButton!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dataLblBtn: UIButton!
    
    @IBOutlet weak var everyDayBtn: UIButton!
    @IBOutlet weak var saturdayBtn: UIButton!
    @IBOutlet weak var sundayBtn: UIButton!
    @IBOutlet weak var mondayBtn: UIButton!
    @IBOutlet weak var tuesdayBtn: UIButton!
    @IBOutlet weak var wednesdayBtn: UIButton!
    @IBOutlet weak var thursdayBtn: UIButton!
    @IBOutlet weak var fridayBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var isRepeat : Bool = false
    
    var mondayTapped: Bool = false
    var tuesdayTapped : Bool = false
    var wednesdayTapped : Bool = false
    var thursdayTapped : Bool = false
    var fridayTapped : Bool = false
    var saturdayTapped : Bool = false
    var sundayTapped : Bool = false
    var everydapTapped : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUI()
    }
    

    func setUI() {
        self.titleView.layer.cornerRadius = 8
        self.secondView.layer.cornerRadius = 8
        self.thirdView.layer.cornerRadius = 8
        
        self.everyDayBtn.layer.cornerRadius = 8
        self.mondayBtn.layer.cornerRadius = 8
        self.tuesdayBtn.layer.cornerRadius = 8
        self.wednesdayBtn.layer.cornerRadius = 8
        self.thursdayBtn.layer.cornerRadius = 8
        self.fridayBtn.layer.cornerRadius = 8
        self.saturdayBtn.layer.cornerRadius = 8
        self.sundayBtn.layer.cornerRadius = 8
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        
        self.backBtn.setTitle("", for: .normal)
        self.sdBtn.setTitle("", for: .normal)
        self.dataLblBtn.setTitle("", for: .normal)
        
        self.thirdView.isHidden = true
    } 
    
    
    @IBAction func sliderTapped(_ sender: Any) {
        if repeatSd.value == 0 {
            self.isRepeat = true
            self.repeatSd.value = 1.0
            thirdView.isHidden = false
            
        } else {
            self.isRepeat = false
            self.repeatSd.value = 0.0
            thirdView.isHidden = true
            
        }
    }
    
    
    @IBAction func showCalendarTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func dayBtnTapped(_ sender: UIButton) {
        
        switch sender {
            
        case mondayBtn :
            self.mondayTapped = changeBoolValue(buttonChecked: mondayTapped)
            tappedDayBtn(mondayBtn, mondayTapped)
            
            self.everydapTapped = false
            tappedDayBtn(everyDayBtn, everydapTapped)
            
            
        case tuesdayBtn:
            self.tuesdayTapped = changeBoolValue(buttonChecked: tuesdayTapped)
            tappedDayBtn(tuesdayBtn, tuesdayTapped)
            
            self.everydapTapped = false
            tappedDayBtn(everyDayBtn, everydapTapped)
            
        case wednesdayBtn:
            self.wednesdayTapped = changeBoolValue(buttonChecked: wednesdayTapped)
            tappedDayBtn(wednesdayBtn, wednesdayTapped)
            
            self.everydapTapped = false
            tappedDayBtn(everyDayBtn, everydapTapped)
            
        case thursdayBtn:
            self.thursdayTapped = changeBoolValue(buttonChecked: thursdayTapped)
            tappedDayBtn(thursdayBtn, thursdayTapped)
            
            self.everydapTapped = false
            tappedDayBtn(everyDayBtn, everydapTapped)
            
        case fridayBtn:
            self.fridayTapped = changeBoolValue(buttonChecked: fridayTapped)
            tappedDayBtn(fridayBtn, fridayTapped)
            
            self.everydapTapped = false
            tappedDayBtn(everyDayBtn, everydapTapped)
            
        case saturdayBtn:
            self.saturdayTapped = changeBoolValue(buttonChecked: saturdayTapped)
            tappedDayBtn(saturdayBtn, saturdayTapped)
            
            self.everydapTapped = false
            tappedDayBtn(everyDayBtn, everydapTapped)
            
        case sundayBtn:
            self.sundayTapped = changeBoolValue(buttonChecked: sundayTapped)
            tappedDayBtn(sundayBtn, sundayTapped)
            
            self.everydapTapped = false
            tappedDayBtn(everyDayBtn, everydapTapped)
            
        default:
            self.everydapTapped = changeBoolValue(buttonChecked: everydapTapped)
            tappedDayBtn(everyDayBtn, everydapTapped)
            
            self.mondayTapped = false
            self.tuesdayTapped = false
            self.wednesdayTapped = false
            self.thursdayTapped = false
            self.fridayTapped = false
            self.saturdayTapped = false
            self.sundayTapped = false
            
            setElseDaysBtnColor(self.tuesdayBtn, self.wednesdayBtn, self.thursdayBtn, self.fridayBtn, self.saturdayBtn, self.sundayBtn, self.mondayBtn)
            
        }
    }
    
    
    
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
