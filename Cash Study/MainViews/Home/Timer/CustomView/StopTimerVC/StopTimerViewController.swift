//
//  StopTimerViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

import UIKit

class StopTimerViewController: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var restView: UIView!
    @IBOutlet weak var starView: UIView!
    @IBOutlet weak var bonusView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var totalRecordTimeLbl: UILabel!
    @IBOutlet weak var additionRecordTimeLbl: UILabel!
    @IBOutlet weak var restLbl: UILabel!
    @IBOutlet weak var starCntLbl: UILabel!
    @IBOutlet weak var bonusCntLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var studyTitle: String = ""
    var totalRcrd: Int = 0
    var additionalRcrd: Int = 0
    var starCnt: Int = 0
    var bonusCnt: Int = 0
    var restCnt: Int = 0
    var isEdit: Bool = false
    
    init(title: String, totalRcrd: Int, additionalRcrd: Int, starCnt: Int, bonusCnt: Int, restCnt: Int, isEdit: Bool) {
        self.studyTitle = title
        self.totalRcrd = totalRcrd
        self.additionalRcrd = additionalRcrd
        self.starCnt = starCnt
        self.bonusCnt = bonusCnt
        self.restCnt = restCnt
        self.isEdit = isEdit
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.firstView.layer.cornerRadius = 8
        self.restView.layer.cornerRadius = 8
        self.starView.layer.cornerRadius = 8
        self.bonusView.layer.cornerRadius = 8
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        
        let sec = self.totalRcrd % 60
        let min = (self.totalRcrd / 60) % 60
        let hour = self.totalRcrd / 3600
        
        self.additionRecordTimeLbl.text = "(+\(hour)시간 \(min)분)"
        self.titleLbl.text = studyTitle
        self.restLbl.text = "휴식은 모두 \(String(describing: restCnt))회 쉬었어요"
        self.starCntLbl.text = String(describing: self.starCnt)
        self.bonusCntLbl.text = String(describing: self.bonusCnt)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let vc = TimerAlertViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }

    
    // MARK: Function
    @IBAction func dismissBtn(_ sender: Any) {
        changeRootVC(BaseTabBarController())
    }
    

}
