////
////  TopNavigationView.swift
////  PTon
////
////  Created by 이경민 on 2021/11/23.
////
//
//import Foundation
//import SwiftUI
//struct TopNavigationView:View{
//    @State var title:String
//    var body: some View{
//        VStack{
//            HStack{
//                Text("\(title)")
//                    .foregroundColor(.purple)
//                    .font(.system(size: 30, weight: .black, design: .rounded))
//                Spacer()
//                
//                NavigationLink(destination: {
//                    UserChattingRepresentable(trainerid: <#T##String#>)
//                }, label: {
//                    Image(systemName: "message.fill")
//                        .font(.system(size: 25))
//                        .foregroundColor(.purple)
//                })
//                    .navigationTitle("")
//                    .navigationBarTitleDisplayMode(.inline)
//                    .navigationBarHidden(true)
//            }
//            .navigationBarHidden(true)
//            .padding(.horizontal)
//            .background(Color.white)
//        }
//        .navigationBarHidden(true)
//    }
//}
//
//struct TopNavigationViewPreviews:PreviewProvider{
//    static var previews: some View{
//        TopNavigationView(title: "Previews")
//    }
//}
