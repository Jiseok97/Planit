//
//  HaveReceiverDataManager.swift
//  Planit
//
//  Created by 이지석 on 2021/11/01.
//

import Alamofire

class HaveReceiverDataManager : UIViewController {
    let header: HTTPHeaders = [.accept("application/json"),
                               .init(name: "version", value: Constant.VERSION) ]
    
    func user(_ info: HaveReceiverInput ,viewController: InputRecommenderViewController) {
        AF.request(Constant.BASE_URL + "/v1/user", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: HaveReceiverEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 201:
                    self.dismissIndicator()
                    guard let id = response.value?.id else { return }
                    guard let email = response.value?.email else { return }
                    guard let name = response.value?.name else { return }
                    guard let nickname = response.value?.nickname else { return }
                    guard let sex = response.value?.sex else { return }
                    guard let birth = response.value?.birth else { return }
                    guard let job = response.value?.category else { return }
                    guard let accessToken = response.value?.accessToken else { return }
                    guard let refreshToken = response.value?.refreshToken else { return }
                    
                    Constant.MY_ID = id
                    Constant.MY_EMAIL = email
                    Constant.MY_NAME = name
                    Constant.MY_NICKNAME = nickname
                    Constant.MY_SEX = sex
                    Constant.MY_BIRTH = birth
                    Constant.MY_JOB = job
                    Constant.MY_ACCESS_TOKEN = accessToken
                    Constant.MY_REFRESH_TOKEN = refreshToken
                    
                    self.sethiddenLblImg(viewController.errorImageView, viewController.errorLbl)
                    UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
                    
                    self.changeRootVC(BaseTabBarController())
                    
                    
                case 404:
                    self.dismissIndicator()
                    self.setShowErrorLblImg(viewController.errorImageView, viewController.errorLbl, "닉네임이 존재하지 않습니다.")

                case 409:
                    self.dismissIndicator()
                    self.setShowErrorLblImg(viewController.errorImageView, viewController.errorLbl, "이미 사용중인 이메일입니다.")
                    
                default:
                    self.dismissIndicator()
                    print("서버 요청 형식이 잘못되었습니다.")
                }
            }
    }
}
