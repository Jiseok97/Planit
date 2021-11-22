//
//  EditDdayInput.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/22.
//

struct EditDdayInput {
    var title: String
    var endAt: String
    var icon: String
    var isRepresentative: Bool
    
    var toDictionary : [ String: Any] {
        let dict : [String: Any] = [
            "title" : self.title,
            "endAt" : self.endAt,
            "icon" : self.icon,
            "isRepresentative" : self.isRepresentative
        ]
        return dict
    }

}

