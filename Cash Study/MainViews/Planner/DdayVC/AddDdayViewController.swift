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
    
    var icon : String = ""
    var isRepresentative : Bool = false
    var checkSuccess : Bool = false {
        didSet {
            changeRootVC(BaseTabBarController())
        }
    }
    var dDayId: Int = 0
    var isEdit: Bool = false
    
    init(id: Int, isEdit: Bool) {
        self.isEdit = isEdit
        self.dDayId = id
        
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: inputTitleTF)
        
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

    
    func setUI() {
        self.titleView.layer.cornerRadius = 8
        self.calendarView.layer.cornerRadius = 8
        self.representView.layer.cornerRadius = 8
        
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        btnCategory.forEach {
            $0.layer.cornerRadius = 8
        }
        
        if isEdit {
            self.titleLbl.text = "디데이 편집하기"
            self.confirmBtn.setTitle("저장하기", for: .normal)
            self.deleteBtn.isHidden = false
            
        } else {
            self.titleLbl.text = "디데이 추가하기"
            self.confirmBtn.setTitle("추가하기", for: .normal)
            self.deleteBtn.isHidden = true
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
                // 일반 디데이 경우
                guard let title = self.inputTitleTF.text else { return }
                if isEdit {
                    // 편집 모드
                    let input = EditDdayInput(title: title, endAt: "2021-12-01", icon: self.icon, isRepresentative: self.isRepresentative)
                    EditDdayDataManager().editDday(id: self.dDayId, input, viewController: self)
                    
                } else {
                    // 일반 추가 모드
                    let input = AddDdayInput(title: title, endAt: "2021-12-01", icon: self.icon, isRepresentative: self.isRepresentative)
                    AddDdayDataManager().addDday(input, viewController: self)
                }
               
            }
        }
        
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteTapBtn(_ sender: Any) {
        
    }
    
    
}
