//
//  NickNameDataManager.swift
//  Planit
//
//  Created by 이지석 on 2021/10/30.
//

import Alamofire

class NickNameDataManager : UIViewController {
    func validateNickName(_ nickName: nickNameInput, viewController: InputNameViewController) {

        guard let img = viewController.nickNameError else { return }
        guard let lbl = viewController.nickNameErrorLbl else { return }
        guard let userName = viewController.nameTF.text else { return }
        guard let userNickName = viewController.nickNameTF.text else { return }
        
        AF.request(Constant.BASE_URL + "/v1/user/validate-nickname", method: .get, parameters: nickName)
            .validate()
            .responseDecodable(of: nickNameEntity.self) { response in
                let statusCode = response.response?.statusCode
                
                switch statusCode {
                
                case 200:
                    viewController.sethiddenLblImg(img, lbl)
                    viewController.checkUserNickName = true
                    UserEntity.name = userName
                    UserEntity.nickname = userNickName
                    print("사용 가능한 닉네임입니다. → \(String(describing: statusCode))")
                    
                case 409:
                    viewController.checkUserNickName = false
                    viewController.setShowLblImg(img, lbl)
                    print("이미 중복된 닉네임입니다. → \(String(describing: statusCode))")
 
                default:
                    print("서버 응답이 없습니다.")
  
                }
            }
    }
}
