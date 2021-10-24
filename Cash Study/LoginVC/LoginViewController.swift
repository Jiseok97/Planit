//
//  LoginViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/13.
//

import UIKit
import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import FBSDKLoginKit
import AuthenticationServices

// iOS 13버전부터 Apple Login 지원
@available(iOS 13.0, *)
class LoginViewController: UIViewController {
    
    @IBOutlet weak var kakaoLoginView: UIView!
    @IBOutlet weak var facebookLoginView: UIView!
    @IBOutlet weak var appleLoginView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: Set UI
    func setUI() {
        kakaoLoginView.layer.cornerRadius = 25
        facebookLoginView.layer.cornerRadius = 25
        appleLoginView.layer.cornerRadius = 25
        
        view.backgroundColor = UIColor.mainNavy
        
    }
    
    
    // MARK: Kakao Login Btn
    @IBAction func kakaoBtnTapped(_ sender: Any) {
        
        /// 폰으로 직접 확인해야 할 부분!!
        // 카카오톡 설치 여부
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            // 카카오톡으로 로그인 진행
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print("카카오톡이 설치되어 있지 않습니다.")
//                    print(error)
//                }
//                else {
//                    print("loginWithKakaoTalk() success.")
//
//                    _ = oauthToken
        
//                    UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
//                        if let error = error {
//                            print("AccessToken 정보를 가져오는데 실패 → \(error)")
//                        }
//                        else {
//                            print("accessTokenInfo() success.")
//
//                            _ = accessTokenInfo
//                            guard let token = oauthToken?.accessToken else { return }
//                            print("accessTokenInfo → \(token)")
//                            self.getUserInfo()
//                        }
//                    }
//                }
//            }
//        }
        
        // 카카오 웹
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print("카카오 임시 로그인 에러 발생 → \(error)")
                }
                else {
                    // 로그인 성공
                    print("loginWithKakaoAccount() success.")
                    
                    _ = oauthToken
                    
                    UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
                        if let error = error {
                            print("AccessToken 정보를 가져오는데 실패 → \(error)")
                        }
                        else {
                            print("accessTokenInfo() success.")
                            
                            _ = accessTokenInfo
                            guard let token = oauthToken?.accessToken else { return }
//                            UserDefaults.standard.setValue(token, forKey: "hasToken")
                            print("accessTokenInfo → \(token)")
                            self.getUserInfo()
                            
                        }
                    }
                }
            }
    }
    
    
    // MARK: 카카오 유저 정보 가져오기
    func getUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                
                _ = user
//                guard let profile = user?.kakaoAccount?.profile else { return }
                guard let userName = user?.kakaoAccount?.profile?.nickname else { return }
                print("getUserInfo(kakaoAccount) → \(userName)")
                
//                let tvc = BaseTabBarController()
//                tvc.modalPresentationStyle = .overFullScreen
//                self.present(tvc, animated: true)
                
                let vc = UIHostingController(rootView: TimerView(name: .constant(userName)))
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)

            }
        }
    }
    
    
    // MARK: 페이스북 로그인
    @IBAction func facebookBtnTapped(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: ["public_profile"], from: self) { result, error in
//            print("페이스북 로그인 성공")
            if let token = AccessToken.current, !token.isExpired {
//                UserDefaults.standard.setValue(token, forKey: "hasToken")
                print("페이스북 로그인 token → \(token)")
            }
            Profile.loadCurrentProfile { profile, error in
                guard let userName = profile?.name else { return }
                print("UserName(FB) → \(userName)")
            }
            
            if let error = error {
                print("페이스북 로그인 에러 → \(error)")
                return
            }
            guard let result = result else {
                print("페이스북 결괏값이 없습니다.")
                return
            }
            if result.isCancelled {
                print("사용자가 페이스북 로그인을 취소했습니다.")
                return
            }
        }
    }
    
    
    // MARK: 애플 로그인
    @IBAction func appleBtnTapped(_ sender: Any) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    
}


// MARK: 애플 로그인 설정
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    // Presentation context UI를 어디에 띄울지 가장 적합한 뷰 앵커를 반환함
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
    // 로그인 성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        
        print("Apple ID Credential User Identifier → \(appleIDCredential.user)")
        print("Apple ID Credential User Name → \(String(describing: appleIDCredential.fullName))")
        print("User Email → \(String(describing: appleIDCredential.email))")
    }
    
    // 로그인 시 에러
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Login Error → \(error)")
    }
    
}
