//
//  FirebaseDatabaseManager.swift
//  Salud0.2
//
//  Created by 이경민 on 2022/01/05.
//

import Foundation
import Firebase
import FirebaseDatabase


final class DatabaseManager{
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
}

//class FirebaseDatabaseManager:NSObject{
//    var uid:String
//    let Database = FirebaseDatabase.Database.database()
//    init(uid:String) {
//        self.uid = uid
//    }
//
//}

//extension FirebaseDatabaseManager{
//    func getRequestExerciseData(date:String?,part:String?,userid:String?){
//        guard let date = date,
//              let part = part,
//              let userid = userid else{ return }
//
//        Database.reference()
//            .child("RequestExercise")
//            .child(uid)
//            .child(userid)
//            .child(date)
//            .child(part)
//            .observe(.value){ snapshot in
//                if snapshot.key == "aerobic"{
//                    let values = snapshot.value
//                    let dic = values as? [String:[String:Any]]
//                    for index in dic{
//                        let model =
//                    }
//                }
//            }
//    }
//}
