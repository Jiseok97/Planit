//
//  CheckTokenDataManager.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import Alamofire

class CheckTokenDataManager {
    let header: HTTPHeaders = [.accept("application/json")]
    
    func updateToken(_ info: RefreshTokenInput, viewController: LoginViewController) {
        AF.request(Constant.BASE_URL + "/v1/auth/update-token", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: RefreshTokenEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    guard let accessToken = response.value?.accessToken else { return }
                    Constant.MY_ACCESS_TOKEN = accessToken
//                    viewController.haveToken = true
                    print("AccessToken 발급 성공")
                    
                default:
                    
                    print("RefreshToken 갱신 || 발급이 필요합니다.")
                    
                }
            }
    }
}
