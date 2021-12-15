//
//  RewardMainViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/08.
//

import UIKit
import Lottie

class RewardMainViewController: UIViewController {
    
    @IBOutlet weak var lottieBgView: UIView!
    @IBOutlet weak var satisfyLtView: UIView!
    
    @IBOutlet weak var rewardShopBtn: UIButton!
    @IBOutlet weak var rewardView: UIView!
    @IBOutlet weak var rewardStarImgView: UIImageView!
    
    @IBOutlet weak var starLbl: UILabel!
    @IBOutlet weak var starCntLbl: UILabel!
    
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var myPointLbl: UILabel!
    @IBOutlet weak var passCntLbl: UILabel!
    
    var rewardDataLst : ShowUserRewardEntity?
    var starCnt: Int = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedRewardView(_:)))
        
        self.rewardView.addGestureRecognizer(tapGesture)
        
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
        
        let bgAnimation = AnimationView(name: "bgAnimation")
        self.lottieBgView.addSubview(bgAnimation)
        
        let centerX = NSLayoutConstraint(item: bgAnimation, attribute: .centerX, relatedBy: .equal, toItem: lottieBgView, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: bgAnimation, attribute: .centerY, relatedBy: .equal, toItem: lottieBgView, attribute: .centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: bgAnimation, attribute: .width, relatedBy: .equal, toItem: lottieBgView, attribute: .width, multiplier: 1, constant: 35)
        let height = NSLayoutConstraint(item: bgAnimation, attribute: .height, relatedBy: .equal, toItem: lottieBgView, attribute: .height, multiplier: 1, constant: 35)
        
        view.addConstraints([ centerX, centerY, width, height ])
        
        bgAnimation.translatesAutoresizingMaskIntoConstraints = false
        bgAnimation.contentMode = .scaleAspectFill
        bgAnimation.loopMode = .loop
        bgAnimation.play()
    }
    
    
    @objc func tappedRewardView(_ sender: UITapGestureRecognizer) {
        satisfyLtView.isHidden = true
        
        let actionAnimation = AnimationView(name: "tappedStar")
        self.rewardView.addSubview(actionAnimation)
        
        let centerX = NSLayoutConstraint(item: actionAnimation, attribute: .centerX, relatedBy: .equal, toItem: rewardView, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: actionAnimation, attribute: .centerY, relatedBy: .equal, toItem: rewardView, attribute: .centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: actionAnimation, attribute: .width, relatedBy: .equal, toItem: rewardView, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: actionAnimation, attribute: .height, relatedBy: .equal, toItem: rewardView, attribute: .height, multiplier: 1, constant: 0)
        
        self.rewardView.addConstraints([ centerX, centerY, width, height ])
        actionAnimation.contentMode = .scaleAspectFill
        actionAnimation.play { (finish) in
            actionAnimation.removeFromSuperview()
            self.starCnt -= 50
            if self.starCnt >= 50 {
                self.satisfyLtView.isHidden = false
            } else {
                self.rewardStarImgView.isHidden = false
            }
        }
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
            
//            if star >= 50 {
            if self.starCnt >= 50 {
                self.starLbl.textColor = .remainDdayColor
                self.starCntLbl.textColor = .remainDdayColor
                
                self.rewardStarImgView.isHidden = true
                
                let animationView = AnimationView(name: "satisfyStar")
                self.satisfyLtView.addSubview(animationView)
                
                let centerX = NSLayoutConstraint(item: animationView, attribute: .centerX, relatedBy: .equal, toItem: rewardView, attribute: .centerX, multiplier: 1, constant: 0)
                let centerY = NSLayoutConstraint(item: animationView, attribute: .centerY, relatedBy: .equal, toItem: rewardView, attribute: .centerY, multiplier: 1, constant: 0)
                let width = NSLayoutConstraint(item: animationView, attribute: .width, relatedBy: .equal, toItem: rewardView, attribute: .width, multiplier: 1, constant: 0)
                let height = NSLayoutConstraint(item: animationView, attribute: .height, relatedBy: .equal, toItem: rewardView, attribute: .height, multiplier: 1, constant: 0)
                
                view.addConstraints([ centerX, centerY, width, height ])
                
                animationView.translatesAutoresizingMaskIntoConstraints = false
                animationView.contentMode = .scaleAspectFill
                animationView.loopMode = .loop
                animationView.play()
                
                
            } else {
                self.starLbl.textColor = .placeHolderColor
                self.starCntLbl.textColor = .placeHolderColor
                
                self.rewardStarImgView.isHidden = false
            }
            
            self.starCntLbl.text = "\(String(describing: star))/50"
            self.myPointLbl.text = "\(String(describing: point))P"
            self.passCntLbl.text = "\(String(describing: passCnt))"
        }
    }
}
