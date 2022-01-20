//
//  EditUserInfoDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

import Alamofire

class EditUserInfoDataManager : UIViewController {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json"),
                               .init(name: "version", value: Constant.VERSION)]
    
    func editUserInfo(_ info: EditUserInfoInput, viewController: EditUserInfoViewController) {
        AF.request(Constant.BASE_URL + "/v1/user", method: .put, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ShowUserInfoEntity.self) { response in
                let statusCode = response.response?.statusCode
                
                switch statusCode {
                case 200:
                    self.dismissIndicator()
                    viewController.isSuccess = true
                    NotificationCenter.default.post(name: NSNotification.Name("EditUserInfo"), object: nil)
                    print("유저 정보 변경 성공")
                    
                default:
                    self.dismissIndicator()
                    viewController.nicknameError = true
  
                }
            }
    }
}
