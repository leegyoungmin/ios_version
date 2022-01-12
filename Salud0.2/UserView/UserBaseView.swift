//
//  UserBaseView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import Foundation
import SwiftUI
import ToastUI

struct UserBaseView:View{
    @EnvironmentObject var UserBaseModel:UserBaseViewModel
    @State var selectedindex:Int = 0
    @State var isNavigationChattingView:Bool = false
    @State var isPresentingErrorAlert:Bool = false
    
    var body: some View{
        NavigationView{
            TabView(selection: $selectedindex){
                UserMainView()
                    .tabItem{
                        Label("홈", systemImage: "person.fill")
                    }
                    .tag(0)
                    .onTapGesture {
                        selectedindex = 0
                    }
                
                UserJournalView()
                    .tabItem{
                        Label("일지",systemImage: "bookmark.fill")
                    }
                    .tag(1)
                    .onTapGesture {
                        selectedindex = 1
                    }
                
                UserStretchingView()
                    .tabItem{
                        Label("스트레칭",systemImage: "person.fill")
                    }
                    .tag(2)
                    .onTapGesture {
                        selectedindex = 2
                    }
                
                UserCoachingView()
                    .tabItem{
                        Label("코칭",systemImage: "person.fill")
                    }
                    .tag(3)
                    .onTapGesture {
                        selectedindex = 3
                    }
            }
            .navigationBarTitleDisplayMode(.large)
            .edgesIgnoringSafeArea(.top)
            .accentColor(.purple)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    HStack{
                        Text(changeTitle(selectedTabIndex:selectedindex))
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                            .foregroundColor(.purple)
                    }
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    NavigationLink(isActive: $isNavigationChattingView, destination: {
                        UserChattingRepresentable(trainerid: UserBaseModel.trainer)
                            .navigationBarHidden(true)
                    }){
                        HStack{
                            Image(systemName: "message.fill")
                                .foregroundColor(.purple)
                        }
                        .onTapGesture {
                            if UserBaseModel.trainer == "default" || UserBaseModel.trainer == ""{
                                print(UserBaseModel.trainer)
                                isPresentingErrorAlert.toggle()
                            }else{
                                isNavigationChattingView.toggle()
                            }
                        }
                        
                    }.toast(isPresented: $isPresentingErrorAlert){
                        ToastView{
                            VStack{
                                Text("연결된 트레이너가 없습니다.")
                                    .font(.system(size: 25, weight: .bold, design: .monospaced))
                                    .foregroundColor(.black)
                                Text("트레이너에게 문의 해주세요.")
                                    .font(.system(size: 15, weight: .semibold, design: .monospaced))
                                Button(action: {
                                    isPresentingErrorAlert = false
                                }, label: {
                                    Text("확인")
                                        .font(.system(size: 15, weight: .semibold, design: .monospaced))
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.purple)
                                        .cornerRadius(5)
                                })
                            }
                            
                        }
                    }

                })
            })
        }
        .navigationBarHidden(true)
    }
}

struct UserBaseViewPreviews:PreviewProvider{
    static var previews: some View{
        UserBaseView()
    }
}

private func changeTitle(selectedTabIndex:Int)->String{
    switch selectedTabIndex {
    case 0:
        return "홈"
    case 1:
        return "일지작성"
    case 2:
        return "스트레칭"
    case 3:
        return "코칭"
    default:
        return ""
    }
}
