//
//  LoginEntity.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

struct LoginEntity: Decodable {
    var result : Bool
    var accessToken : String
    var refreshToken : String
}
