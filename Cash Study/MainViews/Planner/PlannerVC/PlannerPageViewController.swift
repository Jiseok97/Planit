//
//  PlannerPageViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/09.
//

import UIKit
import FSCalendar

class PlannerPageViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var calendarViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var changeScopeCalendar: UIButton!
    @IBOutlet weak var changeScopeCalendarView: UIView!
    @IBOutlet weak var changeScopeCalendarViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var studyCV: UICollectionView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgViewHeight: NSLayoutConstraint!
    
    var selectedDate : String = ""
    var studyDataLst : ShowDateStudyEntity?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCalendar()
        setUI()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        studyCV.delegate = self
        studyCV.dataSource = self
        studyCV.backgroundColor = UIColor.mainNavy.withAlphaComponent(0.0)
        studyCV.register(UINib(nibName: "NoStudyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "noStudyCell")
        studyCV.register(UINib(nibName: "StudyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "studyCell")
        studyCV.register(UINib(nibName: "RepeatStudyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "repeatStudyCell")
        
        if let collectionViewLayout = studyCV.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        self.changeHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        ShowDateStudyDataManager().showStudy(date: dateFormatter.string(from: Date()), viewController: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadStudy(_:)), name: NSNotification.Name("reloadStudy"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectToday(_:)), name: NSNotification.Name("selectToday"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("reloadStudy"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("selectToday"), object: nil)
    }
    
    
    // MARK: Function
    func setUI() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        showIndicator()
        ShowDateStudyDataManager().showStudy(date: dateFormatter.string(from: Date()), viewController: self)
        
        self.changeScopeCalendar.setTitle("", for: .normal)
        self.changeScopeCalendarView.layer.cornerRadius = 16
        self.changeScopeCalendarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        if let collectionViewLayout = studyCV.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }

    
    func setCalendar() {
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.scope = .week
        
        calendarView.appearance.headerDateFormat = "YYYY년 MM월"
        calendarView.appearance.headerTitleColor = UIColor.link
        calendarView.appearance.headerTitleAlignment = .left
        calendarView.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 16)
        calendarView.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendarView.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendarView.appearance.titleTodayColor = UIColor(red: 220/225, green: 185/225, blue: 45/225, alpha: 1.0)
        calendarView.appearance.todayColor = UIColor.mainNavy.withAlphaComponent(0.0)
        calendarView.placeholderType = .none
        
        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .horizontal
        
        if UIScreen.main.bounds.width < 400 {
            calendarView.appearance.headerTitleOffset = CGPoint(x: calendarView.frame.origin.x - 85 , y: calendarView.frame.origin.y)
        } else {
            calendarView.appearance.headerTitleOffset = CGPoint(x: calendarView.frame.origin.x - 95 , y: calendarView.frame.origin.y)
        }
        
        calendarView.layer.zPosition = 999
        changeScopeCalendarView.layer.zPosition = 999
        bgView.layer.zPosition = 0
        bgView.backgroundColor = .studyCellBgColor
        changeScopeCalendarView.backgroundColor = .studyCellBgColor
        
    }
    
    
    @objc func selectToday(_ noti: Notification) {
        self.calendarView.select(Date())
    }
    
    @objc func reloadStudy(_ noti : Notification) {
//        let df = DateFormatter()
//        df.dateFormat = "yyyy-MM-dd"
//        showIndicator()
//        ShowDateStudyDataManager().showStudy(date: df.string(from: Date()), viewController: self)
//        studyCV.reloadData()
        
        changeRootVC(BaseTabBarController())
    }
    
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarViewHeight.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    
    @IBAction func chageCalendarScope(_ sender: Any) {

        if self.calendarView.scope == .week {
            self.calendarView.scope = .month
            self.calendarViewHeight.constant = view.frame.height * 0.49
            self.changeScopeCalendar.setImage(UIImage(named: "upArrow"), for: .normal)
        } else {
            if UIScreen.main.bounds.height < 812 {
                self.calendarViewHeight.constant = view.frame.height * 0.253349753694581
            } else {
                self.calendarViewHeight.constant = view.frame.height * 0.213349753694581
            }
            self.calendarView.scope = .week
            self.changeScopeCalendar.setImage(UIImage(named: "downArrow"), for: .normal)
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.appearance.titleFont = UIFont(name: "NotoSansKR-Bold", size: 14)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        showIndicator()
        ShowDateStudyDataManager().showStudy(date: dateFormatter.string(from: date), viewController: self)
    }
    
}


extension PlannerPageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UserCheckisDoneDelegate {
    
    func checkBoxTrue(stId: Int) {
        showIndicator()
        EditStudyStatusDataManager().editStatus(stId: stId, isDone: true, viewController: self)
    }
    
    func checkBoxFalse(stId: Int) {
        showIndicator()
        EditStudyStatusDataManager().editStatus(stId: stId, isDone: false, viewController: self)
    }
    
    func changeHeight() {
        self.cvHeight.constant = self.studyCV.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if studyDataLst?.studies != nil && studyDataLst!.studies.count >= 1{
            return studyDataLst!.studies.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if studyDataLst?.studies != nil && studyDataLst!.studies.count != 0 {
            if studyDataLst?.studies[indexPath.row].repeatedDays == nil {
                /// 반복 공부가 아닐 때
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studyCell", for: indexPath) as? StudyCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.cornerRadius = 8
                cell.backgroundColor = .studyCellBgColor
                cell.titleLbl.text = studyDataLst?.studies[indexPath.row].title
                
                cell.studyId = studyDataLst!.studies[indexPath.row].studyId
                cell.cellDelegate = self
                
                if studyDataLst?.studies[indexPath.row].isDone == true {
                    cell.checkBox.isSelected = true
                } else {
                    cell.checkBox.isSelected = false
                }
                
                return cell
            } else {
                /// 반복 공부 일 때
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "repeatStudyCell", for: indexPath) as? RepeatStudyCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.cornerRadius = 8
                cell.backgroundColor = .studyCellBgColor
                
                let startTxt = studyDataLst?.studies[indexPath.row].startAt.replacingOccurrences(of: "-", with: ".")
                let endTxt = studyDataLst?.studies[indexPath.row].endAt.replacingOccurrences(of: "-", with: ".")
                
                cell.titleLbl.text = studyDataLst?.studies[indexPath.row].title
                cell.repeatLbl.text = "\(String(describing: startTxt!))~\(String(describing: endTxt!))"
                
                cell.studyId = studyDataLst!.studies[indexPath.row].studyId
                cell.cellDelegate = self
                
                if studyDataLst?.studies[indexPath.row].isDone == true {
                    cell.checkBoxBtn.isSelected = true
                } else {
                    cell.checkBoxBtn.isSelected = false
                }
                
                return cell
            }
        } else {
            /// 공부 계획이 없을 때
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noStudyCell", for: indexPath) as? NoStudyCollectionViewCell else { return UICollectionViewCell() }
            
            cell.layer.borderColor = UIColor.homeBorderColor.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if studyDataLst?.studies != nil && (studyDataLst?.studies.count)! > 0 {
            guard let data = studyDataLst?.studies[indexPath.row] else { return }
            
            let date = DateFormatter()
            date.locale = Locale(identifier: "ko_KR")
            date.dateFormat = "yyyy-MM-dd"
            
            guard let startAtTxt = date.date(from: data.startAt) else { return }
            
            let df = DateFormatter()
            df.locale = Locale(identifier: "ko_KR")
            df.dateFormat = "yyyy년 MM월 dd일 (E)"
            
            if data.repeatedDays != nil {
                guard let endAtTxt = date.date(from: data.endAt) else { return }
                Constant.START_AT = data.startAt
                Constant.END_AT = data.endAt
                let vc = AddStudyViewController(stGrId: data.studyGroupId, stSchId: data.studyScheduleId, title: data.title, startAtTxt: df.string(from: startAtTxt), endAtTxt: df.string(from: endAtTxt), isEdit: true, isRepeat: true)
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true)
            } else {
                let vc = AddStudyViewController(stGrId: data.studyGroupId, stSchId: data.studyScheduleId, title: data.title, startAtTxt: df.string(from: startAtTxt), endAtTxt: "", isEdit: true, isRepeat: false)
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true)
            }
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = self.studyCV.frame.width
        if studyDataLst?.studies == nil || studyDataLst!.studies.count == 0 {
            /// 오늘 해야할 공부가 없을 때
            let height = CGFloat(116)
            return CGSize(width: width, height: height)
        } else {
            /// 오늘 해야할 공부가 있을 때
            let height = self.view.bounds.height * 0.1359
            return CGSize(width: width, height: height)
        }
    }
    
}

extension PlannerPageViewController {
    func showStudy(result : ShowDateStudyEntity) {
        self.dismissIndicator()
        self.studyDataLst = result
        self.studyCV.reloadData()
        
    }
}
