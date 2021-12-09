//
//  DailyReportEntity.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/09.
//

struct DailyReportEntity : Decodable {
    var reports : [dailyReport]
    var totalStudies : Int
    var doneStudies : Int
}

struct dailyReport : Decodable {
    var studyId : Int
    var createdAt: String
    var recordedTime : Int
    var title : String
}
