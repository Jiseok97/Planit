//
//  CalendarAlertViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/25.
//

import UIKit
import FSCalendar

class CalendarAlertViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
//    let calendar = Calendar.current
//    var dateComponents = DateComponents()
    var selectedDate : String = ""
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setCalendar()
        
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    
    
    // MARK: Functions
    func setUI() {
        self.contentView.layer.cornerRadius = 20
        self.confirmBtn.layer.cornerRadius = self.confirmBtn.frame.height / 2
        
        self.prevBtn.layer.zPosition = 0
        self.nextBtn.layer.zPosition = 0
        self.nextBtn.isEnabled = false
        self.prevBtn.isEnabled = false
        self.nextBtn.isHidden = true
        self.prevBtn.isHidden = true
    }
    
    func setCalendar() {
        calendarView.locale = Locale(identifier: "ko_KR")
        
        calendarView.appearance.headerDateFormat = "YYYY년 MM월"
        calendarView.appearance.headerTitleColor = UIColor.link
        calendarView.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 18)
        calendarView.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendarView.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        calendarView.appearance.headerTitleOffset = CGPoint(x: 0, y: -12)
        calendarView.appearance.headerMinimumDissolvedAlpha = 1.0
        
        calendarView.appearance.titleTodayColor = UIColor(red: 220/225, green: 185/225, blue: 45/225, alpha: 1.0)
        calendarView.placeholderType = .none
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let differenceDF = DateFormatter()
        differenceDF.dateFormat = "yyyyMMdd"
        
        let selectedDate = differenceDF.string(from: date)
        let todayDate = differenceDF.string(from: Date())

        guard let sDate = Int(selectedDate) else { return }
        guard let tDate = Int(todayDate) else { return }

        if sDate < tDate {
            self.calendarView.appearance.selectionColor = UIColor.link.withAlphaComponent(0.0)
            calendar.deselect(date)
        } else {
            self.calendarView.appearance.selectionColor = UIColor.link
            self.selectedDate = dateFormatter.string(from: date)
        }
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("sendDate"), object: nil)
        Constant.START_DATE = self.selectedDate
        dismiss(animated: true, completion: nil)
    }
    
}




//    @IBAction func nextTapped(_ sender: UIButton) {
//        calendarView.setCurrentPage(getNextMonth(date: calendarView.currentPage), animated: true)
        
//        dateComponents.month = 1
//        self.calendarView.currentPage = calendar.date(byAdding: dateComponents, to: self.calendarView.currentPage)!
        
        
//        let currentDay = calendarView.currentPage
//        var components = DateComponents()
//        let calendar = Calendar(identifier: .gregorian)
//        components.month = 1
//        let nextDay = calendar.date(byAdding: components, to: currentDay)!
//        calendarView.setCurrentPage(nextDay, animated: true)
        
//    }

//    @IBAction func previousTapped(_ sender: UIButton) {
//        calendarView.setCurrentPage(getPreviousMonth(date: calendarView.currentPage), animated: true)
        
//        dateComponents.month = -1
//        self.calendarView.currentPage = calendar.date(byAdding: dateComponents, to: self.calendarView.currentPage)!
//        self.calendarView.setCurrentPage(calendarView.currentPage, animated: true)
        
//        let currentDay = calendarView.currentPage
//        var components = DateComponents()
//        let calendar = Calendar(identifier: .gregorian)
//        components.month = -1
//        let preDay = calendar.date(byAdding: components, to: currentDay)!
//        calendarView.setCurrentPage(preDay, animated: true)
//    }

//    func getNextMonth(date:Date)->Date {
//        return Calendar.current.date(byAdding: .month, value: 1, to:date)!
//    }
//
//    func getPreviousMonth(date:Date)->Date {
//        return Calendar.current.date(byAdding: .month, value: -1, to:date)!
//    }
