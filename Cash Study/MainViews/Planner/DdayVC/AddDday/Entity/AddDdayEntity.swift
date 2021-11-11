//
//  AddDdayEntity.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/11.
//

struct AddDdayEntity : Decodable {
    var id: Int
    var title : String
    var isRepresentative : Bool
    var endAt: String
    var createdAt: String
    var color: String

}
