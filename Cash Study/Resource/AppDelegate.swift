//
//  AppDelegate.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/13.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import FacebookCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // iOS 13 미만일 경우 실행을 위해
        if #available(iOS 130.0, *) { return true }
        
        window = UIWindow()
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
        
        // Kakao Login
        KakaoSDKCommon.initSDK(appKey: "9dd539538c7ec090849f98f4b9809fdd")
        
        // FaceBook
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        return true
    }
    
    // MARK: Kakao Login Setup
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Kakao
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                return AuthController.handleOpenUrl(url: url)
            }
        
        // FaceBook
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )

            return false
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}

