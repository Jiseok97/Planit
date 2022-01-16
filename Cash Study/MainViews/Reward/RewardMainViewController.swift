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
        
        self.rewardShopBtn.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        showIndicator()
        ShowUserRewardDataManager().showReward(viewController: self)
        
        // 별 획득 후 UI Update
        NotificationCenter.default.addObserver(self, selector: #selector(reloadReward(_:)), name: NSNotification.Name("reloadReward"), object: nil)
        
        // 별 획득 팝업 Observer
        NotificationCenter.default.addObserver(self, selector: #selector(successChangeReward(_:)), name: NSNotification.Name("successChangeReward"), object: nil)
        
        satisfyAnimation.play()
        bgAnimation.play()
        self.actionLtView.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("reloadReward"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("successChangeReward"), object: nil)
    }
    
    
    
    // MARK: Functions
    func setUI() {
        self.rewardShopBtn.layer.borderColor = UIColor.myGray.cgColor
        self.rewardShopBtn.layer.borderWidth = 1
        self.rewardShopBtn.layer.cornerRadius = rewardShopBtn.frame.height / 2
        
        self.passView.layer.cornerRadius = 8
    }
    
    // 별 획득 후 UI 업데이트를 위한 DataManager 호출
    @objc func reloadReward(_ noti: Notification) {
        ShowUserRewardDataManager().showReward(viewController: self)
    }
    
    // 중앙 별 클릭 시
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
    
    // 별 획득 팝업 Observer
    @objc func successChangeReward(_ noti: Notification) {
        let vc = ObAlertViewController(mainMsg: "5포인트를 획득하였습니다", subMsg: "", heightValue: 0.19, btnTitle: "확인", isTimer: false, isMypage: false)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    
    // 플래닛 패스 이동
    @IBAction func movePlanitPass(_ sender: Any) {
        guard let passCnt = rewardDataLst?.planetPass else { return }
        if passCnt == 0 {
            let vc = ObAlertViewController(mainMsg: "보유하고 있는\n플래닛 패스가 없습니다", subMsg: "", heightValue: 0.2, btnTitle: "확인", isTimer: false, isMypage: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        } else {
            guard let star = rewardDataLst?.star else { return }
            
            let vc = PlanitPassViewController(prevPoint: star)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
    
    // 리워드 샵 이동
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
