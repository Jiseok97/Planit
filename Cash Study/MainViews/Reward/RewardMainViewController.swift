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
    @IBOutlet weak var actionLtView: UIView!
    
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
    let satisfyAnimation = AnimationView(name: "satisfyStar")
    let bgAnimation = AnimationView(name: "bgAnimation")
    let actionAnimation = AnimationView(name: "tappedStar")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedActionLtView(_:)))
        self.satisfyLtView.addGestureRecognizer(tapGesture)
        
        setGradation()
        setUI()
        
        self.lottieBgView.addSubview(bgAnimation)
        bgLottie(lottieView: bgAnimation, view: lottieBgView)
        
        self.satisfyLtView.addSubview(satisfyAnimation)
        satisfyLottie(lottieView: satisfyAnimation, view: satisfyLtView)
        
        self.actionLtView.addSubview(actionAnimation)
        actionLottie(lottieView: actionAnimation, view: actionLtView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        showIndicator()
        ShowUserRewardDataManager().showReward(viewController: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadReward(_:)), name: NSNotification.Name("reloadReward"), object: nil)
        
        satisfyAnimation.play()
        bgAnimation.play()
        self.actionLtView.isHidden = true
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
    
    @objc func reloadReward(_ noti: Notification) {
        ShowUserRewardDataManager().showReward(viewController: self)
    }
    
    @objc func tappedActionLtView(_ sender: UITapGestureRecognizer) {
        self.satisfyLtView.isHidden = true
        self.actionLtView.isHidden = false
        self.actionLtView.isUserInteractionEnabled = false
        
        actionAnimation.play { (finish) in
            self.actionLtView.isHidden = true
            self.showIndicator()
            ChangePointDataManager().changePoint(viewController: self)
            self.actionLtView.isUserInteractionEnabled = true
            self.satisfyLtView.isHidden = false
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
        self.actionLtView.isHidden = true
        self.rewardDataLst = result
        
        if self.rewardDataLst != nil {
            let star = result.star
            let point = result.point
            let passCnt = result.planetPass
            
            if star >= 50 {
                self.starLbl.textColor = .remainDdayColor
                self.starCntLbl.textColor = .remainDdayColor
                
                self.rewardView.isHidden = true
                self.actionLtView.isHidden = true
                self.satisfyLtView.isUserInteractionEnabled = true
                self.satisfyLtView.isHidden = false
                
            } else {
                self.starLbl.textColor = .placeHolderColor
                self.starCntLbl.textColor = .placeHolderColor

                self.rewardView.isHidden = false
                self.actionLtView.isHidden = true
                self.satisfyLtView.isUserInteractionEnabled = false
                self.satisfyLtView.isHidden = true
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
