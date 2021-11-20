//
//  AddDdayViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/10.
//

import UIKit

class AddDdayViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var inputTitleTF: UITextField! {
        didSet {
            inputTitleTF.delegate = self
        }
    }
    @IBOutlet weak var countTfLbl: UILabel!
    
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var fifthBtn: UIButton!
    
    @IBOutlet weak var representView: UIView!
    @IBOutlet weak var checkRepresentSd: UISlider!
    @IBOutlet weak var sdButton: UIButton!
    
    @IBOutlet var btnCategory: [UIButton]!
    
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    var firstBtnClicked: Bool = false
    var secondBtnClicked: Bool = false
    var thirdBtnClicked: Bool = false
    var fourthBtnClicked: Bool = false
    var fifthBtnClicked: Bool = false
    
    var color : String = ""
    var isRepresentative : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(textLengthLimit(_:)), name: UITextField.textDidChangeNotification, object: inputTitleTF)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: inputTitleTF)
    }
    
    @objc private func textLengthLimit(_ noti: Notification) {
        let maxLength : Int = 10
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
        self.calendarView.layer.cornerRadius = 8
        self.representView.layer.cornerRadius = 8
        
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        // foreach
        
        btnCategory.forEach {
            $0.layer.cornerRadius = 8
        }
    }
    
    // MARK: About Text Field
    @IBAction func showTextCount(_ sender: Any) {
        guard let textCnt = self.inputTitleTF.text?.count else { return }
        
        if textCnt > 10 {
            self.countTfLbl.text = "10/10"
        } else {
            self.countTfLbl.text = String(describing: textCnt) + "/10"
        }
    }
    
    
    
    
    
    // MARK: Check Icon Button
    @IBAction func selectIconBtnTapped(_ sender: UIButton) {
        switch sender {
            
        case self.firstBtn:
            self.firstBtnClicked = changeBoolValue(buttonChecked: firstBtnClicked)
            setBtnColors(firstBtn, firstBtnClicked)
            
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            
            setElseBtnColors(secondBtn, thirdBtn, fourthBtn, fifthBtn)

            color = "YELLOW"
            
        case self.secondBtn:
            self.secondBtnClicked = changeBoolValue(buttonChecked: secondBtnClicked)
            setBtnColors(secondBtn, secondBtnClicked)
            
            self.firstBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            
            setElseBtnColors(firstBtn, thirdBtn, fourthBtn, fifthBtn)

            color = "GREEN"
            
        case self.thirdBtn:
            self.thirdBtnClicked = changeBoolValue(buttonChecked: thirdBtnClicked)
            setBtnColors(thirdBtn, thirdBtnClicked)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            
            setElseBtnColors(firstBtn, secondBtn, fourthBtn, fifthBtn)

            color = "PINK"
            
        case self.fourthBtn:
            self.fourthBtnClicked = changeBoolValue(buttonChecked: fourthBtnClicked)
            setBtnColors(fourthBtn, fourthBtnClicked)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fifthBtnClicked = false
            
            setElseBtnColors(firstBtn, secondBtn, thirdBtn, fifthBtn)

            color = "LIGHT_BLUE"
            
        default:
            self.fifthBtnClicked = changeBoolValue(buttonChecked: fifthBtnClicked)
            setBtnColors(fifthBtn, fifthBtnClicked)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            
            setElseBtnColors(firstBtn, secondBtn, thirdBtn, fourthBtn)

            color = "DARK_BLUE"
        }
    }
    
    
    @IBAction func sliderTapped(_ sender: Any) {
        if checkRepresentSd.value == 0.0 {
            self.checkRepresentSd.value = 1.0
            self.isRepresentative = true
        } else {
            self.checkRepresentSd.value = 0.0
            self.isRepresentative = false
        }
    }
    
    
    
    // MARK: Confirm Btn Tapped
    @IBAction func addDdayTapped(_ sender: Any) {
        // 커스텀 뷰 띄우기
        if inputTitleTF.text?.isEmpty == true {
            // 제목은 한글자 이상 적어주세요.
            
        } else  {
            if self.isRepresentative {
                // 해당 디데이를 대표 디데이로 설정하시겠어요?
                // 여기서 확인 누르면 끝
                // 아니오 누르면 데이터 안 보내기
                
            } else {
                let input = AddDdayInput(title: self.inputTitleTF.text!, endAt: "2021-11-20", color: self.color, isRepresentative: self.isRepresentative)
                AddDdayDataManager().addDday(input, viewController: self)
            }
            
            
            // 데이터를 성공적으로 가져왔을 때, DdayPageVC.dDayCV.reloadData() & dismiss 해주기
        }
        
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
