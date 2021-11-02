//
//  noReceiverDataManager.swift
//  Planit
//
//  Created by 이지석 on 2021/11/01.
//

import Alamofire
import SwiftyJSON
import Moya

class noReceiverDataManager {
    func user(_ info: noReceiverInput ,viewController: InputRecommenderViewController) {
        AF.request(Constant.BASE_URL + "/v1/user", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: ["Content-type" : "application/json"])
            .validate()
            .responseDecodable(of: noReceiverEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 201:
                    print("회원가입 성공!")

                case 404:
                    print("추천인을 찾을 수 없습니다.")

                case 409:
                    print("이미 사용중인 이메일 혹은 닉네임 입니다.")

                default:
                    print(code)
                    print(response.result)
                }
            }
    }
}

