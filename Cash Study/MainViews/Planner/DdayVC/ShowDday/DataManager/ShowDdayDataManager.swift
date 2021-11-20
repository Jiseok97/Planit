//
//  ShowDdayDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/15.
//

import Alamofire

class ShowDdayDataManager {    
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json")]
    
    func addDday(viewController: DdayPageViewController) {
        AF.request(Constant.BASE_URL + "/v1/dday", method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ShowDdayEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    guard let result = response.value?.ddays else { return }
                    guard let data = response.value else { return }
                    print("Success → Bring dday data")
                    print(result)
                    viewController.showDday(result: data)
                    
                default:
                    print("오류")
                    
                }
            }
    }
}

