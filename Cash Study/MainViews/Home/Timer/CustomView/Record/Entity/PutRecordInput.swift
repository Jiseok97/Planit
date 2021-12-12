//
//  PutRecordInput.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

struct PutRecordInput {
    var isDone : Bool
    var star : Int
    var planetPass: Int
    var rest : Int
    var recordedTime : Int
    
    var toDictionary : [ String: Any] {
        let dict : [String: Any] = [
            "isDone" : self.isDone,
            "star" : self.star,
            "planetPass" : self.planetPass,
            "rest" : self.rest,
            "recordedTime" : self.recordedTime
        ]
        return dict
    }

}
