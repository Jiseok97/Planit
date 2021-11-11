//
//  AddDdayDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/11.
//

import Alamofire

class AddDdayDataManager {
    let header: HTTPHeaders = [.authorization(bearerToken: "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE4LCJpYXQiOjE2MzY2MjI4MjYsImV4cCI6MTYzNjcwOTIyNn0.cjtBTaQFmtO1aJrY3k_SWxf05_e68UhLYwly-0dixYs"),
                               .accept("application/json")]
    
//    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
//                               .accept("application/json")]
    
    func addDday(_ info: AddDdayInput ,viewController: AddDdayViewController) {
        AF.request(Constant.BASE_URL + "/v1/dday", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: AddDdayEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 201:
                    print("생성완료")
                    
                default:
                    print("오류")
                    
                }
            }
    }
}
