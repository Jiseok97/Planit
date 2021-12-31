//
//  TimerStopViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/08.
//

import UIKit
import MSCircularSlider

class TimerViewController: UIViewController {
    
    @IBOutlet weak var circleView: MSCircularSlider!
    @IBOutlet weak var circleBgView: UIView!
    @IBOutlet weak var restCntView: UIView!
    @IBOutlet weak var rewardView: UIView!
    @IBOutlet weak var bonusView: UIView!
    @IBOutlet weak var stopBtn: UIButton!
    
    @IBOutlet weak var studyTitleLbl: UILabel!
    @IBOutlet weak var restCntLbl: UILabel!
    @IBOutlet weak var rewardCntLbl: UILabel!
    @IBOutlet weak var bonusCntLbl: UILabel!
    
    @IBOutlet weak var timerLbl: UILabel!
    
    var studyTitle : String = ""
    
    var timer : Timer?
    var timeCnt : Int = 0
    var prevRcrd: Int = 0
    var recordDataLst: ShowRecordEntity?
    var stId: Int
    var restCnt : Int = 0
    var rw : Int = 0
    var bn : Int = 0
    var rewardCnt: Int = 0
    var bonusCnt: Int = 0
    
    init(title: String, stId: Int) {
        self.studyTitle = title
        self.stId =  stId
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for sleep mode
        UIApplication.shared.isIdleTimerDisabled = true

        setUI()
        showIndicator()
        ShowRecordDataManager().showRecord(stId: self.stId, viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showAlert()
        if self.recordDataLst != nil {
            self.restCntLbl.text = "\(String(describing: recordDataLst?.rest))회"
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(timerStop(_:)), name: NSNotification.Name("timerStop"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showRestTimer(_:)), name: NSNotification.Name("ShowRestTimer"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("timerStop"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("ShowRestTimer"), object: nil)
    }
    

    // MARK: Functions
    func setUI() {
        self.startTimer()
        self.studyTitleLbl.text = studyTitle
        
        self.circleView.backgroundColor = UIColor.circleBgColor.withAlphaComponent(0.0)
        self.circleView.layer.zPosition = 999
        self.circleView._maximumRevolutions = 24
        self.circleView._currentValue = 0.0
        self.circleView.isUserInteractionEnabled = false
        
        self.circleBgView.layer.cornerRadius = circleBgView.bounds.width / 2
        self.circleBgView.clipsToBounds = true
        self.circleBgView.layer.zPosition = 0
        
        self.restCntView.layer.cornerRadius = restCntView.frame.height / 2
        self.rewardView.layer.cornerRadius = rewardView.frame.height / 2
        self.bonusView.layer.cornerRadius = bonusView.frame.height / 2
        self.stopBtn.layer.cornerRadius = stopBtn.frame.height / 2
        
    }
    
    func showAlert() {
        let vc = ObAlertViewController(mainMsg: "기기의 홈버튼을 이용해서\n앱을 나가면 타이머 측정이\n자동으로 멈추게 돼요.", subMsg: "앱을 유지해주세요", heightValue: 0.28,
                                       btnTitle: "공부시간 측정 시작하기",
                                       isTimer: true, isMypage: false)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func timerStop(_ noti: Notification) {
        let stvc = StopTimerViewController(stId: stId, title: self.studyTitle, totalRcrd: self.prevRcrd, additionalRcrd: self.timeCnt, starCnt: self.rewardCnt, bonusCnt: self.bonusCnt, restCnt: self.restCnt, isEdit: false)
        stvc.modalPresentationStyle = .overFullScreen
        present(stvc, animated: true)
    }
    
    @objc func showRestTimer(_ noti: Notification) {
        self.restCnt += 1
        self.restCntLbl.text = "\(String(describing: restCnt))회"
        
        let vc = RestTimerViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    func makeTimeLabel(count: Int) -> String {
        let sec = timeCnt % 60
        let min = (timeCnt / 60) % 60
        let hour = timeCnt / 3600
        
        let secString = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
        let minString = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        let hourString = "\(hour)".count == 1 ? "0\(hour)" : "\(hour)"
        
        return ("\(hourString):\(minString):\(secString)")
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.rw += 1
            self.bn += 1
            if self.rw % 300 == 0 {
                self.rw *= 0
                self.rewardCnt += 1
            }
            if self.bn % 3600 == 0 {
                self.bn *= 0
                self.bonusCnt += 1
            }
            
            self.timeCnt += 1
            self.circleView._currentValue += 1
            if self.circleView._currentValue > 3599.9 {
                self.circleView._currentValue = 0.0
            }
                
            DispatchQueue.main.async {
                let timeString = self.makeTimeLabel(count: self.timeCnt)
                self.timerLbl.text = timeString
                self.rewardCntLbl.text = "\(self.rewardCnt)"
                self.bonusCntLbl.text = "\(self.bonusCnt)"
                
            }
        })
    }
    
    func isTimerStop(_ btn: UIButton, _ check: Bool) {
        if check {
            btn.setTitle("타이머 시작하기", for: .normal)
            btn.backgroundColor = .mainNavy
            btn.layer.borderWidth = 0.8
            btn.layer.borderColor = UIColor.link.cgColor
        } else {
            btn.setTitle("타이머 멈추기", for: .normal)
            btn.backgroundColor = .link
            btn.layer.borderWidth = 0
        }
        
    }
    
    @IBAction func stopBtnTapped(_ sender: UIButton) {
        if sender.titleLabel!.text == "타이머 시작하기" {
            startTimer()
            isTimerStop(sender, false)
        } else {
            isTimerStop(sender, true)
            
            let remainMin = String(describing: (60 - (self.timeCnt / 60) % 60))
            
            let vc = AlertViewController(mainMsg: "타이머를 멈출까요?", subMsg: "보너스 티켓까지 앞으로\n\(remainMin)분 남았어요", btnTitle: "멈춤", isTimer: true, isLogout: false, studyRemove: false, passMode: false)
            vc.modalPresentationStyle = .overFullScreen
            timer?.invalidate()
            present(vc, animated: true)
        }
        
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        if self.stopBtn.titleLabel!.text == "타이머 시작하기" {
            startTimer()
            isTimerStop(self.stopBtn, false)
        } else {
            isTimerStop(self.stopBtn, true)
            
            let remainMin = String(describing: (60 - (self.timeCnt / 60) % 60))
            
            let vc = AlertViewController(mainMsg: "타이머를 멈출까요?", subMsg: "보너스 티켓까지 앞으로\n\(remainMin)분 남았어요", btnTitle: "멈춤", isTimer: true, isLogout: false, studyRemove: false, passMode: false)
            vc.modalPresentationStyle = .overFullScreen
            timer?.invalidate()
            present(vc, animated: true)
        }
    }
    
    deinit {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
}


extension TimerViewController {
    func showRecord(result : ShowRecordEntity) {
        self.dismissIndicator()
        self.recordDataLst = result
        
        print("result = \(result)")
        guard let rest = recordDataLst?.rest else { return }
        guard let rcrd = recordDataLst?.recordedTime else { return }
        
        self.restCntLbl.text = "\(String(describing: self.restCnt))회"
        self.prevRcrd = rcrd
        self.restCnt = rest
    }
}
