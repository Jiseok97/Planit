//
//  AddDdayDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/11.
//

import Alamofire

class AddDdayDataManager {
    let vc = DdayPageViewController()
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json")]
    
    func addDday(_ info: AddDdayInput ,viewController: AddDdayViewController) {
        AF.request(Constant.BASE_URL + "/v1/dday", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: AddDdayEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 201:
                    print("생성완료")
                    vc.dDayCV.reloadData()
                    
                default:
                    print("오류")
                    
                }
            }
    }
}
