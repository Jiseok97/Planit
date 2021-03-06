//
//  ShowDateStudyDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/25.
//

import Alamofire

class ShowDateStudyDataManager {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json"),
                               .init(name: "version", value: Constant.VERSION)]
    
    // MARK: For Home ViewController
    func homeStudy(date: String, viewController: HomeViewController) {
        AF.request(Constant.BASE_URL + "/v1/study/list/\(date)", method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ShowDateStudyEntity.self) { response in
                guard let data = response.value else { return }
                
                viewController.homeStudy(result: data)
            }
    }
    
    
    // MARK: For Planner Page ViewController
    func showStudy(date: String, viewController: PlannerPageViewController) {
        AF.request(Constant.BASE_URL + "/v1/study/list/\(date)", method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ShowDateStudyEntity.self) { response in
                guard let data = response.value else { return }
                
                viewController.showStudy(result: data)
            }
    }
}
