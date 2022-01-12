//
//  GetDataModule.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/12/07.
//
import Foundation
import FirebaseDatabase
import FirebaseAuth
import SwiftUI
import UIKit


class GetDataModule: ObservableObject{
    let uid: String = Auth.auth().currentUser?.uid ?? "default"
    let userId: String = "w29uHSPMmbg3IeHyd0fdd2eqyU92"
    var exname: [String] = []
    var check = false
    @Published var anaerobicModels: [AnaerobicModel] = []
    @Published var aerobicModels: [AerobicModel] = []
    
    
    
    
    func getRequestedData(date: String?, part: String?){
        //TODO: 1. 트레이너 아이디가 있는지 없는지
        //from SceneDelegate
        print("date== \(date!)")

        Database.database().reference().child("RequestExercise").observeSingleEvent(of: .value, with: { trainerCheck in
            //1. 트레이너 아이디 체크
            if trainerCheck.hasChildren(){
                print("trainerChecked")
                trainerCheck.ref.child(self.uid).observe(.value, with: { userCheck in
                    //2. 회원아이디 체크
                    if userCheck.hasChildren(){
                        print("userChecked")
                        print(date!)
                        userCheck.ref.child(self.userId).observe(.value, with: { dateCheck in
                            //3. 해당날짜 체크
                            if dateCheck.hasChild(date!){
                                print("dateChecked")

                                dateCheck.ref.child(date!).observe(.value, with: { todayCheck in
                                    
                                    if todayCheck.hasChild(part!){
                                        print("fitnessChecked")
                                        switch(part!){
                                        case "aerobic":
                                            print("aerobic")
                                            todayCheck.ref.child(part!).observe(.value, with: { exercise in
                                                
                                                let values = exercise.value
                                                let dic = values as! [String: [String: Any]]
                                                for index in dic{
                                                    let model = AerobicModel(exerciseName: index.key, minute: index.value["Minute"] as! Int, done: index.value["Done"] as! Bool)
                                                    self.aerobicModels.append(model)
                                                }
                                            })
                                        
                                        
                                        
                                        default:
                                            todayCheck.ref.child(part!).observe(.value, with: {exercise in
                                                
                                                let values = exercise.value
                                                let dic = values as! [String: [String: Any]]
                                                for index in dic{
                                                    let model = AnaerobicModel(exerciseName: index.key, Done: index.value["Done"] as! Bool, Minute: index.value["Minute"]! as! Int, Sets: index.value["Sets"] as! Int, Time: index.value["Time"] as! Int, Weight: index.value["Weight"] as! Int)
                                                    self.anaerobicModels.append(model)
                                                }
                                            })
                                            
                                        }
                                        
                                        
                                        
                                    }
                                    else{
                                        self.check = false
                                    }
                                    
//                                    let values = todayCheck.value
//                                    let dic = values as! [String: [String: String]]
//                                    print(dic)
//                                    for index in dic{
//                                        let model = fitnessExercise(exerciseName: index.key, hydro: index.value["hydro"]!, sex: index.value["sex"]!)
//                                        self.models.append(model)
//
//                                  }
                                })
                            }
                            else//3. 해당날짜 체크
                            {
                                self.check = false
                            }
                        })
                    }
                    else//2. 회원아이디 체크
                    {
                        self.check = false
                    }
                    
                })
            }
            else //1. 트레이너 아이디 체크
            {
                self.check = false
            }
        })
        
    }
    
    
    
    
    
}

