//
//  PlannerViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit

class PlannerViewController: UIViewController {

    @IBOutlet weak var sgController: UISegmentedControl!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var plusBtnWidth: NSLayoutConstraint!
    
    let plannerVC = PlannerPageViewController()
    let dDayVC = DdayPageViewController()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setSGControl()
        setUp()
        setGradation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(moveSGIdx(_:)), name: NSNotification.Name("moveSGIdx"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("moveSGIdx"), object: nil)
    }
    
    // MARK: - Custom Method
    func setUI() {
        self.plusBtn.layer.borderColor = UIColor.myGray.cgColor
        self.plusBtn.layer.borderWidth = 1
        self.plusBtn.layer.cornerRadius = plusBtn.frame.height / 2
    }
    
    
    /// 홈에서 대표 디데이 없을 시 이동하는 Observer
    @objc func moveSGIdx(_ noti: Notification) {
        print(sgController.selectedSegmentIndex)
    }
    
    
    /// Segment Control UI 및 이벤트 함수 대입
    func setSGControl() {
        self.sgController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.sgNomalColor], for: .normal)

        self.sgController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.myGray], for: .selected)
        
        self.sgController.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        self.sgController.setBackgroundImage(UIImage(named: "navyImg1"), for: .normal, barMetrics: .default)
        self.sgController.setDividerImage(UIImage(named: "navyImg2"), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
  
    }
    
    /// Segment Control Add View
    func setUp() {
        addChild(plannerVC)
        addChild(dDayVC)
        
        self.view.addSubview(plannerVC.view)
        self.view.addSubview(dDayVC.view)
        
        plannerVC.didMove(toParent: self)
        dDayVC.didMove(toParent: self)
        
        // 화면 높이가 작은건 y : 90으로 바꿔주기 !
        if UIScreen.main.bounds.height < 812 {
            plannerVC.view.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: self.view.bounds.height - 104)
            dDayVC.view.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: self.view.bounds.height - 104)
        } else {
            plannerVC.view.frame = CGRect(x: 0, y: 120, width: self.view.bounds.width, height: self.view.bounds.height - 104)
            dDayVC.view.frame = CGRect(x: 0, y: 120, width: self.view.bounds.width, height: self.view.bounds.height - 104)
        }
        
        
        plannerVC.view.isHidden = false
        dDayVC.view.isHidden = true
    }
    
    
    /// Segment Control 클릭 이벤트
    @objc func indexChanged(_ sender: UISegmentedControl) {
        self.plannerVC.view.isHidden = true
        self.dDayVC.view.isHidden = true
        
        switch self.sgController.selectedSegmentIndex {
        case 0:
            self.plannerVC.view.isHidden = false
            self.plusBtn.setTitle(" 공부추가", for: .normal)
            self.plusBtnWidth.constant = CGFloat(102)
            
        default:
            self.dDayVC.view.isHidden = false
            self.plusBtn.setTitle(" 디데이추가", for: .normal)
            self.plusBtnWidth.constant = CGFloat(115)
            
        }
    }
    
    /// 공부 추가 || 디데이 추가 이동
    @IBAction func moveAddpage(_ sender: UIButton) {
        if sgController.selectedSegmentIndex == 0 {
            let vc = AddStudyViewController(stGrId: 0, stSchId: 0, title: "", startAtTxt: "", endAtTxt: "", isEdit: false, isRepeat: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        } else {
            let vc = AddDdayViewController(id: 0, title: "", editEndTxt: "" ,endTxt: "", iconTxt: "", isEdit: false, isRepresentative: false, homeAddDday: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
}


