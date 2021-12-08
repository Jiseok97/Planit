//
//  EditStudyStatusDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/06.
//

import Alamofire

class EditStudyStatusDataManager: UIViewController {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json")]
    
    func editStatus(stId: Int, isDone: Bool, viewController: PlannerPageViewController) {
        AF.request(Constant.BASE_URL + "/v1/study/modify-status/\(stId)?isDone=\(isDone)", method: .patch, headers: header)
            .validate()
            .responseDecodable(of: EditStudyStatusEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    NotificationCenter.default.post(name: NSNotification.Name("reportDate"), object: nil)
                    self.dismissIndicator()
                    print("성공")
                    
                default:
                    self.dismissIndicator()
                    print("오류")
                    
                }
            }
    }
}
