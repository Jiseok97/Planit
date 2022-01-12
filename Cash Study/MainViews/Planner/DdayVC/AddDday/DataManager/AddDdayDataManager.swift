//
//  AddDdayDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/11.
//

import Alamofire

class AddDdayDataManager : UIViewController {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json"),
                               .init(name: "version", value: Constant.VERSION)]
    
    func addDday(_ info: AddDdayInput ,viewController: AddDdayViewController) {
        AF.request(Constant.BASE_URL + "/v1/dday", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: AddDdayEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 201:
                    self.dismissIndicator()
                    viewController.checkSuccess = true
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    Constant.DATE = ""
                    
                default:
                    // 커스텀 뷰 띄어주기
                    print("오류")
                }
            }
    }
}
