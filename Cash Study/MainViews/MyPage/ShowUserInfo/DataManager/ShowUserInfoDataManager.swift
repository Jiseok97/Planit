//
//  ShowUserInfoDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

import Alamofire

class ShowUserInfoDataManager : UIViewController {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json"),
                               .init(name: "version", value: Constant.VERSION)]
    
    func showUserInfo(viewController: MyPageViewController) {
        AF.request(Constant.BASE_URL + "/v1/user", method: .get, headers: header)
            .validate()
            .responseDecodable(of: ShowUserInfoEntity.self) { response in
                let statusCode = response.response?.statusCode
                
                switch statusCode {
                case 200:
                    self.dismissIndicator()
                    guard let data = response.value else { return }
                    viewController.showUserInfo(result: data)
                    
                default:
                    self.dismissIndicator()
                    print("토큰 만료.")
  
                }
            }
    }
    
    
    func showUserInfoEditVC(viewController: EditUserInfoViewController) {
        AF.request(Constant.BASE_URL + "/v1/user", method: .get, headers: header)
            .validate()
            .responseDecodable(of: ShowUserInfoEntity.self) { response in
                let statusCode = response.response?.statusCode
                
                switch statusCode {
                case 200:
                    self.dismissIndicator()
                    guard let data = response.value else { return }
                    viewController.showUserInfo(result: data)
                    
                default:
                    self.dismissIndicator()
                    print("토큰 만료.")
  
                }
            }
    }
}
