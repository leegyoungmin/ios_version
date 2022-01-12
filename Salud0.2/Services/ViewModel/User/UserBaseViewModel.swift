//
//  UserModel.swift
//  PTON
//
//  Created by 이경민 on 2021/10/12.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftUI

class UserBaseViewModel:ObservableObject{
    var ref:DatabaseReference! = Firebase.Database.database().reference()
    var data = UserBaseModel()

    init(){
        get()
    }

    func get(){
        guard let userid = Auth.auth().currentUser?.uid else {return}
        self.data.userid = userid
        ref
            .child("User")
            .child(userid)
            .observeSingleEvent(of: .value, with: {
                snapshot in
                self.data.Property = snapshot.childSnapshot(forPath: "property").value as? String ?? ""
                self.data.code = snapshot.childSnapshot(forPath: "fitnesscode").value as? String ?? ""
                self.data.name = snapshot.childSnapshot(forPath: "name").value as? String ?? ""
                self.data.photoUri = snapshot.childSnapshot(forPath: "photoUri").value as? String ?? ""
                self.data.status = snapshot.childSnapshot(forPath: "status").value as? String ?? ""
                self.data.trainer = snapshot.childSnapshot(forPath: "trainer").value as? String ?? ""
                print("data : \(self.data)")
                UserDefaults.standard.set(self.data.trainer, forKey: "trainerid")
            })
        ref
            .child("UserInfo")
            .child(userid)
            .observeSingleEvent(of: .value, with: {
                snapshot in
                self.data.KcalSetting = snapshot.childSnapshot(forPath: "kcalSetting").value as? String ?? ""
                self.data.fat = snapshot.childSnapshot(forPath: "fat").value as? String ?? ""
                self.data.height = snapshot.childSnapshot(forPath: "height").value as? String ?? ""
                self.data.muscle = snapshot.childSnapshot(forPath: "muscle").value as? String ?? ""
                self.data.weight = snapshot.childSnapshot(forPath: "weight").value as? String ?? ""

            })
    }


    var userid:String{
        guard let userid = data.userid else{return ""}
        return userid
    }
    var KcalSetting:String{
        guard let KcalSetting = data.KcalSetting else{return ""}
        return KcalSetting
    }

    var Property:String{
        guard let Property = data.Property else{return ""}
        return Property
    }


    var code:String{
        guard let code = data.code else{return ""}
        return code
    }

    var fat:String{
        guard let fat = data.fat else{return ""}
        return fat
    }
    var height:String{
        guard let height = data.height else{return ""}
        return height
    }
    var muscle:String{
        guard let muscle = data.muscle else{return ""}
        return muscle
    }
    var name:String{
        guard let name = data.name else{return ""}
        return name
    }
    var photourl:String{
        guard let photourl = data.photoUri else{return ""}
        return photourl
    }
    var status:String{
        guard let status = data.status else{return ""}
        return status
    }
    var trainer:String{
        guard let trainer = data.trainer else{return ""}
        return trainer
    }
    var weight:String{
        guard let weight = data.weight else{return ""}
        return weight
    }
}
