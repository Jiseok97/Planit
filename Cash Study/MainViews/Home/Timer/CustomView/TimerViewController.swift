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

        setUI()
        ShowRecordDataManager().showRecord(stId: self.stId, viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showAlert()
        if self.recordDataLst != nil {
            self.restCntLbl.text = "\(String(describing: recordDataLst?.rest))회"
            self.rewardCntLbl.text = String(describing: recordDataLst?.star)
            self.bonusCntLbl.text = String(describing: recordDataLst?.bonusTicket)
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
        let vc = ObAlertViewController(mainMsg: "기기의 홈버튼을 이용해서\n앱을 나가면 타이머 측정이\n자동으로 멈추게 돼요.",
                                       subMsg: "앱을 유지해주세요",
                                       btnTitle: "공부시간 측정 시작하기",
                                       isTimer: true)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func timerStop(_ noti: Notification) {
        // 가지고 갈 것
        // 시간, 쉬는 횟수, 리워드, 보너스
        guard let star = Int(self.rewardCntLbl.text!) else { return }
        guard let bonus = Int(self.bonusCntLbl.text!) else { return }
        let totalRcrd = self.prevRcrd + self.timeCnt
        
        timer?.invalidate()
        let stvc = StopTimerViewController(stId: stId, title: self.studyTitle, totalRcrd: totalRcrd, additionalRcrd: self.timeCnt, starCnt: star, bonusCnt: bonus, restCnt: self.restCnt, isEdit: false)
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
            self.timeCnt += 1
            self.circleView._currentValue += 1
            if self.circleView._currentValue > 3599.9 {
                self.circleView._currentValue = 0.0
            }
                
            DispatchQueue.main.async {
                let timeString = self.makeTimeLabel(count: self.timeCnt)
                self.timerLbl.text = timeString
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
            
            let vc = AlertViewController(mainMsg: "타이머를 멈출까요?", subMsg: "보너스 티켓까지 앞으로\n\(remainMin)분 남았어요", btnTitle: "멈춤", isTimer: true)
            vc.modalPresentationStyle = .overFullScreen
            timer?.invalidate()
            present(vc, animated: true)
        }
        
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


extension TimerViewController {
    func showRecord(result : ShowRecordEntity) {
        self.recordDataLst = result
        
        guard let reward = recordDataLst?.star else { return }
        guard let bonus = recordDataLst?.bonusTicket else { return }
        guard let rest = recordDataLst?.rest else { return }
        guard let rcrd = recordDataLst?.recordedTime else { return }
        
        self.rewardCntLbl.text = String(describing: reward)
        self.restCntLbl.text = "\(String(describing: self.restCnt))회"
        self.bonusCntLbl.text = String(describing: bonus)
        self.prevRcrd = rcrd
        self.restCnt = rest
    }
}
