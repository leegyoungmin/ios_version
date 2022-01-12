//
//  UserCoachingView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import SwiftUI

struct UserCoachingView: View {
    @State private var SelectedExerciseType = ExerciseType.back
    var body: some View {
        VStack{
            Picker("",selection: $SelectedExerciseType){
                ForEach(ExerciseType.allCases){
                    type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            Spacer()
            Text(SelectedExerciseType.rawValue)
            Spacer()
        }
    }
}

struct UserCoachingView_Previews: PreviewProvider {
    static var previews: some View {
        UserCoachingView()
    }
}
enum ExerciseType:String,CaseIterable,Identifiable{
    case aerobic = "유산소"
    case back = "등"
    case chest = "가슴"
    case shoulder = "어깨"
    case abs = "복근"
    case arm = "팔"
    case leg = "하체"
    
    var id:String{self.rawValue}
}
