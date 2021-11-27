//
//  ShowDateStudyEntity.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/25.
//

struct ShowDateStudyEntity : Decodable {
    var nickname : String
    var studies : [study]
}

struct study : Decodable {
    var studyGroupId : Int
    var studyScheduleId : Int
    var studyId : Int
    var title : String
    var isDone : Bool
    var startAt : String
    var endAt: String
    var repeatedDays : [String]?
    var rest : Int
    var recordedTime : Int
}
