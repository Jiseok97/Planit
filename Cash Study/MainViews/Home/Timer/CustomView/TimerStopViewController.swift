//
//  TimerStopViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/08.
//

import UIKit
import MSCircularSlider

class TimerStopViewController: UIViewController {
    
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
    var restCnt : Int = 0
    var rewardCnt : Int = 0
    var bonusCnt : Int = 0
    
    var timer : Timer?
    var timeCnt : Int = 0
    
    init(title: String) {
        self.studyTitle = title
        
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
    
    

    // MARK: Functions
    func setUI() {
        self.startTimer()
        self.studyTitleLbl.text = studyTitle
        
        self.circleView.backgroundColor = UIColor.circleBgColor.withAlphaComponent(0.0)
        self.circleView.layer.zPosition = 999
        self.circleView._maximumRevolutions = 24
        self.circleView._currentValue = 0.0
        
        self.circleBgView.layer.cornerRadius = circleBgView.bounds.width / 2
        self.circleBgView.clipsToBounds = true
        self.circleBgView.layer.zPosition = 0
        
        self.restCntView.layer.cornerRadius = restCntView.frame.height / 2
        self.rewardView.layer.cornerRadius = rewardView.frame.height / 2
        self.bonusView.layer.cornerRadius = bonusView.frame.height / 2
        self.stopBtn.layer.cornerRadius = stopBtn.frame.height / 2
        
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
            print("current Value = \(self.circleView._currentValue)")
            print("maximum Value = \(self.circleView._maximumValue)")
                        
            if self.circleView._currentValue >= 3599.9 {
                self.circleView._currentValue = 0.0
            }
                
            DispatchQueue.main.async {
                let timeString = self.makeTimeLabel(count: self.timeCnt)
                self.timerLbl.text = timeString
            }
        })
    }
    
    
    @IBAction func stopBtnTapped(_ sender: Any) {
        // 타이머 멈추기 커스텀 뷰
//        timer?.invalidate()
        self.circleView._currentValue = 0.0
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
