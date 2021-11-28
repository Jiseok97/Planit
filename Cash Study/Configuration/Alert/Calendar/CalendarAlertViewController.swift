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
    
    var selectedDate : String = ""
    var nomalDate : String = ""
    var isEnd : Bool = false
    var checkDday : Bool = false
    
    init(isEnd: Bool, checkDday : Bool) {
        self.isEnd = isEnd
        self.checkDday = checkDday
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 (E)"
        
        let differenceDF = DateFormatter()
        differenceDF.dateFormat = "yyyyMMdd"
        
        let nomalDF = DateFormatter()
        nomalDF.dateFormat = "yyyy-MM-dd"
        
        let selectedDate = differenceDF.string(from: date)
        let todayDate = differenceDF.string(from: Date())

        guard let sDate = Int(selectedDate) else { return }
        guard let tDate = Int(todayDate) else { return }
        
        if checkDday {
            self.selectedDate = dateFormatter.string(from: date)
            self.nomalDate = nomalDF.string(from: date)
        } else {
            if sDate < tDate {
                self.calendarView.appearance.selectionColor = UIColor.link.withAlphaComponent(0.0)
                calendar.deselect(date)
            } else {
                self.calendarView.appearance.selectionColor = UIColor.link
                self.selectedDate = dateFormatter.string(from: date)
                self.nomalDate = nomalDF.string(from: date)
            }
        }
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        if isEnd {
            Constant.DATE_TEXT = self.selectedDate
            Constant.END_DATE = self.nomalDate
            NotificationCenter.default.post(name: NSNotification.Name("endDate"), object: nil)
        } else {
            Constant.DATE_TEXT = self.selectedDate
            Constant.DATE = self.nomalDate
            NotificationCenter.default.post(name: NSNotification.Name("sendDate"), object: nil)
        }
        dismiss(animated: true, completion: nil)
    }
    
}




