//
//  HaveReceiverInput.swift
//  Planit
//
//  Created by 이지석 on 2021/11/01.
//

struct HaveReceiverInput {
    var email: String
    var name: String
    var nickname: String
    var sex: String?
    var birth: String
    var category: String
    var personalInformationAgree : Bool
    var marketingInformationAgree : Bool
    var receiverNickname : String
    var device : String
    
    var toDictionary : [ String: Any] {
        
        let dict : [String: Any] = [
            "email" : self.email,
            "name" : self.name,
            "nickname" : self.nickname,
            "sex" : self.sex,
            "birth" : self.birth,
            "category" : self.category,
            "personalInformationAgree" : self.personalInformationAgree,
            "marketingInformationAgree" : self.marketingInformationAgree,
            "receiverNickname" : self.receiverNickname,
            "device" : self.device
        ]
        
        return dict
    }

}
