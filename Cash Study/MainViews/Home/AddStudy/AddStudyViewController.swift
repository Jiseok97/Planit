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
    var tappedDayButtons: [String] = []
    var checkSuccess : Bool = false {
        didSet {
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(textLengthLimit(_:)), name: UITextField.textDidChangeNotification, object: titleTF)
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendDate(_:)), name: Notification.Name("sendDate"), object: nil)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: titleTF)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("sendDate"), object: nil)
    }
    
    
    // MARK: Functions
    
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
        let toDate = DateFormatter()
        toDate.locale = Locale(identifier: "ko_KR")
        toDate.dateFormat = "yyyy년 MM월 dd일 (E)"
        
        self.startAtLbl.text = toDate.string(from: Date())
        
        self.titleView.layer.cornerRadius = 8
        self.secondView.layer.cornerRadius = 8
        self.thirdView.layer.cornerRadius = 8
        
        dateBtnCollection.forEach {
            $0.layer.cornerRadius = 8
        }
        
        self.everyDayBtn.layer.cornerRadius = 8
        
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        
        self.backBtn.setTitle("", for: .normal)
        self.sdBtn.setTitle("", for: .normal)
    }
    
    @objc func sendDate(_ noti : Notification) {
        if Constant.DATE_TEXT != "" {
            self.startAtLbl.text = Constant.DATE_TEXT
            Constant.DATE_TEXT = ""
        }
    }
    
    
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
    
    
    
    @IBAction func dayBtnTapped(_ sender: UIButton) {
        var btnCheck : Bool = true
        guard let txt = sender.titleLabel?.text else { return }
        
        if sender == everyDayBtn {
            // 매일 버튼 눌렀을 때
            if !everyDayBtn.isSelected {
                dateBtnCollection.forEach {
                    $0.isSelected = false
                    $0.backgroundColor = UIColor.homeBorderColor
                    $0.setTitleColor(.notSelectBtnColor, for: .normal)
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
           
            dateBtnCollection.forEach {
                if !$0.isSelected {
                    btnCheck = false
                }
            }
            
            switch txt {
                
            case "월":
                tappedDayButtons.append(String("MONDAY"))
                
            case "화":
                tappedDayButtons.append(String("TUESDAY"))
                
            case "수":
                tappedDayButtons.append(String("WEDNESDAY"))
                
            case "목":
                tappedDayButtons.append(String("THURSDAY"))
                
            case "금":
                tappedDayButtons.append(String("FRIDAY"))
                
            case "토":
                tappedDayButtons.append(String("SATURDAY"))
                
            case "일":
                tappedDayButtons.append(String("SUNDAY"))
                
            default:
                tappedDayButtons.append(String("MONDAY"))
                tappedDayButtons.append(String("TUESDAY"))
                tappedDayButtons.append(String("WEDNESDAY"))
                tappedDayButtons.append(String("THURSDAY"))
                tappedDayButtons.append(String("FRIDAY"))
                tappedDayButtons.append(String("SATURDAY"))
                tappedDayButtons.append(String("SUNDAY"))
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
            
            switch txt {
                
            case "월":
                tappedDayButtons.removeAll(where: { $0 == "MONDAY"} )
                
            case "화":
                tappedDayButtons.removeAll(where: { $0 == "TUESDAY"} )
                
            case "수":
                tappedDayButtons.removeAll(where: { $0 == "WEDNESDAY"} )
                
            case "목":
                tappedDayButtons.removeAll(where: { $0 == "THURSDAY"} )
                
            case "금":
                tappedDayButtons.removeAll(where: { $0 == "FRIDAY"} )
                
            case "토":
                tappedDayButtons.removeAll(where: { $0 == "SATURDAY"} )
                
            case "일":
                tappedDayButtons.removeAll(where: { $0 == "SUNDAY"} )
                
            default:
                tappedDayButtons.removeAll()
            }
            
        }
        
    }
    
    @IBAction func showCalendar(_ sender: Any) {
        let vc = CalendarAlertViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func addStudyBtnTapped(_ sender: Any) {
        guard let title = titleTF.text else { return }
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        var inputDate = Constant.DATE
        
        if inputDate == "" {
            inputDate = df.string(from: Date())
        }

        if repeatSd.value == 1 {
            // 반복
            
            print(tappedDayButtons)
        } else {
            // 반복 없음
            let input = SingleStudyInput(title: title, startAt: inputDate)
            AddStudyDataManager().singleStudy(input, viewController: self)
        }
    }
    
    
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
