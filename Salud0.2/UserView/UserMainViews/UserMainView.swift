//
//  UserMainView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import Foundation
import SwiftUI

struct UserMainView:View{
    var body: some View{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    UserProfileView()
                        .padding(.vertical)
                        .background(Color.gray)
                    UserChartsView()
                    UserPieChartView()
                    UserMembershipView()
                        .background(Color.gray)
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                
            }
            
    }
}

struct UserMainViewPreviews:PreviewProvider{
    static var previews: some View{
        UserMainView()
    }
}



