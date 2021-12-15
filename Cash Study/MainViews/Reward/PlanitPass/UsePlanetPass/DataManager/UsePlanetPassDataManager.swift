//
//  UsePlanetPassDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/16.
//

import Alamofire

class UsePlanetPassDataManager {
    func usePlanetPass(planetId: Int, viewController: PlanitPassViewController) {
        AF.request(Constant.BASE_URL + "/v1/reward/star-with-ad/\(planetId)", method: .post, headers: ["Content-type" : "application/json"])
            .validate()
            .responseDecodable(of: UsePlanetPassEntity.self) { response in
                let code = response.response?.statusCode
                if code == 200 {
                    print("성공")
                } else {
                    return
                }
            }
    }
}
