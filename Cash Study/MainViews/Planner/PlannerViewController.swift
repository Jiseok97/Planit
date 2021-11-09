//
//  PlannerViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit
import SnapKit

class PlannerViewController: UIViewController {

    @IBOutlet weak var sgController: UISegmentedControl!
    @IBOutlet weak var plusBtn: UIButton!
    
    let plannerVC = PlannerPageViewController()
    let dDayVC = DdayPageViewController()
    
    let segmentIndicator: UIView = {
        let v = UIView()
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.mainNavy
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setSGControl()
        setUp()
    }
    
    func setUI() {
        self.plusBtn.layer.borderColor = UIColor.myGray.cgColor
        self.plusBtn.layer.borderWidth = 1
        self.plusBtn.layer.cornerRadius = plusBtn.frame.height / 2 - 5
    }
    
    func setSGControl() {
//        self.sgController.backgroundColor = .clear
//        self.sgController.tintColor = .clear
        
        self.sgController.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        self.sgController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Medium", size: 18)!, NSAttributedString.Key.foregroundColor: UIColor.sgNomalColor], for: .normal)

        self.sgController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Medium", size: 18)!, NSAttributedString.Key.foregroundColor: UIColor.myGray], for: .selected)
        
        self.view.addSubview(segmentIndicator)
        
        self.segmentIndicator.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.sgController.snp.bottom).offset(2)
            make.height.equalTo(2)
            make.width.equalTo(self.sgController.frame.width / 3)
            make.centerX.equalTo(self.sgController.snp.centerX)
                .dividedBy(self.sgController.numberOfSegments)
            
        }
        
        self.sgController.addTarget(self, action: #selector(indexChanged), for: .valueChanged)

        
    }
    
    func setUp() {
        addChild(plannerVC)
        addChild(dDayVC)
        
        self.view.addSubview(plannerVC.view)
        self.view.addSubview(dDayVC.view)
        
        plannerVC.didMove(toParent: self)
        dDayVC.didMove(toParent: self)
        
        
        plannerVC.view.frame = CGRect(x: 0, y: 110, width: self.view.bounds.width, height: self.view.bounds.height - 104)
        dDayVC.view.frame = CGRect(x: 0, y: 110, width: self.view.bounds.width, height: self.view.bounds.height - 104)
        
        plannerVC.view.isHidden = false
        dDayVC.view.isHidden = true
    }
    
    
    
    
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        let numberOfSegments = CGFloat(self.sgController.numberOfSegments)
        let selectedIdx = CGFloat(sender.selectedSegmentIndex)
        
        self.segmentIndicator.snp.remakeConstraints { (make) in
            make.top.equalTo(self.sgController.snp.bottom).offset(3)
            make.height.equalTo(3)
            make.width.equalTo(self.sgController.frame.width / 3)
//            make.width.equalTo(15 + titleCnt * 8)
            make.centerX.equalTo(self.sgController.snp.centerX).dividedBy(numberOfSegments / CGFloat(3.0 + CGFloat(selectedIdx - 1.0) * 2.0))
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.segmentIndicator.transform = CGAffineTransform(scaleX: 1.4, y: 1)
        }) { (finish) in
            UIView.animate(withDuration: 0.4, animations: {
                self.segmentIndicator.transform = CGAffineTransform.identity
            })
        }
        
        self.plannerVC.view.isHidden = true
        self.dDayVC.view.isHidden = true
        
        switch self.sgController.selectedSegmentIndex {
        case 0:
            self.plannerVC.view.isHidden = false
        default:
            self.dDayVC.view.isHidden = false
        }
        
//        if self.segmentController.selectedSegmentIndex == 0 {
//            self.eatDealVC.view.isHidden = false
//        } else if self.segmentController.selectedSegmentIndex == 1 {
//            self.storyVC.view.isHidden = false
//        } else {
//            self.topVC.view.isHidden = false
//        }
    }
    
    
    
    // MARK: Navigation Bar Hidden
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


