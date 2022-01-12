//
//  RequestingExerciseViewModel.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/12/08.
//

import Foundation
import SwiftUI
import UIKit
import Firebase
import FirebaseFirestore


class RequestingExerciseViewModel: ObservableObject {
    let db = Firestore.firestore()
    let FitnessCode = UserDefaults.standard.string(forKey: "fitnessCode")
    @Published var FitnessList: [FitnessExerciseListModel] = []
    @Published var CommonList: [CommonExerciseListModel] = []
    
    
    //TODO: FireStore에서 데이터 가져오기
    func getExerciseList(part: String?){
        //일반 운동 목록 참조
        let CommonRef = db.collection("CommonExercise").document(part!)
        //헬스장 운동 목록 참조
        let FitnessRef = db.collection("FitnessExercise").document(FitnessCode!)
        
        //TODO: 1. 일반 운동 목록 분류
            CommonRef.getDocument{ (document, error) in
                if let document = document, document.exists{
                    let data = document.data()
                    if let data = data{
                        let snap = data as! [String: [String:String]]
                        for snapshot in snap{
                            let model = CommonExerciseListModel(exName: snapshot.key, exUrl: snapshot.value["url"]!)
                            self.CommonList.append(model)
                        }
                    }
                }
                else{
                    print("Doc does not exist")
                }
            }
        
        //TODO: 2.분류
        FitnessRef.getDocument{ (document, error) in
            if let document = document, document.exists{
                let data = document.data()
                if let data = data{
                    let snap = data as! [String: [String:String]]
                    for snapshot in snap{
                        let model = FitnessExerciseListModel(exName: snapshot.key, exUrl: snapshot.value["url"]!)
                        self.FitnessList.append(model)
                    }
                }
            }
        }
    }
    //TODO: ImageURL 보내기
    //TODO: 저장 버튼을 통한 Realtimebase에 저장하기
}



//FireStore에서 운동 목록 가져올 때(헬스장용)
struct FitnessExerciseListModel{
    let id = UUID().uuidString
    var exName: String
    var exUrl: String
    
    init(exName: String, exUrl: String){
        self.exName = exName
        self.exUrl = exUrl
    }
}


//FireStore에서 운동 목록 가져올 때(일반용)
struct CommonExerciseListModel: Codable{
    let id = UUID().uuidString
    var exName: String
    var exUrl: String
    
    init(exName: String, exUrl: String){
        self.exName = exName
        self.exUrl = exUrl
    }
}


//유산소 운동 저장할 때
struct RequestingExerciseModelAerobic{
    let id = UUID().uuidString
    
    var exPart: String
    var exName: String
    var exDone: Bool
    var exMinute: Int
    var exSets: Int
    var exTime: Int
    var exWeight: Int
    
    init(exPart: String, exName: String, exDone: Bool, exMinute: Int, exSets: Int, exTime: Int, exWeight: Int){
        self.exPart = exPart
        self.exName = exName
        self.exDone = exDone
        self.exMinute = exMinute
        self.exSets = exSets
        self.exTime = exTime
        self.exWeight = exWeight
    }
}
//무산소 운동 저장할 때
struct RequestingExerciseModelAnAerobic{
    
    let id = UUID().uuidString
    var exName: String
    var exMinute: Int
    var exDone: Bool
    
    init(exName: String, exMinute: Int, exDone: Bool){
        self.exName = exName
        self.exMinute = exMinute
        self.exDone = exDone
    }
    
    
}
