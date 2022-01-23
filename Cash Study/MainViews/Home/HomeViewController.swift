//
//  HomeViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addStudyBtn: UIButton!
    @IBOutlet weak var studyLstCV: UICollectionView!
    @IBOutlet weak var studyLstCVHeight: NSLayoutConstraint!
    @IBOutlet weak var studyLstCVBtConstraint: NSLayoutConstraint!
    @IBOutlet weak var rprDdayCV: UICollectionView!
    
    
    var haveRprDday : Bool = false
    var todayStudyLst : ShowDateStudyEntity?
    var representDday : ShowDdayEntity?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setGradation()
        
        rprDdayCV?.delegate = self
        rprDdayCV?.dataSource = self
        studyLstCV?.delegate = self
        studyLstCV?.dataSource = self
        
        rprDdayCV.backgroundColor = UIColor.mainNavy.withAlphaComponent(0.0)
        rprDdayCV.register(UINib(nibName: "HaveRprDdayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "rprDdayCell")
        rprDdayCV.register(UINib(nibName: "EmptyDdayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "emptyDdayCell")
        
        studyLstCV.backgroundColor = UIColor.mainNavy.withAlphaComponent(0.0)
        studyLstCV.register(UINib(nibName: "HaveStudyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "haveCell")
        studyLstCV.register(UINib(nibName: "EmptyStudyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "emptyCell")
        
        if let collectionViewLayout = studyLstCV.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }

    
    override func viewDidLayoutSubviews() {
        self.changeHeight()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let td = DateFormatter()
        td.dateFormat = "yyyy-MM-dd"
        showIndicator()
        ShowDateStudyDataManager().homeStudy(date: td.string(from: Date()), viewController: self)
        
        ShowDdayDataManager().showHomeDday(viewController: self)
        studyLstCV.setNeedsDisplay()
        studyLstCV.setNeedsLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addStudy(_:)), name: NSNotification.Name("reloadHome"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(homeAddDdayReload(_:)), name: NSNotification.Name("homeAddDdayReload"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("reloadHome"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("homeAddDdayReload"), object: nil)
    }
    
    
    // MARK: - Custom Method
    func setUI() {
        addStudyBtn.layer.borderColor = UIColor.myGray.cgColor
        addStudyBtn.layer.borderWidth = 1
        addStudyBtn.layer.cornerRadius = addStudyBtn.frame.height / 2
    }
    
    @IBAction func moveAddStudyBtn(_ sender: Any) {
        let vc = AddStudyViewController(stGrId: 0, stSchId: 0, title: "", startAtTxt: "", endAtTxt: "", isEdit: false, isRepeat: false)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func addStudy(_ noti: Notification) {
        changeRootVC(BaseTabBarController())
        let td = DateFormatter()
        td.dateFormat = "yyyy-MM-dd"
        showIndicator()
        ShowDateStudyDataManager().homeStudy(date: td.string(from: Date()), viewController: self)
    }
    
    @objc func homeAddDdayReload(_ noti: Notification) {
        changeRootVC(BaseTabBarController())
    }
    
}


// MARK: - Collection View
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.studyLstCVHeight.constant = self.studyLstCV.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == studyLstCV {
            if todayStudyLst?.studies != nil && todayStudyLst!.studies.count > 0 {
                guard let titleTxt = todayStudyLst?.studies[indexPath.row].title else { return }
                guard let stId = todayStudyLst?.studies[indexPath.row].studyId else { return }
                
                let vc = TimerViewController(title: titleTxt, stId: stId)
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true, completion: nil)
            }
        } else {
            if representDday == nil || (representDday?.ddays.count)! <= 0 || representDday?.ddays[0].isRepresentative == false {
                /// 디데이 메인으로 이동
                /// 탭바 Index 바꾸기
                Constant.VC_MOVE = true
                self.tabBarController?.selectedIndex = 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == studyLstCV {
            if todayStudyLst?.studies != nil && todayStudyLst!.studies.count >= 1{
                return todayStudyLst!.studies.count
            } else {
                return 1
            }
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // MARK: 대표 디데이 Cell
        if collectionView == rprDdayCV {
            if representDday != nil {
                if (representDday?.ddays.count)! >= 1 && representDday?.ddays[0].isRepresentative == true {
                    /// 대표 디데이가 있을 때
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rprDdayCell", for: indexPath) as? HaveRprDdayCollectionViewCell else { return UICollectionViewCell() }
                    
                    let endAt = String(describing: (representDday?.ddays[indexPath.row].endAt)!)
                    cell.configure(with: endAt)
                    
                    cell.layer.cornerRadius = 8
                    cell.titleLbl.text = representDday?.ddays[indexPath.row].title
                    
                    return cell
                } else {
                    /// 대표 디데이가 없을 때
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyDdayCell", for: indexPath) as? EmptyDdayCollectionViewCell else { return UICollectionViewCell() }

                    cell.layer.borderColor = UIColor.homeBorderColor.cgColor
                    cell.backgroundColor = UIColor.mainNavy.withAlphaComponent(0.0)
                    cell.layer.borderWidth = 1
                    cell.layer.cornerRadius = 8

                    return cell
                }
            } else {
                /// 대표 디데이가 없을 때
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyDdayCell", for: indexPath) as? EmptyDdayCollectionViewCell else { return UICollectionViewCell() }

                cell.layer.borderColor = UIColor.homeBorderColor.cgColor
                cell.backgroundColor = UIColor.mainNavy.withAlphaComponent(0.0)
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8

                return cell
            }
        }
        
        // MARK: 오늘 해야할 공부 Cell
        else {
            if todayStudyLst?.studies == nil || todayStudyLst!.studies.count == 0 {
                /// 공부가 없을 때
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath) as? EmptyStudyCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.cornerRadius = 8
                cell.layer.borderWidth = 1
                cell.layer.borderColor = UIColor.homeBorderColor.cgColor
                
                return cell
                
            } else {
                /// 공부가 있을 때
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "haveCell", for: indexPath) as? HaveStudyCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.cornerRadius = 8
                cell.backgroundColor = UIColor.studyCellBgColor
                
                cell.nameLbl.text = todayStudyLst?.studies[indexPath.row].title
                
                if todayStudyLst?.studies[indexPath.row].recordedTime != 0 {
                    let time = todayStudyLst?.studies[indexPath.row].recordedTime
                    let hour = time! / 3600
                    let min = (time! / 60) % 60
                    let sec = time! % 60
                    
                    if time! < 60 {
                        let timeTxt = "\(sec)초"
                        let restCnt = todayStudyLst?.studies[indexPath.row].rest
                        let changeText = "측정시간 \(timeTxt) • 휴식횟수 \(String(describing: restCnt!))회"
                        cell.subLbl.text = changeText
                        
                    } else if time! >= 60 && time! < 3600 {
                        let timeTxt = "\(min)분 \(sec)초"
                        let restCnt = todayStudyLst?.studies[indexPath.row].rest
                        let changeText = "측정시간 \(timeTxt) • 휴식횟수 \(String(describing: restCnt!))회"
                        cell.subLbl.text = changeText
                        
                    } else {
                        let timeTxt = "\(hour)시간 \(min)분 \(sec)초"
                        let restCnt = todayStudyLst?.studies[indexPath.row].rest
                        let changeText = "측정시간 \(timeTxt) • 휴식횟수 \(String(describing: restCnt!))회"
                        cell.subLbl.text = changeText
                    }
                    
                    cell.subLbl.textColor = UIColor.link
                } else {
                    cell.subLbl.textColor = UIColor.cancleAlertColor
                    cell.subLbl.text = "측정된 공부시간이 없습니다"
                }
                
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.872
        
        if collectionView == rprDdayCV {
            return CGSize(width: width, height: 92)
        } else {
            if todayStudyLst?.studies == nil || todayStudyLst!.studies.count == 0  {
                let height = width * 0.685015290519878
                return CGSize(width: width, height: height)
            } else {
                return CGSize(width: width, height: 98)
            }
        }
    }
}

// MARK: - Get Data
extension HomeViewController {
    func homeStudy(result : ShowDateStudyEntity) {
        dismissIndicator()
        var totalTime : Int = 0
        
        self.todayStudyLst = result
        self.studyLstCV.reloadData()
        
        todayStudyLst?.studies.forEach {
            totalTime += $0.recordedTime
        }
        
        if totalTime == 0 {
            self.topLbl.text = "\(result.nickname)님의\n공부를 응원합니다!"
        } else {
            let sec = String(describing: totalTime % 60 )
            let min = String(describing: (totalTime / 60) % 60 )
            let hour = String(describing: totalTime / 3600)
            
            if totalTime < 60 {
                let text = "\(result.nickname)님,\n\(sec)초 공부했어요"
                let atrbuteString = NSMutableAttributedString(string: text)
                atrbuteString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.homeTimeTxtColor, range: (text as NSString).range(of: "\(sec)초"))
                self.topLbl.attributedText = atrbuteString
                
            } else if totalTime >= 60 && totalTime < 3600 {
                let text = "\(result.nickname)님,\n\(min)분 \(sec)초 공부했어요"
                let atrbuteString = NSMutableAttributedString(string: text)
                atrbuteString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.homeTimeTxtColor, range: (text as NSString).range(of: "\(min)분 \(sec)초"))
                self.topLbl.attributedText = atrbuteString
                
            } else {
                let text = "\(result.nickname)님,\n\(hour)시간 \(min)분 \(sec)초 공부했어요"
                let atrbuteString = NSMutableAttributedString(string: text)
                atrbuteString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.homeTimeTxtColor, range: (text as NSString).range(of: "\(hour)시간 \(min)분 \(sec)초"))
                self.topLbl.attributedText = atrbuteString
            }
        }
    }
    
    func showRepresentDday(result : ShowDdayEntity) {
        self.representDday = result
        self.rprDdayCV.reloadData()

        if representDday != nil {
            var idx : Int = 0
            for i in 0..<representDday!.ddays.count {
                if representDday?.ddays[i].isRepresentative == true {
                    idx = i
                }
            }
            if (representDday?.ddays.count)! >= 1 {
                guard let data = representDday?.ddays[idx] else { return }
                representDday?.ddays.insert(data, at: 0)
            }
        }
    }
}
