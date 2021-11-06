//
//  BaseTabBarController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/24.
//


import UIKit

class BaseTabBarController : UITabBarController, UITabBarControllerDelegate {
    let homeViewController = HomeViewController()
    let plannerViewController = PlannerViewController()
    let rewardViewController = RewardViewController()
    let analysisViewController = AnalysisViewController()
    let mypageViewController = MyPageViewController()
    
    
    let homeTabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "homeTab"), tag: 0)
    let plannerTabBarItem = UITabBarItem(title: "플래너", image: UIImage(named: "plannerTab"), tag: 1)
    let rewardTabBarItem = UITabBarItem(title: "리워드", image: UIImage(named: "rewardTab"), tag: 2)
    let analysisTabBarItem = UITabBarItem(title: "분석", image: UIImage(named: "analysisTab"), tag: 3)
    let mypageTabBarItem = UITabBarItem(title: "마이", image: UIImage(named: "myTab"), tag: 4)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = UINavigationController(rootViewController: homeViewController)
        let plannerVC = UINavigationController(rootViewController: plannerViewController)
        let rewardVC = UINavigationController(rootViewController: rewardViewController)
        let analysisVC = UINavigationController(rootViewController: analysisViewController)
        let mypageVC = UINavigationController(rootViewController: mypageViewController)
        
        homeVC.tabBarItem = homeTabBarItem
        plannerVC.tabBarItem = plannerTabBarItem
        rewardVC.tabBarItem = rewardTabBarItem
        analysisVC.tabBarItem = analysisTabBarItem
        mypageVC.tabBarItem = mypageTabBarItem
        
        self.viewControllers = [homeVC, plannerVC, rewardVC, analysisVC, mypageVC]
        
        
        self.delegate = self
        self.tabBar.tintColor = UIColor.white
        self.tabBar.barTintColor = UIColor.mainNavy
        self.tabBar.isTranslucent = false
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor.homeBorderColor.cgColor
        self.tabBar.clipsToBounds = true
        
    }
}
