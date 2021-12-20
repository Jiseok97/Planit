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
    @IBOutlet weak var passBgImgView: UIImageView!
    
    
    var rewardDataLst : ShowUserRewardEntity?
    let animationView = AnimationView(name: "satisfyStar")
    let bgAnimation = AnimationView(name: "bgAnimation")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedRewardView(_:)))
        
        self.rewardView.addGestureRecognizer(tapGesture)
        
        setGradation()
        setUI()
        
        self.lottieBgView.addSubview(bgAnimation)
        bgLottie()
        self.satisfyLtView.addSubview(animationView)
        satisfyLottie()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        showIndicator()
        ShowUserRewardDataManager().showReward(viewController: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadReward(_:)), name: NSNotification.Name("reloadReward"), object: nil)
        
        animationView.play()
        bgAnimation.play()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("reloadReward"), object: nil)
    }
    
    // MARK: Functions
    func setUI() {
        self.rewardShopBtn.layer.borderColor = UIColor.myGray.cgColor
        self.rewardShopBtn.layer.borderWidth = 1
        self.rewardShopBtn.layer.cornerRadius = rewardShopBtn.frame.height / 2
        
        self.passView.layer.cornerRadius = 8
    }
    
    func bgLottie() {
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
    
    func satisfyLottie() {
        let centerX2 = NSLayoutConstraint(item: animationView, attribute: .centerX, relatedBy: .equal, toItem: satisfyLtView, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY2 = NSLayoutConstraint(item: animationView, attribute: .centerY, relatedBy: .equal, toItem: satisfyLtView, attribute: .centerY, multiplier: 1, constant: 0)
        let width2 = NSLayoutConstraint(item: animationView, attribute: .width, relatedBy: .equal, toItem: satisfyLtView, attribute: .width, multiplier: 1, constant: 0)
        let height2 = NSLayoutConstraint(item: animationView, attribute: .height, relatedBy: .equal, toItem: satisfyLtView, attribute: .height, multiplier: 1, constant: 0)
        
        view.addConstraints([ centerX2, centerY2, width2, height2 ])
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
    }
    
    
    @objc func reloadReward(_ noti: Notification) {
        ShowUserRewardDataManager().showReward(viewController: self)
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
        self.rewardView.isUserInteractionEnabled = false
        actionAnimation.contentMode = .scaleAspectFill
        actionAnimation.play { (finish) in
            actionAnimation.removeFromSuperview()
            self.showIndicator()
            ChangePointDataManager().changePoint(viewController: self)
            self.rewardView.isUserInteractionEnabled = true
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
            
            if star >= 50 {
                self.starLbl.textColor = .remainDdayColor
                self.starCntLbl.textColor = .remainDdayColor
                
                self.rewardStarImgView.isHidden = true
                self.rewardView.isHidden = false
                self.rewardView.isUserInteractionEnabled = true
                self.satisfyLtView.isHidden = false
                
            } else {
                self.starLbl.textColor = .placeHolderColor
                self.starCntLbl.textColor = .placeHolderColor
                
                self.satisfyLtView.isHidden = true
                self.rewardView.isHidden = false
                self.rewardView.isUserInteractionEnabled = false
                self.rewardStarImgView.isHidden = false
            }
            
            if passCnt > 0 {
                self.passBgImgView.image = UIImage(named: "tapImg")
            } else {
                self.passBgImgView.image = UIImage(named: "noTapImg")
            }
            
            self.starCntLbl.text = "\(String(describing: star))/50"
            self.myPointLbl.text = "\(String(describing: point))P"
            self.passCntLbl.text = "\(String(describing: passCnt))"
        }
    }
}
