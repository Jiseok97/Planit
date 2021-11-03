//
//  LoginDataManager.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import Alamofire

class LoginDataManager {
    func userLogin(_ info: LoginInput ,viewController: LoginViewController) {
        AF.request(Constant.BASE_URL + "/v1/auth/login", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: ["Content-type" : "application/json"])
            .validate()
            .responseDecodable(of: LoginEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    viewController.haveEmail = true
                    print("로그인 API")
                    
                default:
                    print("오류")
                    
                }
            }
    }
}
