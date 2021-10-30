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
        
        AF.request(Constant.BASE_URL + "/v1/user/validate-nickname", method: .get, parameters: nickName)
            .validate()
            .responseDecodable(of: nickNameEntity.self) { response in
                let statusCode = response.response?.statusCode
                
                switch statusCode {
                
                case 200:
                    viewController.sethiddenLblImg(img, lbl)
                    
                    let sbName = UIStoryboard(name: "SelectGender", bundle: nil)
                    let sgSB = sbName.instantiateViewController(identifier: "SelectGenderViewController")
                    
                    print("성공입니다. → \(String(describing: statusCode))")
                    self.navigationController?.pushViewController(sgSB, animated: false)
                    
                case 409:
                    viewController.setShowLblImg(img, lbl)
                    print("이미 중복된 닉네임입니다. → \(String(describing: statusCode))")
                    
                    
                case .none: print("응답이 없습니다.")
                case .some(_): return
                    
                }
            }
    }
}
