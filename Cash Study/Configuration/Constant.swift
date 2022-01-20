//
//  Constant.swift
//  Planit
//
//  Created by 이지석 on 2021/10/30.
//

import Alamofire

struct Constant {
//    static let BASE_URL : String = "https://api.planit-study.com"
//    static let VERSION : String = "0.1.0"
    
    static let BASE_URL : String = "https://dev-api.planit-study.com"
    static let VERSION : String = "0.1.0.dev"
    
    
    /// User Informaition
    static var MY_ID : Int = 0
    static var MY_EMAIL : String = ""
    static var MY_NAME : String = ""
    static var MY_NICKNAME : String = ""
    static var MY_SEX : String = ""
    static var MY_BIRTH : String = ""
    static var MY_JOB: String = ""
    static var MY_ACCESS_TOKEN : String = ""
    static var MY_REFRESH_TOKEN : String = ""
    
    
    /// For Calendar
    static var DATE_TEXT : String = ""
    static var DATE : String = ""
    static var END_DATE : String = ""
    static var START_AT : String = ""
    static var END_AT : String = ""
}
