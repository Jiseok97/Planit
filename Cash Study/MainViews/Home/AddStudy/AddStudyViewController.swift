//
//  AddStudyViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/13.
//

import UIKit
import KakaoSDKCommon

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
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var startTxtLbl: UILabel!
    @IBOutlet weak var startAtLbl: UILabel!
    @IBOutlet weak var startAtCalendarBtn: UIButton!
    @IBOutlet weak var endAtLbl: UILabel!
    @IBOutlet weak var endAtCalendarBtn: UIButton!
    
    
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
    var isAlreadyExist : Bool = false {
        didSet {
            let vc = ObAlertViewController(mainMsg: "해당 공부는 이미 존재합니다\n제목을 수정해주세요", subMsg: "", heightValue: 0.2, btnTitle: "확인", isTimer: false, isMypage: false, networkConnect: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    var editRpSuccess : Bool = false {
        didSet {
            let vc = ObAlertViewController(mainMsg: "오늘 일자 이후의\n공부 반복하기를 변경합니다", subMsg: "", heightValue: 0.2, btnTitle: "확인", isTimer: false, isMypage: false, networkConnect: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
    var dateCase : [String] = [ "월", "화", "수", "목", "금", "토", "일" ]
    var allDateLst : [String] = [ "월", "화", "수", "목", "금", "토", "일" ]
    var limitedBtn : [UIButton] = []
    var limitedBtnCheck: Int = 0
    
    var stGrId: Int = 0
    var stSchId: Int = 0
    var stTitle: String = ""
    var isEdit: Bool = false
    var startAtTxt : String = ""
    var endAtTxt : String = ""
    
    var startDay : Int = 0
    var endDay : Int = 0
    
    init(stGrId: Int, stSchId: Int, title: String, startAtTxt: String, endAtTxt: String, isEdit: Bool, isRepeat: Bool) {
        self.stGrId = stGrId
        self.stSchId = stSchId
        self.stTitle = title
        self.startAtTxt = startAtTxt
        self.endAtTxt = endAtTxt
        self.isEdit = isEdit
        self.isRepeat = isRepeat
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var btnCheck : Bool = true
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(textLengthLimit(_:)), name: UITextField.textDidChangeNotification, object: titleTF)
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendDate(_:)), name: Notification.Name("sendDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(endDate(_:)), name: NSNotification.Name("endDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeStudy(_:)), name: NSNotification.Name("removeStudy"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: titleTF)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("sendDate"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("endDate"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("removeStudy"), object: nil)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        if string.hasCharacters() || isBackSpace == -92{
            return true
        }
        return false
    }

    func setUI() {
        let toDate = DateFormatter()
        toDate.locale = Locale(identifier: "ko_KR")
        toDate.dateFormat = "yyyy년 MM월 dd일 (E)"
        
        self.startAtLbl.text = toDate.string(from: Date())
        self.endAtLbl.text = toDate.string(from: Date() + (3600 * 24))
        
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
        
        if !isEdit {
            self.deleteBtn.isHidden = true
            self.confirmBtn.setTitle("추가하기", for: .normal)
            self.titleLbl.text = "공부 추가하기"
            
        } else {
            self.deleteBtn.isHidden = false
            self.confirmBtn.setTitle("저장하기", for: .normal)
            self.titleTF.text = stTitle
            self.titleLbl.text = "공부 편집하기"
            self.textCntLbl.text = String(describing: stTitle.count) + "/16"
            self.startAtLbl.text = startAtTxt
        }
        
        if isRepeat {
            self.repeatSd.value = 1.0
            self.secondView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.isRepeat = true
            thirdView.isHidden = false
            startTxtLbl.text = "시작일"
            self.endAtLbl.text = endAtTxt
            limitDateBtn()
            
        } else {
            self.repeatSd.value = 0.0
            self.secondView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            self.isRepeat = false
            thirdView.isHidden = true
            startTxtLbl.text = "날짜"
        }
        
    }
    
    
    @objc func sendDate(_ noti : Notification) {
        if Constant.DATE_TEXT != "" {
            self.startAtLbl.text = Constant.DATE_TEXT
            Constant.DATE_TEXT = ""
        }
        
        limitDateBtn()
    }
    
    @objc func endDate(_ noti: Notification) {
        if Constant.DATE_TEXT != "" {
            self.endAtLbl.text = Constant.DATE_TEXT
            Constant.DATE_TEXT = ""
        }
        
        dateBtnCollection.forEach {
            $0.isEnabled = true
            $0.isSelected = false
            $0.backgroundColor = UIColor.homeBorderColor
            $0.setTitleColor(.placeHolderColor, for: .normal)
        }
        self.everyDayBtn.isEnabled = true
        self.everyDayBtn.isSelected = false
        self.everyDayBtn.backgroundColor = UIColor.homeBorderColor
        self.everyDayBtn.setTitleColor(.placeHolderColor, for: .normal)
        
        limitDateBtn()
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
            startTxtLbl.text = "시작일"
            limitDateBtn()
            
        } else {
            self.secondView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            self.isRepeat = false
            self.repeatSd.value = 0.0
            thirdView.isHidden = true
            startTxtLbl.text = "날짜"
            
        }
    }
    
    
    func limitDateBtn() {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "E"
        
        let datefm = DateFormatter()
        datefm.dateFormat = "yyyyMMdd"
        
        var sTxt : String = ""
        var eTxt : String = ""
       
        sTxt = Constant.DATE.replacingOccurrences(of: "-", with: "")
        eTxt = Constant.END_DATE.replacingOccurrences(of: "-", with: "")
        
        if isEdit && isRepeat {
            // Edit Mode → default value
            sTxt = Constant.START_AT.replacingOccurrences(of: "-", with: "")
            eTxt = Constant.END_AT.replacingOccurrences(of: "-", with: "")
        }
        
        if sTxt != "" {
            self.startDay = Int(sTxt)!
        } else {
            self.startDay = Int(datefm.string(from: Date()))!
        }
        
        if eTxt != "" {
            self.endDay = Int(eTxt)!
        } else {
            self.endDay = Int(datefm.string(from: Date() + (3600 * 24)))!
        }
         
        
        if endDay - startDay < 6 {
            allDateLst = [ "월", "화", "수", "목", "금", "토", "일" ]
            dateCase = [ "월", "화", "수", "목", "금", "토", "일" ]
            limitedBtn = []
            
            self.tappedDayButtons.removeAll()
            
            if startDay <= endDay {
                for i in startDay...endDay {
                    let data = datefm.date(from: String(describing: i))!
                    let a = df.string(from: data)
                    allDateLst.removeAll(where: { $0 == a } )
                }
            }
            
            
            for date in allDateLst {
                dateCase.removeAll(where: {$0 == date} )
            }
            
            dateCase.forEach {
                switch $0 {
                case "월" : limitedBtn.append(mondayBtn)
                case "화" : limitedBtn.append(tuesdayBtn)
                case "수" : limitedBtn.append(wednesdayBtn)
                case "목" : limitedBtn.append(thursdayBtn)
                case "금" : limitedBtn.append(fridayBtn)
                case "토" : limitedBtn.append(saturdayBtn)
                default: limitedBtn.append(sundayBtn)
                }
            }
            
            allDateLst.forEach {
                switch $0 {
                case "월":
                    limitBtnSetup(self.mondayBtn)
                    
                case "화":
                    limitBtnSetup(self.tuesdayBtn)
                    
                case "수":
                    limitBtnSetup(self.wednesdayBtn)
                    
                case "목":
                    limitBtnSetup(self.thursdayBtn)
                    
                case "금":
                    limitBtnSetup(self.fridayBtn)
                    
                case "토":
                    limitBtnSetup(self.saturdayBtn)
                    
                default:
                    limitBtnSetup(self.sundayBtn)
                }
            }
        } else {
            self.limitedBtn = [ mondayBtn, tuesdayBtn, wednesdayBtn, thursdayBtn, fridayBtn, saturdayBtn, sundayBtn ]
            self.tappedDayButtons.removeAll()
        }
        
    }
    
    
    // MARK: 버튼 요일 제어
    @IBAction func dayBtnTapped(_ sender: UIButton) {
        
        guard let txt = sender.titleLabel?.text else { return }
        
        if sender == everyDayBtn {
            if !everyDayBtn.isSelected {
                // 매일 버튼 클릭 시
                dateBtnCollection.forEach {
                    // 다른 요일 버튼 활성화 꺼짐
                    if $0.isEnabled {
                        $0.isSelected = false
                        $0.backgroundColor = UIColor.homeBorderColor
                        $0.setTitleColor(.placeHolderColor, for: .normal)
                    }
                }
            }
            
        } else {
            // 다른 버튼 클릭시
            if everyDayBtn.isSelected {
                // 배열 값 삭제
                tappedDayButtons.removeAll()
            }
            
            // 비활성화가 된 버튼들만 다 눌러도 매일 버튼 활성화를 위함(카운팅)
            if limitedBtn.contains(sender) {
                if !sender.isSelected {
                    self.limitedBtnCheck += 1
                } else {
                    self.limitedBtnCheck -= 1
                }
            }
            
        }
        
        
        if sender.isEnabled {
            if !sender.isSelected {
                sender.isSelected = true
                sender.backgroundColor = UIColor.link
                sender.setTitleColor(.myGray, for: .normal)
                
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
                    dateBtnCollection.forEach {
                        if $0.isEnabled == true {
                            
                        }
                    }
                    tappedDayButtons.removeAll()
                    tappedDayButtons.append(String("MONDAY"))
                    tappedDayButtons.append(String("TUESDAY"))
                    tappedDayButtons.append(String("WEDNESDAY"))
                    tappedDayButtons.append(String("THURSDAY"))
                    tappedDayButtons.append(String("FRIDAY"))
                    tappedDayButtons.append(String("SATURDAY"))
                    tappedDayButtons.append(String("SUNDAY"))
                }
                
                
                // 비활성화 된 버튼 나머지들을 활성화 & 매일 버튼 동기화
                if sender != everyDayBtn {
                    if limitedBtn.count == limitedBtnCheck{
                        everyDayBtn.isSelected = true
                        everyDayBtn.backgroundColor = UIColor.link
                        everyDayBtn.setTitleColor(.myGray, for: .normal)
                        
                        limitedBtn.forEach {
                            limitedBtnCheck = 0
                            $0.isSelected = false
                            $0.backgroundColor = UIColor.homeBorderColor
                            $0.setTitleColor(.placeHolderColor, for: .normal)
                        }
                        
                    } else {
                        everyDayBtn.isSelected = false
                        everyDayBtn.backgroundColor = UIColor.homeBorderColor
                        everyDayBtn.setTitleColor(.placeHolderColor, for: .normal)
                    }
                } else {
                    limitedBtnCheck = 0
                }
                
            }
            
            // 선택된 버튼을 재클릭 했을 때
            else {
                sender.isSelected = false
                sender.backgroundColor = UIColor.homeBorderColor
                sender.setTitleColor(.placeHolderColor, for: .normal)
                
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
    }
    
    @IBAction func showCalendar(_ sender: UIButton) {
        
        switch sender {
        case startAtCalendarBtn:
            let vc = CalendarAlertViewController(isEnd: false, checkDday: false, isReport: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
            
        default:
            let vc = CalendarAlertViewController(isEnd: true, checkDday: false, isReport: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
        
    }
    
    
    @IBAction func addStudyBtnTapped(_ sender: UIButton) {
        guard let title = titleTF.text else { return }

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        var sDate = Constant.DATE
        var eDate = Constant.END_DATE
        
        if sDate == "" {
            sDate = df.string(from: Date())
        }
        if eDate == "" {
            eDate = df.string(from: Date())
        }
        
        if titleTF.text?.isEmpty == true {
            let vc = ObAlertViewController(mainMsg: "제목은 한 글자 이상 입력하세요", subMsg: "", heightValue: 0.2, btnTitle: "확인", isTimer: false, isMypage: false, networkConnect: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
            
        } else {
            if repeatSd.value == 1 {
                if sDate > eDate {
                    let vc = ObAlertViewController(mainMsg: "종료일은 시작일보다\n이전일 수 없습니다", subMsg: "", heightValue: 0.2, btnTitle: "확인", isTimer: false, isMypage: false, networkConnect: false)
                    vc.modalPresentationStyle = .overFullScreen
                    present(vc, animated: true)
                } else {
                    if isEdit {
                        let dt = df.string(from: Date())
                        if dt >= sDate {
                            let vc = ObAlertViewController(mainMsg: "오늘 이후의 날짜만 선택 가능합니다", subMsg: "", heightValue: 0.2, btnTitle: "확인", isTimer: false, isMypage: false, networkConnect: false)
                            vc.modalPresentationStyle = .overFullScreen
                            present(vc, animated: true)
                        } else {
                            let input = EditRepeatStudyInput(title: title, startAt: sDate, endAt: eDate, repeatedDays: tappedDayButtons)
                            showIndicator()
                            EditStudyDataManager().editRepeatStudy(stGroupId: stGrId, stScheduleId: stSchId, input, viewController: self)
                        }
                    } else {
                        let input = RepeatStudyInput(title: title, startAt: sDate, endAt: eDate, repeatedDays: tappedDayButtons)
                        showIndicator()
                        AddStudyDataManager().repeatStudy(input, viewController: self)
                    }
                }
            } else {
                if isEdit {
                    let dt = df.string(from: Date())
                    if dt >= sDate {
                        let vc = ObAlertViewController(mainMsg: "오늘 이후의 날짜만 선택 가능합니다", subMsg: "", heightValue: 0.2, btnTitle: "확인", isTimer: false, isMypage: false, networkConnect: false)
                        vc.modalPresentationStyle = .overFullScreen
                        present(vc, animated: true)
                    } else {
                        let input = EditStudyInput(title: title, startAt: sDate)
                        showIndicator()
                        EditStudyDataManager().editSingleStudy(stGroupId: stGrId, stScheduleId: stSchId, input, viewController: self)
                    }
                } else {
                    let input = SingleStudyInput(title: title, startAt: sDate)
                    showIndicator()
                    print("Study add = \(sDate)")
                    AddStudyDataManager().singleStudy(input, viewController: self)
                }
            }
        }
    }
    
    @objc func removeStudy(_ noti: Notification) {
        showIndicator()
        DeleteStudyDataManager().deleteStudy(stGroupId: stGrId, viewController: self)
    }
    
    
    @IBAction func delteBtnTapped(_ sender: Any) {
        let vc = AlertViewController(mainMsg: "공부를 삭제하시겠습니까?", subMsg: "해당 공부와 관련된 기록은\n모두 삭제됩니다", btnTitle: "삭제", isTimer: false, isLogout: false, studyRemove: true, passMode: false)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
