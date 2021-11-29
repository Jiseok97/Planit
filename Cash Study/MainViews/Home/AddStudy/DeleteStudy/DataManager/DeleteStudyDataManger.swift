//
//  DeleteStudyDataManger.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/28.
//

import Alamofire

 class DeleteStudyDataManager {
     let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                                .accept("application/json")]

     func deleteStudy(stGroupId: Int, viewController : AddStudyViewController) {
         AF.request(Constant.BASE_URL + "/v1/study/\(stGroupId)", method: .delete, encoding: JSONEncoding.default, headers: header)
             .validate()
             .response { response in
                 let code = response.response?.statusCode
                 
                 switch code {
                 case 204:
                     viewController.checkSuccess = true
                     NotificationCenter.default.post(name: NSNotification.Name("reloadStudy"), object: nil)
                     NotificationCenter.default.post(name: NSNotification.Name("selectToday"), object: nil)
                     
                 default:
                     print("오류")
                 }
             }
     }
 }
