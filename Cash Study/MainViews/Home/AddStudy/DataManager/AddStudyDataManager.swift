//
//  AddStudyDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/19.
//

import Alamofire

 class AddStudyDataManager {
     let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                                .accept("application/json")]

     func singleStudy(_ info: SingleStudyInput, viewController : AddStudyViewController) {
         AF.request(Constant.BASE_URL + "/v1/study", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
             .validate()
             .responseDecodable(of: AddStudyEntity.self) { response in
                 let code = response.response?.statusCode

                 switch code {
                 case 201:
                     viewController.checkSuccess = true
                     NotificationCenter.default.post(name: NSNotification.Name("addStudy"), object: nil)

                 case 409:
                     print("동일한 공부 제목이 이미 존재")

                 default:
                     print("잘못된 요청 형식")
                 }


             }
     }


     func repeatStudy(_ info: RepeatStudyInput, viewController: AddStudyViewController) {
         AF.request(Constant.BASE_URL + "/v1/study", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
             .validate()
             .responseDecodable(of: AddStudyEntity.self) { response in
                 let code = response.response?.statusCode

                 switch code {
                 case 201:
                     viewController.checkSuccess = true
                     NotificationCenter.default.post(name: NSNotification.Name("addStudy"), object: nil)
                     print("Repeat study added!")

                 case 409:
                     print("동일한 공부 제목이 존재")

                 default:
                     print("잘못된 요청 형식")
                 }
             }
     }
 }
