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
    
    var selectedDate : String = ""
    var studyDataLst : ShowDateStudyEntity?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradation()
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadStudy(_:)), name: NSNotification.Name("reloadStudy"), object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(<#T##@objc method#>), name: NSNotification.Name("finishedStudy"), object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(<#T##@objc method#>), name: NSNotification.Name("noFinishedStudy"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("reloadStudy"), object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("finishedStudy"), object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("noFinishedStudy"), object: nil)
    }
    
    
    // MARK: Function
    func setUI() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        ShowDateStudyDataManager().showStudy(date: dateFormatter.string(from: Date()), viewController: self)
        
        self.calendarView.layer.cornerRadius = 8
        self.changeScopeCalendar.setTitle("", for: .normal)
        self.calendarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.changeScopeCalendarView.layer.cornerRadius = 8
        self.changeScopeCalendarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.calendarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
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
        calendarView.placeholderType = .none
        
        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .horizontal
        calendarView.appearance.headerTitleOffset = CGPoint(x: -60, y: calendarView.frame.origin.y)
        
    }
    
    
    @objc func reloadStudy(_ noti : Notification) {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        ShowDateStudyDataManager().showStudy(date: df.string(from: Date()), viewController: self)
    }
    
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarViewHeight.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    
    @IBAction func chageCalendarScope(_ sender: Any) {

        if self.calendarView.scope == .week {
            self.calendarView.scope = .month
            self.calendarViewHeight.constant = view.frame.height * 0.48
            self.changeScopeCalendar.setImage(UIImage(named: "upArrow"), for: .normal)
        } else {
            self.calendarView.scope = .week
            self.calendarViewHeight.constant = view.frame.height * 0.193349753694581
            self.changeScopeCalendar.setImage(UIImage(named: "downArrow"), for: .normal)
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        calendar.appearance.titleFont = UIFont(name: "NotoSansKR-Bold", size: 14)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        ShowDateStudyDataManager().showStudy(date: dateFormatter.string(from: date), viewController: self)
    }
    
}


extension PlannerPageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.cvHeight.constant = self.studyCV.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if studyDataLst?.studies != nil {
            return studyDataLst!.studies.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if studyDataLst?.studies != nil {
            // if single || repeat
            if studyDataLst?.studies[indexPath.row].repeatedDays == nil {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studyCell", for: indexPath) as? StudyCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.cornerRadius = 8
                cell.backgroundColor = .studyCellBgColor
                
                cell.titleLbl.text = studyDataLst?.studies[indexPath.row].title
                
                if studyDataLst?.studies[indexPath.row].isDone == true {
                    cell.checkBox.isSelected = true
                } else {
                    cell.checkBox.isSelected = false
                }
                
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "repeatStudyCell", for: indexPath) as? RepeatStudyCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.cornerRadius = 8
                cell.backgroundColor = .studyCellBgColor
                
                let startTxt = studyDataLst?.studies[indexPath.row].startAt.replacingOccurrences(of: "-", with: ".")
                let endTxt = studyDataLst?.studies[indexPath.row].endAt.replacingOccurrences(of: "-", with: ".")
                
                cell.titleLbl.text = studyDataLst?.studies[indexPath.row].title
                cell.repeatLbl.text = "\(String(describing: startTxt!))~\(String(describing: endTxt!))"
                
                if studyDataLst?.studies[indexPath.row].isDone == true {
                    cell.checkBox.isSelected = true
                } else {
                    cell.checkBox.isSelected = false
                }
                
                
                return cell
            }
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noStudyCell", for: indexPath) as? NoStudyCollectionViewCell else { return UICollectionViewCell() }
            
            cell.layer.borderColor = UIColor.homeBorderColor.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = studyDataLst?.studies[indexPath.row] else { return }
        
        let vc = AddStudyViewController(stGrId: data.studyGroupId, stSchId: data.studyScheduleId, title: data.title, isEdit: true)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.studyCV.frame.width
        
        if studyDataLst?.studies != nil {
            if studyDataLst?.studies[indexPath.row].repeatedDays != nil {
                let height = self.view.bounds.height * 0.132
                return CGSize(width: width, height: height)
            } else {
                let height = self.view.bounds.height * 0.1289
                return CGSize(width: width, height: height)
            }
            
        } else {
            let height = self.view.bounds.height * 0.1487
            return CGSize(width: width, height: height)
        }
        
    }
    
}

extension PlannerPageViewController {
    func showStudy(result : ShowDateStudyEntity) {
        self.studyDataLst = result
        self.studyCV.reloadData()
        self.studyDataLst?.studies.sort { $0.startAt < $1.startAt }
    }
}
