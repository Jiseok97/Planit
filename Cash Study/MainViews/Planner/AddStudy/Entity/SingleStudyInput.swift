//
//  SingleStudyInput.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/19.
//

struct SingleStudyInput {
     var title: String
     var startAt: String

     var toDictionary : [ String: Any] {
         let dict : [String: Any] = [
             "title" : self.title,
             "startAt" : self.startAt
         ]
         return dict
     }

 }
