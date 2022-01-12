//
//  UserExerciseCardView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import SwiftUI

struct UserExerciseCardView: View {
    var body: some View {
        HStack{
            Image(systemName: "person.crop.rectangle")
                .font(.system(size: 100))
            VStack(alignment:.leading){
                Text("운동 이름 들어가는 자리입니다.")
                    .padding(.bottom)
                Text("시간")
                Text("소모 칼로리")
            }
            .padding(.horizontal)
        }
        .padding(.vertical,20)
        .padding()
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 20))

    }
}

struct UserExerciseCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserExerciseCardView()
    }
}
