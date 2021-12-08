//
//  DailyReportViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/06.
//

import UIKit

class DailyReportViewController: UIViewController {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var studyAnalysisCV: UICollectionView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    
    var selectedDate : String = ""
    var studyDataLst : ShowDateStudyEntity?
    var isDoneCnt : Int = 0
    var totalRecordedTime : Int = 0
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let df = DateFormatter()
        df.dateFormat = "yyyy년 MM월 dd일"
        self.dateBtn.setTitle(df.string(from: Date()), for: .normal)

        studyAnalysisCV.delegate = self
        studyAnalysisCV.dataSource = self
        studyAnalysisCV.backgroundColor = .mainNavy.withAlphaComponent(0.0)
        studyAnalysisCV.register(UINib(nibName: "EmptyReportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "emptyReportCell")
        studyAnalysisCV.register(UINib(nibName: "AchievementRateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "achievementCell")
        
        if let collectionViewLayout = studyAnalysisCV.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    override func viewDidLayoutSubviews() {
        self.changeHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        ShowDateStudyDataManager().showStudyReport(date: df.string(from: Date()), viewController: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reportDate(_:)), name: NSNotification.Name("reportDate"), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("reportDate"), object: nil)
    }


    // MARK: Functions
    @objc func reportDate(_ noti: Notification) {
        if Constant.DATE != "" {
            let txt = Constant.DATE_TEXT
            self.dateBtn.setTitle(txt, for: .normal)
            self.selectedDate = Constant.DATE
            showIndicator()
            ShowDateStudyDataManager().showStudyReport(date: selectedDate, viewController: self)
        } else {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            showIndicator()
            ShowDateStudyDataManager().showStudyReport(date: selectedDate, viewController: self)
        }
    }
    
    @IBAction func showCalendarTapped(_ sender: Any) {
        let vc = CalendarAlertViewController(isEnd: false, checkDday: false, isReport: true)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }

}


extension DailyReportViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.cvHeight.constant = self.studyAnalysisCV.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if studyDataLst?.studies != nil && studyDataLst!.studies.count > 0 {
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if studyDataLst?.studies != nil {
            if studyDataLst!.studies.count > 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as? AchievementRateCollectionViewCell else { return UICollectionViewCell() }
                
                cell.studyCntLbl.text = "\(isDoneCnt)/\(studyDataLst!.studies.count)"
                cell.rateLbl.text = "\(100 / studyDataLst!.studies.count * isDoneCnt)%"
                cell.progressBar.progress = Float(Double(100 / studyDataLst!.studies.count * isDoneCnt) * 0.01)
                
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyReportCell", for: indexPath) as? EmptyReportCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.borderColor = UIColor.homeBorderColor.cgColor
                cell.layer.borderWidth = 0.8
                cell.layer.cornerRadius = 8
                
                return cell
            }
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyReportCell", for: indexPath) as? EmptyReportCollectionViewCell else { return UICollectionViewCell() }
            
            cell.layer.borderColor = UIColor.homeBorderColor.cgColor
            cell.layer.borderWidth = 0.8
            cell.layer.cornerRadius = 8
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if studyDataLst?.studies != nil {
            let width = self.studyAnalysisCV.frame.width
            let height = self.view.frame.height * 0.2142
            
            return CGSize(width: width, height: height)
        } else {
            let width = self.studyAnalysisCV.bounds.width * 0.88
            let height = self.view.frame.height * 0.157857142857143
            
            return CGSize(width: width, height: height)
        }
    }
    
}


extension DailyReportViewController {
    func showStudyReport(result: ShowDateStudyEntity) {
        dismissIndicator()
        var totalTime : Int = 0
        var isDoneCount : Int = 0
        self.studyDataLst = result
        self.studyAnalysisCV.reloadData()
        
        studyDataLst?.studies.forEach {
            totalTime += $0.recordedTime
            if $0.isDone == true {
                isDoneCount += 1
            }
        }
        self.totalRecordedTime = totalTime
        self.isDoneCnt = isDoneCount
        
        if totalTime == 0 {
            self.timeLbl.text = "타이머 측정 시간이 없습니다"
        } else {
            let sec = String(describing: totalTime % 60 )
            let min = String(describing: (totalTime / 60) % 60 )
            let hour = String(describing: totalTime / 3600)
            self.timeLbl.text = "\(hour)시간 \(min)분 \(sec)초 공부했어요"
            if totalTime < 60 {
                self.timeLbl.text = "\(sec)초 공부했어요"
            } else if totalTime < 3600 {
                self.timeLbl.text = "\(min)분 \(sec)초 공부했어요"
            } else {
                self.timeLbl.text = "\(hour)시간 \(min)분 \(sec)초 공부했어요"
            }
        }
    }
}
