//
//  ShowUserRewardDataManger.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/12.
//

import Alamofire

class ShowUserRewardDataManager : UIViewController {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json"),
                               .init(name: "version", value: Constant.VERSION)]
    
    // MARK: For Home ViewController
    func showReward(viewController: RewardMainViewController) {
        AF.request(Constant.BASE_URL + "/v1/reward", method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ShowUserRewardEntity.self) { response in
                self.dismissIndicator()
                guard let data = response.value else { return }
                
                viewController.showReward(result: data)
            }
    }
}
