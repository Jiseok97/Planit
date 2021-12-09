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
    var stId: Int = 0
    var isDone : Bool = false
    
    init(stId: Int, title: String, totalRcrd: Int, additionalRcrd: Int, starCnt: Int, bonusCnt: Int, restCnt: Int, isEdit: Bool) {
        self.stId = stId
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
        
        let totalRes = totalRcrd + additionalRcrd
        let sec = totalRes % 60
        let min = (totalRes / 60) % 60
        let hour = totalRes / 3600
        
        let aSec = self.additionalRcrd % 60
        let aMin = (self.additionalRcrd / 60) % 60
        let aHour = self.additionalRcrd / 3600
        
        if additionalRcrd < 60 {
            self.additionRecordTimeLbl.text = "(+\(aSec)초)"
        } else if additionalRcrd >= 60 && additionalRcrd < 3600 {
            self.additionRecordTimeLbl.text = "(+\(aMin)분 \(aSec)초)"
        } else {
            self.additionRecordTimeLbl.text = "(+\(aHour)시간 \(aMin)분 \(aSec)초)"
        }
        self.totalRecordTimeLbl.text = "\(hour)시간 \(min)분 \(sec)초"
        self.titleLbl.text = studyTitle
        self.restLbl.text = "휴식은 모두 \(String(describing: restCnt))회 쉬었어요"
        self.starCntLbl.text = String(describing: self.starCnt)
        self.bonusCntLbl.text = String(describing: self.bonusCnt)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showIndicator()
        ShowRecordDataManager().showRecordST(stId: stId, viewController: self)
        
        let vc = TimerAlertViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(putRecordDone(_:)), name: NSNotification.Name("PutRecordDone"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(putRecordNotDone(_:)), name: NSNotification.Name("PutRecordNotDone"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("PutRecordDone"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("PutRecordNotDone"), object: nil)
    }

    
    // MARK: Functions
    @objc func putRecordDone(_ noti: Notification) {
        
        if isDone {
           let vc = ObAlertViewController(mainMsg: "이미 완료한 공부는\n결과에 반영되지 않습니다", subMsg: "", btnTitle: "확인", isTimer: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
            
        } else {
            let input = PutRecordInput(isDone: true, star: starCnt, bonusTicket: bonusCnt, rest: restCnt, recordedTime: additionalRcrd)
            showIndicator()
            PutRecordDataManager().putRecord(input, stId: self.stId, viewController: self)
        }
    }
    
    @objc func putRecordNotDone(_ noti: Notification) {
        
        let input = PutRecordInput(isDone: false, star: starCnt, bonusTicket: bonusCnt, rest: restCnt, recordedTime: additionalRcrd)
        showIndicator()
        PutRecordDataManager().putRecord(input, stId: self.stId, viewController: self)
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        changeRootVC(BaseTabBarController())
    }

}

extension StopTimerViewController {
    func showRecordST(result: ShowRecordEntity) {
        self.dismissIndicator()
        self.isDone = result.isDone
    }
}
