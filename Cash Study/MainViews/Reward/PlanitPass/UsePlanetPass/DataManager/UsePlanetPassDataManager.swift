//
//  UsePlanetPassDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/16.
//

import Alamofire

class UsePlanetPassDataManager : UIViewController {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json"),
                               .init(name: "version", value: Constant.VERSION)]
    
    func usePlanetPass(planetId: Int, viewController: PlanitPassViewController) {
        AF.request(Constant.BASE_URL + "/v1/reward/star-with-ad/\(planetId)", method: .post, headers: header)
            .validate()
            .responseDecodable(of: UsePlanetPassEntity.self) { response in
                let code = response.response?.statusCode
                if code == 200 {
                    guard let data = response.value else { return }
                    
                    self.dismissIndicator()
                    viewController.usePlanetPass(result: data)
                    viewController.isSuccess = true
                } else {
                    self.dismissIndicator()
                    viewController.notEnough = true
                }
            }
    }
}
