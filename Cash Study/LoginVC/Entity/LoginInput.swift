//
//  LoginInput.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

struct LoginInput {
    var email: String
    
    var toDictionary : [ String: Any] {
        let dict : [String: Any] = [
            "email" : self.email
        ]
        return dict
    }

}
