//
//  UserPieChartView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import SwiftUI

struct UserPieChartView: View {
    var body: some View {
        VStack{
            Text("소비 칼로리")
                .padding(.top)
            Rectangle()
                .foregroundColor(.purple)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
        .background(Color.gray)
        
    }
}

struct UserPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        UserPieChartView()
    }
}
