//
//  DailyReportDataManager.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/09.
//

import Alamofire

class DailyReportDataManager {
    let header: HTTPHeaders = [.authorization(bearerToken: Constant.MY_ACCESS_TOKEN),
                               .accept("application/json"),
                               .init(name: "version", value: Constant.VERSION)]
    
    func showDailyReport(date: String, viewController: DailyReportViewController) {
        AF.request(Constant.BASE_URL + "/v1/study/daily-report/\(date)", method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: DailyReportEntity.self) { response in
                guard let data = response.value else { return }
                
                viewController.showDailyReport(result: data)
                
            }
    }
}
