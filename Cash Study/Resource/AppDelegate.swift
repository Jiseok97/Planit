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

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Kakao Login
        KakaoSDK.initSDK(appKey: "a76352f6670e85030076b792cbff190e")
        
        
        window = UIWindow()
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()

        
        // About Keyboard
        IQKeyboardManager.shared.enable = true
        
        // Apple Login
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let userId = UserDefaults.standard.string(forKey: "appleIdentifier")
        appleIDProvider.getCredentialState(forUserID: userId ?? "", completion: { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("해당 ID는 연동되어있습니다.")
                
            case .revoked:
                print("해당 ID는 연동되어있지 않습니다.")
                
            case .notFound:
                print("해당 ID를 찾을 수 없습니다.")
                
            default:
                break
            }
        })
        
        return true
    }
    
    // MARK: Kakao Login Setup
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Kakao
//            if (AuthApi.isKakaoTalkLoginUrl(url)) {
//                return AuthController.handleOpenUrl(url: url)
//            }

            return false
        }

        

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}

