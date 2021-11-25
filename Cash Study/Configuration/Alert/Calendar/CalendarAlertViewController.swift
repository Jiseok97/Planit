//
//  CalendarAlertViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/25.
//

import UIKit
import FSCalendar

class CalendarAlertViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setCalendar()
    }
    
    
    
    // MARK: Functions
    func setUI() {
        self.contentView.layer.cornerRadius = 20
        self.confirmBtn.layer.cornerRadius = self.confirmBtn.frame.height / 2
    }
    
    func setCalendar() {
        calendarView.locale = Locale(identifier: "ko_KR")
        
        calendarView.appearance.headerDateFormat = "YYYY년 MM월"
        calendarView.appearance.headerTitleColor = UIColor.link
        calendarView.appearance.headerTitleFont = UIFont(name: "NotoSansCJKkr-Medium", size: 16)
        calendarView.appearance.headerTitleOffset = CGPoint(x: 0, y: -12)
        
        calendarView.appearance.titleTodayColor = UIColor(red: 220/225, green: 185/225, blue: 45/225, alpha: 1.0)
        calendarView.placeholderType = .none
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
