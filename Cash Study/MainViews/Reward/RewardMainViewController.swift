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
    
    
    @IBAction func rewardStarTapped(_ sender: UIButton) {
//        let vc = ObAlertViewController(mainMsg: "서비스 준비중입니다", subMsg: "", btnTitle: "확인", isTimer: false)
//        vc.modalPresentationStyle = .overFullScreen
//        present(vc, animated: true)
        
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")

        rotation.toValue = Double.pi * 2
        rotation.duration = 1.4
//        rotation.isCumulative = true
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
            } completion: { _ in
                let anView = AnimationView(name: "testStar")
                anView.frame = CGRect(x: 0, y: 0, width: 190, height: 190)
                anView.center = self.view.center
                anView.contentMode = .scaleAspectFill
                anView.layer.zPosition = 0
                self.view.addSubview(anView)
                anView.play()
            }
        })
        
//        UIView.animate(withDuration: 0.5, animations: {
//            let fRotate = CGAffineTransform(rotationAngle: .pi)
//            let scale = CGAffineTransform(scaleX: 1.6, y: 1.6)
//            let combine = scale.concatenating(fRotate)
//            self.rewardView.transform = combine
//        }) { (_) in
//            UIView.animate(withDuration: 1.1) {
//                self.rewardView.transform = CGAffineTransform.identity
//            }
//        }
        
        
    }
    
    
    @IBAction func moveRewardShop(_ sender: Any) {
        let vc = RewardShopViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
//        let vc = ObAlertViewController(mainMsg: "서비스 준비중입니다", subMsg: "", btnTitle: "확인", isTimer: false)
//        vc.modalPresentationStyle = .overFullScreen
//        present(vc, animated: true)
    }
    
}
