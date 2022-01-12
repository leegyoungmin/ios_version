//
//  UserMembershipView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import SwiftUI

struct UserMembershipView: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                
                Text("Membership Name")
                    .padding(.bottom,5)
                Text("Membership Time")
                Text("Membership Left Time")
                Text("Membership Example")
            }

            Spacer()
        }
        .background(Color.purple)
        .padding()
        .background(Color.gray)
        
        
    }
}

struct UserMembershipView_Previews: PreviewProvider {
    static var previews: some View {
        UserMembershipView()
    }
}
