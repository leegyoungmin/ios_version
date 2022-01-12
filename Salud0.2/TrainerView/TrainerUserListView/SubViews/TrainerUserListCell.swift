//
//  TrainerUserListCell.swift
//  TrainerSwiftui
//
//  Created by 이경민 on 2021/11/24.
//

import SwiftUI

struct TrainerUserListCell: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person.fill")
                    .font(.system(size: 80))
                Text("회원 이름 들어가요")
                Spacer()
            }
            .padding()
        }
        .background(Color.gray)
        .cornerRadius(20)
    }
}

struct TrainerUserListCell_Previews: PreviewProvider {
    static var previews: some View {
        TrainerUserListCell()
    }
}
