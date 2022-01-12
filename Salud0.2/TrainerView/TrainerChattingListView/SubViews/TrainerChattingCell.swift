//
//  TrainerChattingCell.swift
//  TrainerSwiftui
//
//  Created by 이경민 on 2021/11/24.
//

import SwiftUI

struct TrainerChattingCell: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person.fill")
                    .font(.system(size: 70))
                VStack(alignment:.leading,spacing: 10){
                    Text("마지막 문자 들어가는 곳")
                    Text("시간이 들어갈 곳")
                }
                Text("안읽은 문자 개수")
            
            }
            Divider()
        }
        
    }
}

struct TrainerChattingCell_Previews: PreviewProvider {
    static var previews: some View {
        TrainerChattingCell()
    }
}
