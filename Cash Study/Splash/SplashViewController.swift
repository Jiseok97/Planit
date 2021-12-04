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
    override func viewDidAppear(_ animated: Bool) {
        usleep(3000000)
        
//        changeRootVC(LoginViewController())
        changeRootVC(TermsOfUseViewController())
    }

}
