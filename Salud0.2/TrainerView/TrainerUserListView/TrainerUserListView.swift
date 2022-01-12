//
//  TrainerUserListView.swift
//  TrainerSwiftui
//
//  Created by 이경민 on 2021/11/24.
//

import SwiftUI

struct TrainerUserListView: View {
    @State var isPresentProfile : Bool = false
    var body: some View {
        ZStack{
                VStack{
                    makeTopView(title: "회원 목록")
                    ScrollView(.vertical, showsIndicators: false){
                        ForEach(0..<11,id: \.self){_ in
                            NavigationLink(destination: {
                                TrainerUserProfileView()
                                    .navigationTitle("")
                                    .navigationBarTitleDisplayMode(.inline)
                                    .onAppear{
                                        UINavigationBar.appearance().tintColor = .purple
                                    }
//                                    .navigationTitle("")
//                                    .navigationBarTitleDisplayMode(.inline)
//                                    .navigationBarBackButtonHidden(false)
                            }, label: {
                                TrainerUserListCell()
                                    .padding(.horizontal)
                                    .foregroundColor(.black)
                            })
                        }
                    }

                }
                .navigationTitle("")
                .navigationBarHidden(false)
        }
    }
}

struct TrainerUserListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerUserListView()
    }
}

func makeTopView(title:String)->some View{
    return HStack{
        Text(title)
            .font(.system(size: 30, weight: .black, design: .rounded))
            .foregroundColor(.white)
        Spacer()
        Image(systemName: "plus")
            .font(.system(size: 25))
            .foregroundColor(.white)
    }
    .padding()
    .background(Color.purple)
    
}
