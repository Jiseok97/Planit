//
//  EditStudyInput.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/28.
//

struct EditStudyInput {
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
