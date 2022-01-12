//
//  ExerciseModel.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/03.
//

import Foundation

struct detailexercise:Hashable,Identifiable{
    let id = UUID().uuidString
    var exercise:String
    var hydro:String
    var minutes:String
    var part:String
    var time:String
    var set:String
    var weight:String
}


struct routine: Hashable, Identifiable{
    let id = UUID().uuidString
    var example: String
}

struct AnaerobicModel: Hashable, Identifiable{
    let id = UUID().uuidString
    
//    let id = UUID().uuidString
    var exerciseName: String
    var Done: Bool
    var Minute: Int
    var Sets: Int
    var Time: Int
    var Weight: Int
    
    
    init(exerciseName: String, Done: Bool, Minute: Int, Sets: Int, Time: Int, Weight: Int){
        self.exerciseName = exerciseName
        self.Done = Done
        self.Minute = Minute
        self.Sets = Sets
        self.Time = Time
        self.Weight = Weight
    }
    
    
}

struct AerobicModel: Hashable, Identifiable{
    let id = UUID().uuidString
    var exerciseName: String
    var minute: Int
    var done: Bool
    
    init(exerciseName: String, minute: Int, done: Bool){
        self.exerciseName =  exerciseName
        self.minute = minute
        self.done = done
    }
}
