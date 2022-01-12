//
//  UserBaseViewModel.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/11/20.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import SwiftUI

class UserBaseViewModel:ObservableObject{
    @Published var usermodel = UserModel()
    
    init(){
        getData()
        
        print(usermodel.trainer)
    }
    
    var userid:String{
        return self.usermodel.uid ?? ""
    }
    var age:String{
        return self.usermodel.age ?? ""
    }
    var email:String{
        return self.usermodel.email ?? ""
    }
    var trainer:String{
        guard let trainerid = self.usermodel.trainer else{return ""}
        return trainerid
    }
}
extension UserBaseViewModel{
    func getData(){
        guard let userid = FirebaseAuth.Auth.auth().currentUser?.uid else{return}
        
        FirebaseDatabase.Database.database().reference()
            .child("User")
            .child(userid)
            .observeSingleEvent(of: .value){snapshot in
                let value = snapshot.value as? NSDictionary
                self.usermodel.age = value?["age"] as? String ?? ""
                self.usermodel.uid = value?["uid"] as? String ?? userid
                self.usermodel.email = value?["email"] as? String ?? ""
                self.usermodel.trainer = value?["trainer"] as? String ?? ""
            }
    }
}
