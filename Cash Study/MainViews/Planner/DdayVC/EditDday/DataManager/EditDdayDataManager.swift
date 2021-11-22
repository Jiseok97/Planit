//
//  EditDdayDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/22.
//

import Alamofire

class EditDdayDataManager {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json")]
    
    func editDday(id: Int, _ info: EditDdayInput ,viewController: AddDdayViewController) {
        AF.request(Constant.BASE_URL + "/v1/dday/\(id)", method: .put, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: EditDdayEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    print("편집완료")
                    viewController.checkSuccess = true
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    
                default:
                    // 커스텀 뷰 띄어주기
                    print("오류")
                }
            }
    }
}
