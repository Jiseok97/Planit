//
//  ShowDdayDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/15.
//

import Alamofire

class ShowDdayDataManager {    
    var header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json"),
                               .init(name: "version", value: Constant.VERSION)]
    
    
    func showDday(viewController: DdayPageViewController) {
        AF.request(Constant.BASE_URL + "/v1/dday", method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ShowDdayEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    guard let data = response.value else { return }
                    viewController.showDday(result: data)
                    
                default:
                    print("오류")
                    
                }
            }
    }
    
    
    func showHomeDday(viewController: HomeViewController) {
        AF.request(Constant.BASE_URL + "/v1/dday", method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ShowDdayEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    guard let data = response.value else { return }
                    viewController.showRepresentDday(result: data)
                    
                default:
                    print("오류")
                    
                }
            }
    }
}

