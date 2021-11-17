//
//  ShowDdayDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/15.
//

import Alamofire

class ShowDdayDataManager {
    let header: HTTPHeaders = [.authorization(bearerToken: "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjgzLCJpYXQiOjE2MzY5NTU3MzYsImV4cCI6MTYzNzA0MjEzNn0.Us7KcwpitTcqaV0sgi4BKAqL0ngI06XC4Kqg2TvLFe0"),
                               .accept("application/json")]
    
//    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
//                               .accept("application/json")]
    
    // , completion: @escaping ([dday])->(Void)
    func addDday(viewController: DdayPageViewController) {
        AF.request(Constant.BASE_URL + "/v1/dday", method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ShowDdayEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    guard let result = response.value?.ddays else { return }
                    print("Success")
                    print(result)
                    viewController.DdayDataLst = result
//                    completion(result)
                    
                default:
                    print("오류")
                    
                }
            }
    }
}
