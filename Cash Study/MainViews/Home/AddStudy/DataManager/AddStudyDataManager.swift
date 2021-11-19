//
//  AddStudyDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/19.
//

import Alamofire

 class AddStudyDataManager {
     let header: HTTPHeaders = [.authorization(bearerToken: "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjgzLCJpYXQiOjE2MzczMTA2OTcsImV4cCI6MTYzNzM5NzA5N30.NHuDG2-p7KNsMp0rEFENdXNo0j1syUxKb6i8s8LcxX0"), .accept("application/json")]

     func singleStudy(_ info: SingleStudyInput, viewController : AddStudyViewController) {
         AF.request(Constant.BASE_URL + "/v1/study", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
             .validate()
             .responseDecodable(of: AddStudyEntity.self) { response in
                 let code = response.response?.statusCode

                 switch code {
                 case 201:
                     print("성공")

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
                     print("성공")

                 case 409:
                     print("동일한 공부 제목이 존재")

                 default:
                     print("잘못된 요청 형식")
                 }
             }
     }
 }
