//
//  PlanitPassInfoEntity.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/13.
//

struct PlanitPassInfoEntity: Decodable {
    var planets: [pInfo]
}

struct pInfo : Decodable {
    var planetId: Int
    var name: String
    var description: String
}
