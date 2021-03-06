//
//  PutRecordDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

import Alamofire

class PutRecordDataManager : UIViewController {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json"),
                               .init(name: "version", value: Constant.VERSION)]
    
    func putRecord(_ info: PutRecordInput, stId: Int, viewController: StopTimerViewController) {
        AF.request(Constant.BASE_URL + "/v1/study/record/\(stId)", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ShowRecordEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    self.dismissIndicator()
                    print("성공")
                    
                case 409:
                    self.dismissIndicator()
                    print("이미 완료")
                    
                default:
                    print("오류")
                    
                }
            }
    }
}
