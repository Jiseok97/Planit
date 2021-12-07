//
//  AnalysisViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/06.
//

import UIKit

class AnalysisViewController: UIViewController {

    @IBOutlet weak var sgController: UISegmentedControl!
    
    let dailyVC = DailyReportViewController()
    let analysisVC = AnalysisPageViewController()
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setGradation()
        setUI()
        setUP()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    // MARK: Functions
    
    func setUI() {
        self.sgController.layer.cornerRadius = 8
        self.sgController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.myGray], for: .normal)
        self.sgController.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        self.sgController.selectedSegmentTintColor = .link
    }
    
    func setUP() {
        addChild(dailyVC)
        addChild(analysisVC)
        
        self.view.addSubview(dailyVC.view)
        self.view.addSubview(analysisVC.view)
        
        dailyVC.didMove(toParent: self)
        analysisVC.didMove(toParent: self)
        
        if UIScreen.main.bounds.height < 812 {
            dailyVC.view.frame = CGRect(x: 0, y: 160, width: self.view.bounds.width, height: self.view.bounds.height - 104)
            analysisVC.view.frame = CGRect(x: 0, y: 160, width: self.view.bounds.width, height: self.view.bounds.height - 104)
        } else {
            dailyVC.view.frame = CGRect(x: 0, y: 180, width: self.view.bounds.width, height: self.view.bounds.height - 104)
            analysisVC.view.frame = CGRect(x: 0, y: 180, width: self.view.bounds.width, height: self.view.bounds.height - 104)
        }
        
        dailyVC.view.isHidden = false
        analysisVC.view.isHidden = true
    }
    
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        self.dailyVC.view.isHidden = true
        self.analysisVC.view.isHidden = true
        
        switch self.sgController.selectedSegmentIndex {
        case 0:
            self.dailyVC.view.isHidden = false
            
        default:
            self.analysisVC.view.isHidden = false
            
        }
    }

}
