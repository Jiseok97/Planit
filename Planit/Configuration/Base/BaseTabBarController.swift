//
//  BaseTabBarController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/24.
//


import UIKit
import SwiftUI

class BaseTabBarController : UITabBarController, UITabBarControllerDelegate {
    let timerViewController = UIHostingController(rootView: TimerView(name: .constant("")))
    //    let mainViewController = MainViewController()
//    let mangoPickViewController = MangoPickViewController()
//    let plusViewController = PlusViewController()
//    let storyViewController = MangoStroyViewController()
//    let myInfoViewController = MyInfoViewController()
//    let noLoginViewController = NotLoginViewController()
//
    let timerTabBarItem = UITabBarItem(title: "Timer", image: nil, tag: 0)
//    let mangoTabBarItem = UITabBarItem(title: "망고픽", image: UIImage(systemName: "bookmark"), tag: 1)
//    let plusTabBarItem = UITabBarItem(title: nil,
//                                      image: UIImage(named: "tabBarPlus")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.mainColor),
//                                      tag: 2)
//    let storyTabBarItem = UITabBarItem(title: "소식", image: UIImage(systemName: "bubble.left.and.bubble.right"), tag: 3)
//    let myInfoTabBarItem = UITabBarItem(title: "내정보", image: UIImage(systemName: "person.crop.circle"), tag: 4)
//
//
    override func viewDidLoad() {
        super.viewDidLoad()

        let timerVC = UINavigationController(rootViewController: timerViewController)
//        let mainVC = UINavigationController(rootViewController: mainViewController)
//        let mangoPickVC = UINavigationController(rootViewController: mangoPickViewController)
//        let plusVC = UINavigationController(rootViewController: plusViewController)
//        let storyVC = UINavigationController(rootViewController: storyViewController)
//
//        let myInfoVC = UINavigationController(rootViewController: myInfoViewController)
//        let noUserVC = UINavigationController(rootViewController: noLoginViewController)
//
//        plusTabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 27, bottom: 0, right: 27)
//
        timerVC.tabBarItem = timerTabBarItem
//        mainVC.tabBarItem = mainTabBarItem
//        mangoPickVC.tabBarItem = mangoTabBarItem
//        plusVC.tabBarItem = plusTabBarItem
//        storyVC.tabBarItem = storyTabBarItem
//        if Constant.MY_TOKEN.isEmpty == false {
//            myInfoVC.tabBarItem = myInfoTabBarItem
//            self.viewControllers = [mainVC, mangoPickVC, plusVC, storyVC, myInfoVC ]
//        } else {
//            noUserVC.tabBarItem = myInfoTabBarItem
//            self.viewControllers = [mainVC, mangoPickVC, plusVC, storyVC, noUserVC]
//        }
//
//
//
//
//
        self.delegate = self
//        self.tabBar.tintColor = UIColor.mainYellow
        self.tabBar.unselectedItemTintColor = UIColor.systemGray3
        self.tabBar.backgroundColor = UIColor.white
        
        
    }
}
