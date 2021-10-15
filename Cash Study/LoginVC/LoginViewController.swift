//
//  LoginViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/13.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

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

            }
        }
    }
    
    
}
