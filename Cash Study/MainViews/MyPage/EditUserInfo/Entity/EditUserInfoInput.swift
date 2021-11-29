//
//  EditUserInfoInput.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

struct EditUserInfoInput {
    var name : String
    var nickname: String
    var category: String
    
    var toDictionary : [ String: Any] {
        let dict : [String: Any] = [
            "name" : self.name,
            "nickname" : self.nickname,
            "category" : self.category
        ]
        return dict
    }

}
