//
//  DeleteDdayDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/22.
//

import Alamofire

class DeleteDdayDataManager {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json"),
                               .init(name: "version", value: Constant.VERSION)]
    
    func deleteDday(id: Int, viewController: AddDdayViewController) {
        AF.request(Constant.BASE_URL + "/v1/dday/\(id)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .response { response in
                let code = response.response?.statusCode
                
                switch code {
                case 204:
                    viewController.checkSuccess = true
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    
                    
                default:
                    print("오류")
                }
            }
    }
}

