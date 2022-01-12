//
//  UserListModel.swift
//  Salud0.2
//
//  Created by 이경민 on 2022/01/05.
//

import Foundation

struct UserListModel{
    var userImageString:String?
    var userName:String?
    var messageText:String?
}


struct useridModel{
    var users:[user] = []
}

struct user{
    var userid:String?
    var userName:String?
}
struct userinfo{
    var userid:String?
    var userName:String?
    var userImageString:String?
    var userAge:String?
    var userSex:String?
}
struct trainerinfo{
    var trainerid:String
    var trainername:String
}
