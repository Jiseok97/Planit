//
//  EditStudyDataManger.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/28.
//

import Alamofire

class EditStudyDataManager : UIViewController {
     let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                                .accept("application/json")]

     func editSingleStudy(stGroupId: Int, stScheduleId: Int, _ info: EditStudyInput, viewController : AddStudyViewController) {
         AF.request(Constant.BASE_URL + "/v1/study/\(stGroupId)/\(stScheduleId)", method: .put, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
             .validate()
             .responseDecodable(of: EditStudyEntity.self) { response in
                 let code = response.response?.statusCode

                 switch code {
                 case 200:
                     self.dismissIndicator()
                     viewController.checkSuccess = true
                     
                 case 409:
                     self.dismissIndicator()
                     viewController.isAlreadyExist = true

                 default:
                     print("잘못된 요청 형식")
                 }
            }
     }
     
     
     func editRepeatStudy(stGroupId: Int, stScheduleId: Int, _ info: EditRepeatStudyInput, viewController : AddStudyViewController) {
         AF.request(Constant.BASE_URL + "/v1/study/\(stGroupId)/\(stScheduleId)", method: .put, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
             .validate()
             .responseDecodable(of: EditStudyEntity.self) { response in
                 let code = response.response?.statusCode

                 switch code {
                 case 200:
                     self.dismissIndicator()
                     viewController.checkSuccess = true
                     viewController.editRpSuccess = true
                     
                 case 409:
                     self.dismissIndicator()
                     viewController.isAlreadyExist = true

                 default:
                     print("잘못된 요청 형식")
                     print(response.value?.message)
                 }
            }
     }

 }
