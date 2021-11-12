//
//  MyRequestInterceptor.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/12.
//

import Alamofire

final class MyRequestInterceptor: RequestInterceptor {
    let accessToken = UserDefaults.standard.string(forKey: "accessToken")
    let refreshToken = UserDefaults.standard.string(forKey: "refreshToken")
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(Constant.BASE_URL) == true,
              let accessToken = accessToken else {
                  completion(.success(urlRequest))
                  return
              }
        
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer" + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            print("Access Token 갱신 불필요 || 에러")
            completion(.doNotRetryWithError(error))
            return
        }
        print("Access Token 갱신 중...")
        let input = RefreshTokenInput(refreshToken: refreshToken ?? "")
        AF.request(Constant.BASE_URL + "/v1/auth/update-token", method: .post, parameters: input.toDictionary, encoding: JSONEncoding.default, headers: ["Content-type" : "application/json"])
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
