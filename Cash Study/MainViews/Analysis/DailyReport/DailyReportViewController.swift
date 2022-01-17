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
    @IBOutlet weak var dateLblVertical: NSLayoutConstraint!
    
    var selectedDate : String = ""
    var reportDataLst : DailyReportEntity?
    var mostStudyIdx : DailyReportEntity?
    var isDoneCnt : Int = 0
    var totalStudiesCnt : Int = 0
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
        studyAnalysisCV.register(UINib(nibName: "MostStudyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mostStudyCell")
        studyAnalysisCV.register(UINib(nibName: "OverallTimeLineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "timelineCell")
        
        if let collectionViewLayout = studyAnalysisCV.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.changeHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        DailyReportDataManager().showDailyReport(date: df.string(from: Date()), viewController: self)
        
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
            DailyReportDataManager().showDailyReport(date: selectedDate, viewController: self)
        } else {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            showIndicator()
            DailyReportDataManager().showDailyReport(date: selectedDate, viewController: self)
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
        if reportDataLst != nil {
            if reportDataLst?.reports.count != 0 {
                return 3
            } else {
                return 1
            }
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if reportDataLst != nil {
            // 서버에서 데이터를 잘 받았을 경우
            
            if reportDataLst?.reports.count != 0 {
                // 측정한 공부가 있는 경우
                if indexPath.row == 0 {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mostStudyCell", for: indexPath) as? MostStudyCollectionViewCell else { return UICollectionViewCell() }

                    let time = (mostStudyIdx?.reports[indexPath.row].recordedTime)!
                    let sec = String(describing: time % 60 )
                    let min = String(describing: (time / 60) % 60 )
                    let hour = String(describing: time / 3600)
                    
                    if time < 60 {
                        cell.recordTimeLbl.text = "\(sec)초"
                    } else if time >= 60 && time < 3600 {
                        cell.recordTimeLbl.text = "\(min)분 \(sec)초"
                    } else {
                        cell.recordTimeLbl.text = "\(hour)시간 \(min)분 \(sec)초"
                    }
                    
                    cell.studyNameLbl.text = mostStudyIdx?.reports[indexPath.row].title
                    
                    return cell
                    
                } else if indexPath.row == 1 {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timelineCell", for: indexPath) as? OverallTimeLineCollectionViewCell else { return UICollectionViewCell() }

                    cell.configure(with: reportDataLst!)
                    
                    return cell
                } else {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as? AchievementRateCollectionViewCell else { return UICollectionViewCell() }
                    
                    cell.studyCntLbl.text = "\(isDoneCnt)/\(totalStudiesCnt)"
                    cell.rateLbl.text = "\(100 / totalStudiesCnt * isDoneCnt)%"
                    cell.progressBar.progress = Float(Double(100 / totalStudiesCnt * isDoneCnt) * 0.01)
                    
                    return cell
                }
            } else {
                // 측정한 공부가 없는 경우
                if reportDataLst!.totalStudies == 0 {
                    // 측정한 공부 + 계획한 공부 둘 다 없는 경우
                    
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyReportCell", for: indexPath) as? EmptyReportCollectionViewCell else { return UICollectionViewCell() }
                    
                    cell.layer.borderColor = UIColor.homeBorderColor.cgColor
                    cell.layer.borderWidth = 0.8
                    cell.layer.cornerRadius = 8
                    
                    return cell
                    
                } else {
                    // 측정한 공부는 없지만 공부 계획은 있는 경우
                    
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as? AchievementRateCollectionViewCell else { return UICollectionViewCell() }
                    
                    cell.studyCntLbl.text = "\(isDoneCnt)/\(totalStudiesCnt)"
                    cell.rateLbl.text = "\(100 / totalStudiesCnt * isDoneCnt)%"
                    cell.progressBar.progress = Float(Double(100 / totalStudiesCnt * isDoneCnt) * 0.01)
                    
                    return cell
                }
            }
        } else {
            // 서버에서 데이터를 못 받아 nil
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyReportCell", for: indexPath) as? EmptyReportCollectionViewCell else { return UICollectionViewCell() }
            
            cell.layer.borderColor = UIColor.homeBorderColor.cgColor
            cell.layer.borderWidth = 0.8
            cell.layer.cornerRadius = 8
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.studyAnalysisCV.frame.width
        
        if reportDataLst?.reports.count != 0 {
            /// 모두 보여질 때
            switch indexPath.row {
            case 0:
                return CGSize(width: width, height: 157)

            case 1:
                if reportDataLst?.reports.count == 1 {
                    return CGSize(width: width, height: 157)
                } else if reportDataLst?.reports.count == 2 {
                    return CGSize(width: width, height: 216)
                } else {
                    return CGSize(width: width, height: 333)
                }

            default:
                return CGSize(width: width, height: 130)
            }
            
        } else {
            /// 아무 데이터도 없을 때
            return CGSize(width: width, height: 116)
        }
    }
    
}

extension DailyReportViewController {
    func showDailyReport(result: DailyReportEntity) {
        dismissIndicator()
        self.mostStudyIdx = result
        self.reportDataLst = result
        self.studyAnalysisCV.reloadData()
        mostStudyIdx?.reports.sort{ $0.recordedTime > $1.recordedTime }
        
        var totalTime : Int = 0
        
        result.reports.forEach {
            totalTime += $0.recordedTime
        }
        
        self.totalRecordedTime = totalTime
        self.isDoneCnt = result.doneStudies
        self.totalStudiesCnt = result.totalStudies
        
        if totalTime == 0 {
            self.timeLbl.text = "타이머 측정 시간이 없습니다"
        } else {
            let sec = String(describing: totalTime % 60 )
            let min = String(describing: (totalTime / 60) % 60 )
            let hour = String(describing: totalTime / 3600)
            
            if totalTime < 60 {
                self.timeLbl.text = "\(sec)초 공부했어요"
            } else if totalTime >= 60 && totalTime < 3600 {
                self.timeLbl.text = "\(min)분 \(sec)초 공부했어요"
            } else {
                self.timeLbl.text = "\(hour)시간 \(min)분 \(sec)초 공부했어요"
            }
        }
        
    }
}
