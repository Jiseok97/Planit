//
//  AddDdayInput.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/11.
//

struct AddDdayInput {
    var title: String
    var endAt: String
    var color: String
    var isRepresentative: Bool
    
    var toDictionary : [ String: Any] {
        let dict : [String: Any] = [
            "title" : self.title,
            "endAt" : self.endAt,
            "color" : self.color,
            "isRepresentative" : self.isRepresentative
        ]
        return dict
    }

}
