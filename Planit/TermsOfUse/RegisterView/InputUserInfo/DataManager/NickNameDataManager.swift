//
//  NickNameDataManager.swift
//  Planit
//
//  Created by 이지석 on 2021/10/30.
//

import Alamofire

class NickNameDataManager : UIViewController {
    func validateNickName(_ nickName: nickNameInput, viewController: InputNameViewController) {
        AF.request(Constant.BASE_URL + "/v1/user/validate-nickname", method: .get, parameters: nickName)
            .validate()
            .responseDecodable(of: nickNameEntity.self) { response in
                let statusCode = response.response?.statusCode
                switch statusCode {
                case 200:
                    viewController.checkNickNameValue = true
                    self.setAbleBtn(viewController.nextBtn)
                    print("성공입니다. →\(String(describing: statusCode))")
                case 409:
                    viewController.checkNickNameValue = false
                    viewController.alreadyExistNickName()
                    self.setEnableBtn(viewController.nextBtn)
                    
                case .none: print("응답이 없습니다.")
                case .some(_): return
                }
            }
    }
}
