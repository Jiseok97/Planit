//
//  LoginViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/13.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

// iOS 13버전부터 Apple Login 지원
@available(iOS 13.0, *)
class LoginViewController: UIViewController {
    
    @IBOutlet weak var kakaoLoginView: UIView!
    @IBOutlet weak var appleLoginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    
    // MARK: Set UI
    func setUI() {
        kakaoLoginView.layer.cornerRadius = 6
        appleLoginView.layer.cornerRadius = 6
    }
    
    
    // MARK: Kakao Login Btn
    @IBAction func kakaoBtnTapped(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print("카카오 임시 로그인 에러 발생 → \(error)")
                }
                else {
                    // 로그인 성공
                    print("loginWithKakaoAccount() success.")
                    
                    _ = oauthToken
                    
                    self.getUserInfo()
                    
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
                _ = user
                
                guard let userEmail = user?.kakaoAccount?.email else { return }
                Constant.MY_EMAIL = userEmail
                UserInfoData.email = userEmail
                
                self.loginCheck(userEmail)
            }
        }
    }
    
    func loginCheck(_ email: String) {
        let input = LoginInput(email: email)
        LoginDataManager().userLogin(input, viewController: self)
    }
    
    // MARK: 애플 로그인
    @IBAction func appleBtnTapped(_ sender: Any) {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
        
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
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
        
        guard let email = appleIDCredential.email else { return }
        
        UserInfoData.email = email
        
        print("Apple ID Credential User Identifier → \(appleIDCredential.user)")
        print("Apple ID Credential User Name → \(String(describing: appleIDCredential.fullName))")
        print("User Email → \(String(describing: appleIDCredential.email))")
        
        self.loginCheck(email)
    }
    
    // 로그인 시 에러
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Login Error → \(error)")
    }
    
}
