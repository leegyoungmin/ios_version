//
//  UserStretchingView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import SwiftUI

struct UserStretchingView: View {
    @State private var selectedViewStyle = StrechingViewType.requestedvideo
    var body: some View{
        VStack{
            Picker("",selection: $selectedViewStyle){
                ForEach(StrechingViewType.allCases){
                    type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            switch selectedViewStyle {
            case .requestedvideo:
                VStack{
                    Spacer()
                    Text("요청된 스트레칭 탭입니다.")
                    Spacer()
                }

            case .allvideo:
                VStack{
                    Spacer()
                    Text("모든 스트레칭 탭입니다.")
                    Spacer()
                }
            }
        }
    }
}

struct UserStretchingView_Previews: PreviewProvider {
    static var previews: some View {
        UserStretchingView()
    }
}

enum StrechingViewType:String,CaseIterable,Identifiable{
    case requestedvideo = "요청된 스트레칭"
    case allvideo = "모든 스트레칭"
    
    var id:String{self.rawValue}
}
