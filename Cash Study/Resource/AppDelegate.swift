//
//  AppDelegate.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/13.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // iOS 13 미만일 경우 실행을 위해
        if #available(iOS 130.0, *) { return true }
        
        window = UIWindow()
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
        
        // Kakao Login
        KakaoSDKCommon.initSDK(appKey: "ca398c6d25602fa0235ad2824bbaef1a")
        
        // About Keyboard
        IQKeyboardManager.shared.enable = true
        
        return true
    }
    
    // MARK: Kakao Login Setup
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Kakao
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                return AuthController.handleOpenUrl(url: url)
            }
        
            return false
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}

