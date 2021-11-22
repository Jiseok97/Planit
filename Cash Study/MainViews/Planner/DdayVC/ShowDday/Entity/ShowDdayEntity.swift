//
//  ShowDdayEntity.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/15.
//

struct ShowDdayEntity : Decodable {
    var ddays : [dday]
}

struct dday : Decodable {
    var id : Int
    var title : String
    var isRepresentative : Bool
    var endAt : String
    var createdAt : String
    var icon : String
}
