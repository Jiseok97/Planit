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
import AuthenticationServices

import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import AppCenterDistribute

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("view Height = \(UIScreen.main.bounds.size.height)")
        // App Center
        AppCenter.start(withAppSecret: "5ab195b5-4aee-40bd-bae9-47e293f8070e", services:[
          Analytics.self,
          Crashes.self
        ])
        
//        Distribute.updateTrack = .public  
        
        // Kakao Login
        KakaoSDK.initSDK(appKey: "a76352f6670e85030076b792cbff190e")
        
        window = UIWindow()
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()

        // 네트워크 상태 감지
        NetworkMonitor.shared.startMonitoring()
        
        // About Keyboard
        IQKeyboardManager.shared.enable = true
        
        // Apple Login
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let userId = UserDefaults.standard.string(forKey: "appleIdentifier")
//        let userName = UserDefaults.standard.string(forKey: "appleName")
        appleIDProvider.getCredentialState(forUserID: userId ?? "", completion: { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("authorized")
                break
                
            case .revoked:
                print("revoked")
                break
                
            case .notFound:
                print("notFound")
                break
                
            default:
                print("apple login error")
                break
            }
        })
        
        return true
    }
    
    // MARK: Kakao Login Setup
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            return false
        }

        

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}

