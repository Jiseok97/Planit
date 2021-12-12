//
//  ShowRecordEntity.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

struct ShowRecordEntity : Decodable {
    var id: Int
    var isDone: Bool
    var startAt: String
    var recordedTime: Int
    var rest: Int
}

