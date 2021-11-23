//
//  SplashViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit

class SplashViewController: UIViewController {

    
    var userAccessToken: String = ""
    var userRefreshToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        checkToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setToken()
    }
    
    
    func checkToken() {
//        let refreshToken = UserDefaults.standard.string(forKey: "refreshToken")
        let input = RefreshTokenInput(refreshToken: Constant.MY_REFRESH_TOKEN)
        CheckTokenDataManager().updateToken(input)
        print("Update Access Token")
    }
    
    
    func setToken() {
        if UserDefaults.standard.string(forKey: "accessToken")?.isEmpty == false {
            userAccessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
            userRefreshToken = UserDefaults.standard.string(forKey: "refreshToken") ?? ""
        } else {
            return
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        usleep(3000000)
        
        changeRootVC(LoginViewController())
//        changeRootVC(TermsOfUseViewController())

        
//        if userAccessToken == "" {
//            changeRootVC(LoginViewController())
//        } else {
//            // 홈을 불러오는 API 넣어주기 !
//
//            changeRootVC(BaseTabBarController())
//            print("User AccessToken → \(userAccessToken)")
//            print("User RefreshToken → \(userRefreshToken)")
//        }
        
    }

}
