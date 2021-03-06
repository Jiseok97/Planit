//
//  NickNameDataManager.swift
//  Planit
//
//  Created by 이지석 on 2021/10/30.
//

import Alamofire

class NickNameDataManager : UIViewController {
    let header: HTTPHeaders = [.accept("application/json"),
                               .init(name: "version", value: Constant.VERSION) ]
    
    func validateNickName(_ nickName: nickNameInput, viewController: InputNameViewController) {

        guard let img = viewController.nickNameError else { return }
        guard let lbl = viewController.nickNameErrorLbl else { return }
        
        AF.request(Constant.BASE_URL + "/v1/user/validate-nickname", method: .get, parameters: nickName, headers: header)
            .validate()
            .responseDecodable(of: nickNameEntity.self) { response in
                let statusCode = response.response?.statusCode
                
                switch statusCode {
                
                case 200:
                    viewController.checkUserNickName = true
                    viewController.sethiddenLblImg(img, lbl)
                    viewController.nickNameErrorLbl.isHidden = false
                    viewController.nickNameErrorLbl.text = "사용 가능한 닉네임입니다."
                    
                case 409:
                    viewController.checkUserNickName = false
                    viewController.setShowErrorLblImg(img, lbl, "이미 사용중인 닉네임입니다.")
                    
                default:
                    print("서버 응답이 없습니다.")
  
                }
            }
    }
    
    
    
    func validateEditNickName(_ nickName: EditnicknameInput, viewController: EditUserInfoViewController) {

        guard let img = viewController.nicknameErrorImgView else { return }
        guard let lbl = viewController.nicknameErrorLbl else { return }
        
        AF.request(Constant.BASE_URL + "/v1/user/validate-nickname", method: .get, parameters: nickName, headers: header)
            .validate()
            .responseDecodable(of: nickNameEntity.self) { response in
                let statusCode = response.response?.statusCode
                
                switch statusCode {
                
                case 200:
                    viewController.sethiddenLblImg(img, lbl)
                    viewController.checkUserNickName = true
                    viewController.nicknameErrorLbl.isHidden = false
                    viewController.nicknameErrorLbl.text = "사용 가능한 닉네임입니다."
                    
                case 409:
                    viewController.checkUserNickName = false
                    viewController.setShowErrorLblImg(img, lbl, "이미 사용중인 닉네임입니다.")
 
                default:
                    print("서버 응답이 없습니다.")
  
                }
            }
    }
}
