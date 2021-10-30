//
//  UserEntity.swift
//  Planit
//
//  Created by 이지석 on 2021/10/30.
//

struct UserEntity: Decodable {
    static var email : String = ""
    static var name: String = ""
    static var nickname: String = ""
    static var sex: String = ""
    static var birth: String = ""
    static var category: String = ""
    static var personalInfoMationAgree: Bool = false
    static var marketingInfoMationAgree: Bool = false
    static var receiverNickname: String = ""
}
