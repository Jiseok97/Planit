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
    @IBOutlet weak var rewardCntLbl: UILabel!
    @IBOutlet weak var bonusCntLbl: UILabel!
    
    var studyTitle : String = ""
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    init(title: String) {
        self.studyTitle = title
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: Functions
    func setUI() {
        self.studyTitleLbl.text = studyTitle
        
        self.circleView.backgroundColor = UIColor.circleBgColor.withAlphaComponent(0.0)
        self.circleView.layer.zPosition = 999
        
        self.circleBgView.layer.cornerRadius = circleBgView.bounds.width / 2
        self.circleBgView.clipsToBounds = true
        self.circleBgView.layer.zPosition = 0
        
        self.restCntView.layer.cornerRadius = restCntView.frame.height / 2
        self.rewardView.layer.cornerRadius = rewardView.frame.height / 2
        self.bonusView.layer.cornerRadius = bonusView.frame.height / 2
        self.stopBtn.layer.cornerRadius = stopBtn.frame.height / 2
        
    }

    
    @IBAction func stopBtnTapped(_ sender: Any) {
        // 타이머 멈추기 커스텀 뷰
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
