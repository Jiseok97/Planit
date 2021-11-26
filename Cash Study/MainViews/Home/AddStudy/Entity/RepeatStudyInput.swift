//
//  RepeatStudyInput.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/19.
//

struct RepeatStudyInput {
     var title: String
     var startAt: String
     var endAt : String
     var repeatedDays : [String]

     var toDictionary : [ String: Any] {
         let dict : [String: Any] = [
             "title" : self.title,
             "startAt" : self.startAt,
             "endAt" : self.endAt,
             "repeatedDays" : self.repeatedDays
         ]
         return dict
     }

 }
