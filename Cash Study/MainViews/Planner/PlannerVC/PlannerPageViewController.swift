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
    }

    
    func setCalendar() {
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.scrollEnabled = false
        calendarView.scope = .month
        
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
        calendarView.appearance.headerTitleColor = UIColor.link
        calendarView.appearance.headerTitleFont = UIFont.systemFont(ofSize: 16)
        
    }
    
    
    
    
    
    
    @IBAction func chageCalendarScope(_ sender: Any) {
        if self.calendarView.scope == FSCalendarScope.week {
            self.calendarView.scope = .month
//            self.calendarView.setScope(.month, animated: true)
            self.calendarViewHeight.constant = 0
        } else {
            self.calendarView.scope = .week
//            self.calendarView.setScope(.week, animated: true)
            self.calendarViewHeight.constant = view.safeAreaLayoutGuide.layoutFrame.size.height * -0.20
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
