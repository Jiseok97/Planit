//
//  LoginDataManager.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import Alamofire

class LoginDataManager : UIViewController{
    func userLogin(_ info: LoginInput ,viewController: LoginViewController) {
        AF.request(Constant.BASE_URL + "/v1/auth/login", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: ["Content-type" : "application/json"])
            .validate()
            .responseDecodable(of: LoginEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    guard let result = response.value?.result else { return }
                    guard let accessToken = response.value?.accessToken else { return }
                    guard let refreshToken = response.value?.refreshToken else { return }
                    
                    if result {
                        print("기존 유저")
                        self.changeRootVC(BaseTabBarController())
                        Constant.MY_ACCESS_TOKEN = accessToken
                        Constant.MY_REFRESH_TOKEN = refreshToken
                        
                        UserDefaults.standard.set(accessToken, forKey: "accessToken")
                        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
                        
                        print("accessToekn ▾")
                        print(accessToken)
                        print("refreshToken ▾")
                        print(refreshToken)
                        
                    } else {
                        print("신규 유저")
                        self.changeRootVC(TermsOfUseViewController())
                    }
                    
                default:
                    print("오류")
                    
                }
            }
    }
}
