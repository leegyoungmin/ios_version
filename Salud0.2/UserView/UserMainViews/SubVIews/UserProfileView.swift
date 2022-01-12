//
//  UserProfileView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import Foundation
import SwiftUI
struct UserProfileView:View{
    var body: some View{
        HStack{
            Image(systemName: "person.fill")
                .font(.system(size: 80))
                .clipShape(Circle())
            
            VStack(alignment:.leading){
                Text("이름 부분")
                Text("칼로리 부분")
            }
            Spacer()
        }
        .padding(.top)
    }
}

struct UserProfileViewPreviews:PreviewProvider{
    static var previews: some View{
        UserProfileView()
    }
}
