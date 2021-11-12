//
//  RefreshTokenInput.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

struct RefreshTokenInput {
    var refreshToken: String
    
    var toDictionary : [ String: Any] {
        let dict : [String: Any] = [
            "refreshToken" : self.refreshToken
        ]
        return dict
    }

}
