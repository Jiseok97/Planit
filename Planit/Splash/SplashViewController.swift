//
//  SplashViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        usleep(3000000)
        
        if Constant.MY_ACCESS_TOKEN.isEmpty {
            changeRootVC(LoginViewController())
        } else {
            changeRootVC(BaseTabBarController())
        }
        
    }

}
