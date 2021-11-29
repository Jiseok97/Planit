//
//  ShowUserInfoEntity.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

struct ShowUserInfoEntity : Decodable {
    var id: Int
    var email: String
    var name: String
    var nickname: String
    var sex: String
    var birth: String
    var category: String
}
