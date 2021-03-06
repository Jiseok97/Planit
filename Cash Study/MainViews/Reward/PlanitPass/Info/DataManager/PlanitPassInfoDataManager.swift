//
//  PlanitPassInfoDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/13.
//

import Alamofire

class PlanitPassInfoDataManager {
    let header: HTTPHeaders = [ .accept("application/json"),
                                .init(name: "version", value: Constant.VERSION) ]
    
    func showPassInfo(viewController: PlanitPassViewController) {
        AF.request(Constant.BASE_URL + "/v1/reward/planet", method: .get, headers: header)
            .validate()
            .responseDecodable(of: PlanitPassInfoEntity.self) { response in
                let code = response.response?.statusCode
                if code == 200 {
                    guard let data = response.value else { return }
                    print("데이터 가져오기 성공")
                    viewController.showPassInfo(result: data)
                } else {
                    return
                }
            }
    }
}
