//
//  RecordPT.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/03.
//

import Foundation

struct recordPT:Identifiable,Hashable{
    let id = UUID().uuidString
    var exercise:String
    var number:String
    var set:String
    var weight:String
}
