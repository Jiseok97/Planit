//
//  CheckTokenDataManager.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import Alamofire

class CheckTokenDataManager {
    func updateToken(_ info: RefreshTokenInput) {
        AF.request(Constant.BASE_URL + "/v1/auth/update-token", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: ["Content-type" : "application/json"])
            .validate()
            .responseDecodable(of: RefreshTokenEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    guard let accessToken = response.value?.accessToken else { return }
                    Constant.MY_ACCESS_TOKEN = accessToken
                    UserDefaults.standard.set(accessToken, forKey: "accessToken")
                    print("AccessToken 발급 성공")
                    
                default:
                    print("RefreshToken 갱신 || 발급이 필요합니다.")
                    
                }
            }
    }
}
