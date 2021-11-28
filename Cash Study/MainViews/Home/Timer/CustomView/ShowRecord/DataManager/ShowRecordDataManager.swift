//
//  ShowRecordDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

import Alamofire

class ShowRecordDataManager {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json")]
    
    func showRecord(stId: Int, viewController: TimerViewController) {
        AF.request(Constant.BASE_URL + "/v1/study/record/\(stId)", method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ShowRecordEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    guard let data = response.value else { return }
//                    viewController.showDday(result: data)
                    
                default:
                    print("오류")
                    
                }
            }
    }
}
