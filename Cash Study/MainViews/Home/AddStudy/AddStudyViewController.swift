//
//  AddStudyViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/13.
//

import UIKit

class AddStudyViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet weak var titleTF: UITextField! {
        didSet {
            titleTF.delegate = self
        }
    }
    @IBOutlet weak var textCntLbl: UILabel!
    
    @IBOutlet weak var repeatSd: UISlider!
    @IBOutlet weak var sdBtn: UIButton!
    
    @IBOutlet weak var startAtLbl: UILabel!
    
    @IBOutlet weak var everyDayBtn: UIButton!
    @IBOutlet weak var saturdayBtn: UIButton!
    @IBOutlet weak var sundayBtn: UIButton!
    @IBOutlet weak var mondayBtn: UIButton!
    @IBOutlet weak var tuesdayBtn: UIButton!
    @IBOutlet weak var wednesdayBtn: UIButton!
    @IBOutlet weak var thursdayBtn: UIButton!
    @IBOutlet weak var fridayBtn: UIButton!
    
    @IBOutlet var dateBtnCollection: [UIButton]!
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(textLengthLimit(_:)), name: UITextField.textDidChangeNotification, object: titleTF)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: titleTF)
    }
    
    
    @objc private func textLengthLimit(_ noti: Notification) {
        let maxLength : Int = 16
        if let textField = noti.object as? UITextField {
            if let text = textField.text {
                if text.count >= maxLength {
                    let index = text.index(text.startIndex, offsetBy: maxLength)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                }
            }
        }
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
    } 
    
    
    // MARK: Title Text Field
    @IBAction func showTextCount(_ sernder: Any) {
        guard let textCnt = self.titleTF.text?.count else { return }
        
        if textCnt > 16 {
            self.textCntLbl.text = "16/16"
        } else {
            self.textCntLbl.text = String(describing: textCnt) + "/16"
        }
    }
    
    
    @IBAction func sliderTapped(_ sender: Any) {
        if repeatSd.value == 0 {
            self.secondView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.isRepeat = true
            self.repeatSd.value = 1.0
            thirdView.isHidden = false
            
        } else {
            self.secondView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            self.isRepeat = false
            self.repeatSd.value = 0.0
            thirdView.isHidden = true
            
        }
    }
    
    
    func checkEveryDayBtn() {
        if mondayTapped == true && tuesdayTapped == true &&  wednesdayTapped == true && thursdayTapped == true && fridayTapped == true &&  saturdayTapped == true && sundayTapped == true {
            
            mondayTapped = false
            tuesdayTapped = false
            wednesdayTapped = false
            thursdayTapped = false
            fridayTapped = false
            saturdayTapped = false
            sundayTapped = false
            
            tappedDayBtn(mondayBtn, mondayTapped)
            tappedDayBtn(tuesdayBtn, tuesdayTapped)
            tappedDayBtn(wednesdayBtn, wednesdayTapped)
            tappedDayBtn(thursdayBtn, thursdayTapped)
            tappedDayBtn(fridayBtn, fridayTapped)
            tappedDayBtn(saturdayBtn, saturdayTapped)
            tappedDayBtn(sundayBtn, sundayTapped)
            
            everydapTapped = true
            tappedDayBtn(everyDayBtn, everydapTapped)
        }
    }
    
    
    @IBAction func showCalendarTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func dayBtnTapped(_ sender: UIButton) {
        var btnCheck : Bool = true
        
        if sender == everyDayBtn {
            // 매일 버튼 눌렀을 때
            if !everyDayBtn.isSelected {
                for date in dateBtnCollection {
                    date.isSelected = false
                    date.backgroundColor = UIColor.homeBorderColor
                    date.setTitleColor(.notSelectBtnColor, for: .normal)
                }
            }
        } else {
            // 나머지 버튼들을 눌렀을 때
            everyDayBtn.isSelected = false
            everyDayBtn.backgroundColor = UIColor.homeBorderColor
            everyDayBtn.setTitleColor(.notSelectBtnColor, for: .normal)
        }
        
        
        
        if !sender.isSelected {
            sender.isSelected = true
            sender.backgroundColor = UIColor.link
            sender.setTitleColor(.myGray, for: .normal)
            
            for date in dateBtnCollection {
                if date.isSelected == false {
                    btnCheck = false
                }
            }
            
            if btnCheck {
                for date in dateBtnCollection {
                    date.isSelected = false
                    date.backgroundColor = UIColor.homeBorderColor
                    date.setTitleColor(.notSelectBtnColor, for: .normal)
                    
                    everyDayBtn.isSelected = true
                    everyDayBtn.backgroundColor = UIColor.link
                    everyDayBtn.setTitleColor(.myGray, for: .normal)
                }
            }
            
        } else {
            sender.isSelected = false
            sender.backgroundColor = UIColor.homeBorderColor
            sender.setTitleColor(.notSelectBtnColor, for: .normal)
        }
        
    }
    
    
    
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
