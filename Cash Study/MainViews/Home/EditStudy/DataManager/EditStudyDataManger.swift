//
//  EditStudyDataManger.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/28.
//

import Alamofire

 class EditStudyDataManager {
     let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                                .accept("application/json")]

     func editSingleStudy(stGroupId: Int, stScheduleId: Int, _ info: EditStudyInput, viewController : AddStudyViewController) {
         AF.request(Constant.BASE_URL + "/v1/study/\(stGroupId)/\(stScheduleId)", method: .put, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
             .validate()
             .responseDecodable(of: EditStudyEntity.self) { response in
                 let code = response.response?.statusCode

                 switch code {
                 case 200:
                     viewController.checkSuccess = true
                     print("수정 완료")
                     
                 case 409:
                     viewController.isAlreadyExist = true
                     print("동일한 공부 제목이 이미 존재")

                 default:
                     print("잘못된 요청 형식")
                     print(response.value?.message)
                 }
            }
     }

 }
