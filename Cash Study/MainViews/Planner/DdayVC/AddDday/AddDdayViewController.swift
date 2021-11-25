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
//            changeRootVC(BaseTabBarController())
            dismiss(animated: true, completion: nil)
        }
    }
    var checkEdit : Bool = false {
        didSet {
//            DeleteDdayDataManager().deleteDday(id: dDayId, viewController: self)
            dismiss(animated: true, completion: nil)
        }
    }
    var dDayId: Int = 0
    var isEdit: Bool = false
    var titleTxt: String = ""
    
    init(id: Int, title : String, isEdit: Bool) {
        self.isEdit = isEdit
        self.dDayId = id
        self.titleTxt = title
        
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
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: inputTitleTF)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("remove"), object: nil)
    }
    
    @objc func removeDday(_ noti: Notification) {
        DeleteDdayDataManager().deleteDday(id: self.dDayId, viewController: self)
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
            self.inputTitleTF.text = titleTxt
            
        } else {
            self.titleLbl.text = "디데이 추가하기"
            self.confirmBtn.setTitle("추가하기", for: .normal)
            self.deleteBtn.isHidden = true
        }
    }
    
    
    
    @IBAction func showTextCount(_ sender: Any) {
        guard let textCnt = self.inputTitleTF.text?.count else { return }
        
        if textCnt > 10 {
            self.countTfLbl.text = "10/10"
        } else {
            self.countTfLbl.text = String(describing: textCnt) + "/10"
        }
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
            let vc = AlertViewController(mainMsg: "대표 디데이를 설정하시겠어요?", subMsg: "홈에 표시되는 대표 디데이는\n1개만 설정할 수 있어요", btnTitle: "확인")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
            
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
        guard let title = self.inputTitleTF.text else { return }
        
        if inputTitleTF.text?.isEmpty == true {
            // 제목은 한글자 이상 적어주세요.
//            let vc = AlertViewController(mainMsg: "제목은 한 글자 이상 입력하세요", subMsg: "")
//            vc.modalPresentationStyle = .overFullScreen
//            present(vc, animated: true)
            
        } else  {
            if isEdit {
                // 편집 모드
                let input = EditDdayInput(title: title, endAt: "2021-12-01", icon: self.icon, isRepresentative: self.isRepresentative)
                EditDdayDataManager().editDday(id: self.dDayId, input, viewController: self)
                if isRepresentative == true {
                    // 대표 디데이 설정 커스텀 창 띄우기
                }
            }
            
            else {
                // 추가 모드
                let input = AddDdayInput(title: title, endAt: "2021-12-01", icon: self.icon, isRepresentative: self.isRepresentative)
                AddDdayDataManager().addDday(input, viewController: self)
                if isRepresentative == true {
                    // 대표 디데이 설정 커스텀 창 띄우기
                }
            }
        }
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteTapBtn(_ sender: Any) {
        let vc = AlertViewController(mainMsg: "디데이를 삭제하시겠습니까?", subMsg: "", btnTitle: "삭제")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
}
