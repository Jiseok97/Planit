//
//  RewardMainViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/08.
//

import UIKit

class RewardMainViewController: UIViewController {

    @IBOutlet weak var rewardShopBtn: UIButton!
    @IBOutlet weak var rewardStarBtn: UIButton!
    
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var myPointLbl: UILabel!
    @IBOutlet weak var passCntLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setGradation()
        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    // MARK: Functions
    func setUI() {
        self.rewardShopBtn.layer.borderColor = UIColor.myGray.cgColor
        self.rewardShopBtn.layer.borderWidth = 1
        self.rewardShopBtn.layer.cornerRadius = rewardShopBtn.frame.height / 2
        
        self.passView.layer.cornerRadius = 8
    }
    
    
    @IBAction func rewardStarTapped(_ sender: Any) {
        let vc = ObAlertViewController(mainMsg: "서비스 준비중입니다", subMsg: "", btnTitle: "확인", isTimer: false)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func moveRewardShop(_ sender: Any) {
        let vc = RewardShopViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}
