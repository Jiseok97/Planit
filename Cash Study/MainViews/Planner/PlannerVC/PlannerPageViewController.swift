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
        
        if let collectionViewLayout = studyCV.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        self.changeHeight()
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studyCell", for: indexPath) as? StudyCollectionViewCell else { return UICollectionViewCell() }
            
            cell.layer.cornerRadius = 8
            cell.backgroundColor = UIColor.studyCellBgColor
            
            
            
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noStudyCell", for: indexPath) as? NoStudyCollectionViewCell else { return UICollectionViewCell() }
            
            cell.layer.borderColor = UIColor.homeBorderColor.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width * 0.872
        let height = self.view.bounds.height * 0.15
        
        return CGSize(width: width, height: height)
    }
    
}

extension PlannerPageViewController {
    func showStudy(result : ShowDateStudyEntity) {
        self.studyDataLst = result
        self.studyCV.reloadData()
    }
}
