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
    
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var firstBtnClicked: Bool = false
    var secondBtnClicked: Bool = false
    var thirdBtnClicked: Bool = false
    var fourthBtnClicked: Bool = false
    var fifthBtnClicked: Bool = false
    
    var icon : String = "STAR"
    var isRepresentative : Bool = false
    var checkSuccess : Bool = false {
        didSet {
            dismiss(animated: true, completion: nil)
        }
    }
    var checkEdit : Bool = false {
        didSet {
            dismiss(animated: true, completion: nil)
        }
    }
    var dDayId: Int = 0
    var isEdit: Bool = false
    var titleTxt: String = ""
    
    init(id: Int, title : String, isEdit: Bool, isRepresentative: Bool) {
        self.isEdit = isEdit
        self.dDayId = id
        self.titleTxt = title
        self.isRepresentative = isRepresentative
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(textLengthLimit(_:)), name: UITextField.textDidChangeNotification, object: inputTitleTF)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeDday(_:)), name: NSNotification.Name("remove"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setRepresent(_:)), name: Notification.Name("setRepresent"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendDate(_:)), name: Notification.Name("sendDate"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: inputTitleTF)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("remove"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("setRepresent"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("sendDate"), object: nil)
    }
    
    
    
    
    // MARK: Functions
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
    
    @objc func removeDday(_ noti: Notification) {
        DeleteDdayDataManager().deleteDday(id: self.dDayId, viewController: self)
    }
    
    @objc func setRepresent(_ noti: Notification) {
        self.checkRepresentSd.value = 1.0
        self.isRepresentative = true
    }
    
    @objc func sendDate(_ noti : Notification) {
        if Constant.DATE_TEXT != "" {
            self.dateLbl.text = Constant.DATE_TEXT
            Constant.DATE_TEXT = ""
        }
    }

    
    func setUI() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 (E)"
        
        self.dateLbl.text = dateFormatter.string(from: Date())
        self.titleView.layer.cornerRadius = 8
        self.calendarView.layer.cornerRadius = 8
        self.representView.layer.cornerRadius = 8
        
        self.thirdBtn.isSelected = true
        
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        btnCategory.forEach {
            $0.layer.cornerRadius = 8
        }
        
        if isEdit {
            self.titleLbl.text = "디데이 편집하기"
            self.confirmBtn.setTitle("저장하기", for: .normal)
            self.deleteBtn.isHidden = false
            self.inputTitleTF.text = titleTxt
            self.countTfLbl.text = String(describing: titleTxt.count) + "/10"
            
        } else {
            self.titleLbl.text = "디데이 추가하기"
            self.confirmBtn.setTitle("추가하기", for: .normal)
            self.deleteBtn.isHidden = true
        }
        
        if isRepresentative {
            self.checkRepresentSd.value = 1.0
        } else {
            self.checkRepresentSd.value = 0.0
        }
    
    }
    
    @IBAction func showCalendarBtn(_ sender: Any) {
        let vc = CalendarAlertViewController(isEnd: false, checkDday: true, isReport: false)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func showTextCount(_ sender: Any) {
        guard let textCnt = self.inputTitleTF.text?.count else { return }
        
        if textCnt > 10 {
            self.countTfLbl.text = "10/10"
        } else {
            self.countTfLbl.text = String(describing: textCnt) + "/10"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        if string.hasCharacters() || isBackSpace == -92{
            return true
        }
        return false
    }

    
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

            icon = "PLANET"
            
        case self.secondBtn:
            self.secondBtnClicked = changeBoolValue(buttonChecked: secondBtnClicked)
            setBtnColors(secondBtn, secondBtnClicked)
            
            self.firstBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            
            setElseBtnColors(firstBtn, thirdBtn, fourthBtn, fifthBtn)

            icon = "PLANET_WITH_RINGS"
            
        case self.thirdBtn:
            self.thirdBtnClicked = changeBoolValue(buttonChecked: thirdBtnClicked)
            setBtnColors(thirdBtn, thirdBtnClicked)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.fourthBtnClicked = false
            self.fifthBtnClicked = false
            
            setElseBtnColors(firstBtn, secondBtn, fourthBtn, fifthBtn)

            icon = "STAR"
            
        case self.fourthBtn:
            self.fourthBtnClicked = changeBoolValue(buttonChecked: fourthBtnClicked)
            setBtnColors(fourthBtn, fourthBtnClicked)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fifthBtnClicked = false
            
            setElseBtnColors(firstBtn, secondBtn, thirdBtn, fifthBtn)

            icon = "FLAME"
            
        default:
            self.fifthBtnClicked = changeBoolValue(buttonChecked: fifthBtnClicked)
            setBtnColors(fifthBtn, fifthBtnClicked)
            
            self.firstBtnClicked = false
            self.secondBtnClicked = false
            self.thirdBtnClicked = false
            self.fourthBtnClicked = false
            
            setElseBtnColors(firstBtn, secondBtn, thirdBtn, fourthBtn)

            icon = "UFO"
        }
    }
    
    
    @IBAction func sliderTapped(_ sender: Any) {
        if checkRepresentSd.value == 0.0 {
            let vc = AlertViewController(mainMsg: "대표 디데이를 설정하시겠어요?", subMsg: "홈에 표시되는 대표 디데이는\n1개만 설정할 수 있어요", btnTitle: "확인", isTimer: false, isLogout: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
            
        } else {
            self.checkRepresentSd.value = 0.0
            self.isRepresentative = false
        }
    }
    
    
    @IBAction func addDdayTapped(_ sender: Any) {
        guard let title = self.inputTitleTF.text else { return }
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        var endDate = Constant.DATE
        
        if endDate == "" {
            endDate = df.string(from: Date())
        }
        
        if inputTitleTF.text?.isEmpty == true && Constant.DATE == "" {
            // 제목은 한글자 이상 적어주세요.
            let vc = ObAlertViewController(mainMsg: "제목은 한 글자 이상 입력하세요", subMsg: "", btnTitle: "확인", isTimer: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
            
        } else  {
            if isEdit {
                // 편집 모드
                let input = EditDdayInput(title: title, endAt: endDate, icon: self.icon, isRepresentative: self.isRepresentative)
                showIndicator()
                EditDdayDataManager().editDday(id: self.dDayId, input, viewController: self)
            }
            
            else {
                // 추가 모드
                let input = AddDdayInput(title: title, endAt: endDate, icon: self.icon, isRepresentative: self.isRepresentative)
                showIndicator()
                AddDdayDataManager().addDday(input, viewController: self)
            }
        }
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteTapBtn(_ sender: Any) {
        let vc = AlertViewController(mainMsg: "디데이를 삭제하시겠습니까?", subMsg: "", btnTitle: "삭제", isTimer: false, isLogout: false)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
}
