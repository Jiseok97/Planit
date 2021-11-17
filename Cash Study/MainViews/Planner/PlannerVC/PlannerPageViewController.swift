//
//  PlannerPageViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/09.
//

import UIKit
import FSCalendar

class PlannerPageViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var calendarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var changeScopeCalendar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCalendar()
        setUI()
    }
    
    func setUI() {
        self.calendarView.layer.cornerRadius = 8
        self.changeScopeCalendar.setTitle("", for: .normal)
        
        self.calendarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.calendarView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    
    func setCalendar() {
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.scrollEnabled = false
        calendarView.scope = .month
        
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
        calendarView.appearance.headerTitleColor = UIColor.link
        calendarView.appearance.headerTitleAlignment = .left
        calendarView.appearance.headerTitleFont = UIFont(name: "NotoSansCJKkr-Medium", size: 16)
        calendarView.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendarView.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendarView.appearance.titleTodayColor = UIColor(red: 220/225, green: 185/225, blue: 45/225, alpha: 1.0)
        calendarView.placeholderType = .none
    }
    
    
    
    
    
    
    @IBAction func chageCalendarScope(_ sender: Any) {
        if self.calendarView.scope == .week {
            self.calendarView.scope = .month
            self.calendarViewHeight.constant = view.frame.height * 0.48
            
            
        } else {
            self.calendarView.scope = .week
            self.calendarViewHeight.constant = view.frame.height * 0.193349753694581
            
        }
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print("자체 날짜 \(dateFormatter.string(from: date))")
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        print("선택 해체 \(dateFormatter.string(from: date))")
    }
    
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarViewHeight.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    
}
//
//
//extension DdayPageViewController {
//    func showDday(result : ShowDdayEntity) {
//        self.DdayDataLst = result
//        self.dDayCV.reloadData()
//    }
//}
