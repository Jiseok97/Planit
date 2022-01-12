//
//  ChangePointDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/16.
//

import Alamofire

class ChangePointDataManager: UIViewController {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json"),
                               .init(name: "version", value: Constant.VERSION)]
    
    func changePoint(viewController: RewardMainViewController) {
        AF.request(Constant.BASE_URL + "/v1/reward/convert-star-to-point", method: .put, headers: header)
            .validate()
            .responseDecodable(of: ChangePointEntity.self) { response in
                let code = response.response?.statusCode
                switch code {
                case 200:
                    self.dismissIndicator()
                    // UI 업데이트 Observer
                    NotificationCenter.default.post(name: NSNotification.Name("reloadReward"), object: nil)
                    // 포인트 획득 팝업 Observer
                    NotificationCenter.default.post(name: NSNotification.Name("successChangeReward"), object: nil)
                    
                    print("성공")
                    
                default:
                    self.dismissIndicator()
                    print("별 부족")
                    
                }
            }
    }
}
