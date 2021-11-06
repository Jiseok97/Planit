//
//  noReceiverEntity.swift
//  Planit
//
//  Created by 이지석 on 2021/11/01.
//

struct noReceiverEntity: Decodable {
    var id: Int
    var email: String
    var name: String
    var nickname: String
    var sex: String
    var birth: String
    var category: String
    var accessToken: String
    var refreshToken: String
}
