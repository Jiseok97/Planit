//
//  HaveReceiverDataManager.swift
//  Planit
//
//  Created by 이지석 on 2021/11/01.
//

import Alamofire

class HaveReceiverDataManager : UIViewController {
    func user(_ info: HaveReceiverInput ,viewController: InputRecommenderViewController) {
        AF.request(Constant.BASE_URL + "/v1/user", method: .post, parameters: info.toDictionary, encoding: JSONEncoding.default, headers: ["Content-type" : "application/json"])
            .validate()
            .responseDecodable(of: HaveReceiverEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 201:
                    guard let email = response.value?.email else { return }
                    guard let name = response.value?.name else { return }
                    guard let nickname = response.value?.nickname else { return }
                    guard let sex = response.value?.sex else { return }
                    guard let birth = response.value?.birth else { return }
                    guard let job = response.value?.category else { return }
                    guard let accessToken = response.value?.accessToken else { return }
                    guard let refreshToken = response.value?.refreshToken else { return }
                    
                    Constant.MY_ID = response.value?.id ?? 0
                    Constant.MY_EMAIL = email
                    Constant.MY_NAME = name
                    Constant.MY_NICKNAME = nickname
                    Constant.MY_SEX = sex
                    Constant.MY_BIRTH = birth
                    Constant.MY_JOB = job
                    Constant.MY_ACCESS_TOKEN = accessToken
                    Constant.MY_REFRESH_TOKEN = refreshToken
                    
                    self.sethiddenLblImg(viewController.errorImageView, viewController.errorLbl)
                    viewController.checkUser = true
                    print("회원가입 성공!")
                    
                case 404:
                    viewController.checkUser = false
                    self.setShowErrorLblImg(viewController.errorImageView, viewController.errorLbl, "닉네임이 존재하지 않습니다.")
                    print("닉네임이 존재하지 않습니다.")

                case 409:
                    viewController.checkUser = false
                    self.setShowErrorLblImg(viewController.errorImageView, viewController.errorLbl, "이미 사용중인 이메일입니다.")
                    print("이미 사용중인 이메일입니다.")

                default:
                    print("서버 요청 형식이 잘못되었습니다.")
                }
            }
    }
}