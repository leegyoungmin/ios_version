//
//  TrainerUserListViewModel.swift
//  Salud0.2
//
//  Created by 이경민 on 2022/01/06.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class TrainerUserListViewModel:ObservableObject{
    @Published var userListModel = useridModel()
    var useridList:[String] = []
    
    init(){
        getData()
    }
    var userlist:[user]{
        return self.userListModel.users
    }
}

extension TrainerUserListViewModel{
    func getData(){
        guard let trainerid = FirebaseAuth.Auth.auth().currentUser?.uid else{return}
        
        FirebaseDatabase.Database.database().reference()
            .child("Trainer")
            .child(trainerid)
            .child("trainee")
            .observeSingleEvent(of: .value){ snapshot in
//                print(snapshot.value)
                guard let valueDict = snapshot.value as? [String:String] else{return}
                valueDict.forEach{
                    let user = user(userid: $0.key, userName: $0.value)
                    self.userListModel.users.append(user)
                    self.useridList.append($0.key)
                }
            }
    }
    
    func getNewUserid(_ phoneNumber:String, completion: @escaping(_ newuser:userinfo) -> Void){
        FirebaseDatabase.Database.database().reference()
            .child("User")
            .observeSingleEvent(of: .value){snapshot  in
                for child in snapshot.children{
                    let snap = child as! DataSnapshot
                    guard let dic = snap.value as? [String:Any] else{return}
                    if dic["phone"] as! String == phoneNumber{
                        let name = dic["name"]
                        let imageString = dic["photoUri"]
                        let userAge = dic["age"]
                        let usersex = dic["gender"]
                        let userinfo = userinfo(
                            userid: snap.key as? String,
                            userName: name as? String,
                            userImageString: imageString as? String,
                            userAge: userAge as? String,
                            userSex: usersex as? String
                        )
                        completion(userinfo)
                    }
                }
            }
    }
    
    func AddUserid(_ userid:String,_ userName:String,completion: @escaping(_ trainerid:String)->Void){
        guard let trainerid = FirebaseAuth.Auth.auth().currentUser?.uid else{return}
        
        FirebaseDatabase.Database.database().reference()
            .child("User")
            .child(userid)
            .child("trainer")
            .observeSingleEvent(of: .value){snapshot in
                if snapshot.value as? String == "default"{
                    snapshot.ref.setValue(trainerid, withCompletionBlock: { (error,result) in
                        if error != nil{
                            print(error?.localizedDescription as? String)
                        }
                        else{
                            FirebaseDatabase.Database.database().reference()
                                .child("Trainer")
                                .child(trainerid)
                                .child("trainee")
                                .updateChildValues([userid:userName])
                        }
                    })

                }
                else{
                    let trainerid = snapshot.value as? String
                    guard let trainerid = trainerid else{return}
                    completion(trainerid)
                }
                
            }
    }
    func getExistedTrainer(_ trainerid:String,completion:@escaping(_ trainerName:String)->Void){
        FirebaseDatabase.Database.database().reference()
            .child("Trainer")
            .child(trainerid)
            .child("name").observeSingleEvent(of: .value){snapshot in
                let trainername = snapshot.value as? String
                completion(trainername!)
            }
    }
}

