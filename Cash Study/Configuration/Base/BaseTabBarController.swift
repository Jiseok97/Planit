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
    let mypageViewController = MyPageViewController()
    
    
    let homeTabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "homeTab"), tag: 0)
    let plannerTabBarItem = UITabBarItem(title: "플래너", image: UIImage(named: "plannerTab"), tag: 1)
    let mypageTabBarItem = UITabBarItem(title: "마이", image: UIImage(named: "myTab"), tag: 2)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = UINavigationController(rootViewController: homeViewController)
        let plannerVC = UINavigationController(rootViewController: plannerViewController)
        let mypageVC = UINavigationController(rootViewController: mypageViewController)
        
        homeVC.tabBarItem = homeTabBarItem
        plannerVC.tabBarItem = plannerTabBarItem
        mypageVC.tabBarItem = mypageTabBarItem
        
        self.viewControllers = [homeVC, plannerVC, mypageVC]
        
        
        self.delegate = self
        self.tabBar.tintColor = UIColor.white
        self.tabBar.barTintColor = UIColor.mainNavy
        self.tabBar.backgroundColor = UIColor.mainNavy
        self.tabBar.isTranslucent = false
        self.tabBar.layer.borderWidth = 0.4
        self.tabBar.layer.borderColor = UIColor.homeBorderColor.cgColor
        self.tabBar.clipsToBounds = true
        
    }
}
