//
//  TrainerCalendarCell.swift
//  TrainerSwiftui
//
//  Created by 이경민 on 2021/11/24.
//

import SwiftUI

struct TrainerCalendarCell: View {
    var body: some View {
        HStack{
            Image(systemName: "person.fill")
                .font(.system(size: 30))
            Text("이름이 들어갈 자리에요")
            Text("시간이 들어감")
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 30))
        }
        .padding()
        .background(Color.gray)
    }
}

struct TrainerCalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        TrainerCalendarCell()
    }
}
