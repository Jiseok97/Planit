//
//  LoginViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/13.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import AuthenticationServices

// iOS 13버전부터 Apple Login 지원
@available(iOS 13.0, *)
class LoginViewController: UIViewController {
    
    @IBOutlet weak var kakaoLoginView: UIView!
    @IBOutlet weak var appleLoginView: UIView!
    @IBOutlet weak var appleLoginBtn: UIButton!
    @IBOutlet weak var logoImgView: UIImageView!
    
//    var haveToken : Bool = false {
//        didSet {
//            changeRootVC(BaseTabBarController())
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
//        guard let rfToken = UserDefaults.standard.string(forKey: "refreshToken") else { return }
//        print("rfToken = \(rfToken)")
//        if rfToken != "" {
//            let input = RefreshTokenInput(refreshToken: rfToken)
//            CheckTokenDataManager().updateToken(input, viewController: self)
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// Kakao auto login
        if(AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() {
                        // Need login
                        return
                    } else {
                        // get error
                        return
                    }
                } else {
                    self.getUserInfo()
                }
            }
        } else {
            // Need login
            return
        }
        
    }
    
    // MARK: Functions
    func setUI() {
        kakaoLoginView.layer.cornerRadius = 6
        appleLoginView.layer.cornerRadius = 6
    }
    
    // MARK: - Kakao Login
    @IBAction func kakaoBtnTapped(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("KakaoTalk Login error → \(error)")
                } else {
                    print("Success kakaoTalk Login")
                    _ = oauthToken
                    self.getUserInfo()
                    print("GetUserInfo")
                }
            }
            
            
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print("카카오 임시 로그인 에러 발생 → \(error)")
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    _ = oauthToken

                    self.getUserInfo()
                }
            }
        }
    }
    
    
    func getUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                _ = user
                
                guard let userEmail = user?.kakaoAccount?.email else { return }
                guard let userName = user?.kakaoAccount?.profile?.nickname else { return }
                
                Constant.MY_EMAIL = userEmail
                Constant.MY_NAME = userName
                UserInfoData.email = userEmail
                UserInfoData.name = userName
                
                self.loginCheck(userEmail)
            }
        }
    }
    
    func loginCheck(_ email: String) {
        let input = LoginInput(email: email)
        showIndicator()
        LoginDataManager().userLogin(input, viewController: self)
    }
    
    
    // MARK: About Apple Login
    @IBAction func appleBtnTapped(_ sender: Any) {
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
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            guard let userName = appleIDCredential.fullName else { return }
            
            UserDefaults.standard.set(userIdentifier, forKey: "appleIdentifier")
            UserDefaults.standard.set(String(describing: userName), forKey: "appleName")
            
            UserInfoData.email = userIdentifier
            UserInfoData.name = String(describing: userName)
//            print("userIdentifier = \(userIdentifier)")
            loginCheck(userIdentifier)
            
        default:
            break
        }
        
    }
    
    // 로그인 시 에러
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        return
    }
    
}
