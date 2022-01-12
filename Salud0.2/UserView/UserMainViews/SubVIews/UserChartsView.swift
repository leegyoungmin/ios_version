//
//  UserProfileView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import Foundation
import SwiftUI

struct UserChartsView:View{
    var body: some View{
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing:16){
                    ForEach(0..<3){
                        item in
                        VStack{
                            Text("\(item)")
                                .font(.system(size: 25))
                                .padding(.top)
                            Rectangle()
                                .foregroundColor(.purple)
                        }
                        .frame(width: 200, height: 200, alignment: .center)
                        .background(Color.gray)
                        .cornerRadius(12)
                        

                    }
                }.padding()
                    
            }.background(Color.white)
        
        
    }
}

struct UserChartsPreviews:PreviewProvider{
    static var previews: some View{
        UserChartsView()
    }
}

