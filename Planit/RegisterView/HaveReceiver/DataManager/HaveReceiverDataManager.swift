//
//  HaveReceiverDataManager.swift
//  Planit
//
//  Created by 이지석 on 2021/11/01.
//

import Alamofire

class HaveReceiverDataManager {
    func validateNickName(_ userInfo: HaveReceiverInput, _ viewController: InputRecommenderViewController) {
        
        AF.request(Constant.BASE_URL + "/v1/user", method: .get, parameters: userInfo)
            .validate()
            .responseDecodable(of: HaveReceiverEntity.self) { response in
                let statusCode = response.response?.statusCode
                
                switch statusCode {
                
                case 201:
                    print("회원가입 성공")
                    
                    
                case 409:
                    print("요청형식이 잘못되었습니다.")
                    
 
                default:
                    print("서버 응답이 없습니다.")
  
                }
            }
    }
}
