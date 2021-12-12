//
//  RewardMainViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/08.
//

import UIKit
import Lottie

class RewardMainViewController: UIViewController {

    @IBOutlet weak var rewardShopBtn: UIButton!
    @IBOutlet weak var rewardView: UIView!
    @IBOutlet weak var rewardStarBtn: UIButton!
    @IBOutlet weak var starLbl: UILabel!
    @IBOutlet weak var starCntLbl: UILabel!
    
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var myPointLbl: UILabel!
    @IBOutlet weak var passCntLbl: UILabel!
    
    var rewardDataLst : ShowUserRewardEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setGradation()
        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        showIndicator()
        ShowUserRewardDataManager().showReward(viewController: self)
    }
    
    
    // MARK: Functions
    func setUI() {
        self.rewardShopBtn.layer.borderColor = UIColor.myGray.cgColor
        self.rewardShopBtn.layer.borderWidth = 1
        self.rewardShopBtn.layer.cornerRadius = rewardShopBtn.frame.height / 2
        
        self.passView.layer.cornerRadius = 8
    }
    
    
    @IBAction func rewardStarTapped(_ sender: UIButton) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")

        rotation.toValue = Double.pi * 2
        rotation.duration = 1.4
        rotation.isCumulative = true
        rotation.autoreverses = false
        rotation.repeatCount = 1

        rewardView.layer.add(rotation, forKey: "rotationAnimation")
        rewardView.layer.zPosition = 1
        rewardStarBtn.layer.zPosition = 999

        UIView.animate(withDuration: 0.4, animations: {
            self.rewardView.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
        }, completion: { _ in
            UIView.animate(withDuration: 1.0) {
                self.rewardView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        })
        
    }
    
    @IBAction func movePlanitPass(_ sender: Any) {
        let vc = PlanitPassViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    
    
    @IBAction func moveRewardShop(_ sender: Any) {
        let vc = RewardShopViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}


extension RewardMainViewController {
    func showReward(result: ShowUserRewardEntity) {
        dismissIndicator()
        self.rewardDataLst = result
        
        if self.rewardDataLst != nil {
            let star = result.star
            let point = result.point
            let passCnt = result.planetPass
            
            if star >= 50 {
                self.starLbl.textColor = .remainDdayColor
                self.starCntLbl.textColor = .remainDdayColor
            } else {
                self.starLbl.textColor = .placeHolderColor
                self.starCntLbl.textColor = .placeHolderColor
            }
            
            self.starCntLbl.text = "\(String(describing: star))/50"
            self.myPointLbl.text = "\(String(describing: point))P"
            self.passCntLbl.text = "\(String(describing: passCnt))"
        }
    }
}
