//
//  TrainerBaseView.swift
//  TrainerSwiftui
//
//  Created by 이경민 on 2021/11/24.
//

import SwiftUI

enum TrainerviewType:String,Identifiable,CaseIterable{
    var id : String{self.rawValue}
    
    case userlist = "회원 목록"
    case chatting = "채팅 목록"
}

struct TrainerBaseView: View {
    @State var selectedIndex:Int = 0
    @State var viewtype:TrainerviewType = .userlist
    var body: some View {
        NavigationView{
            TabView(selection: $selectedIndex){
                TrainerUserListRepresntableView()
                    .tabItem{
                        Label("회원 목록", systemImage: "person")
                            .onTapGesture {
                                viewtype = .userlist
                                selectedIndex = 0
                                print(selectedIndex)
                            }
                    }
                    .tag(0)
                    
                TrainerChattingListRepresentableView()
                    .tabItem{
                        Label("채팅 목록",systemImage: "list.bullet")
                            .onTapGesture {
                                viewtype = .chatting
                                selectedIndex = 1
                                print(selectedIndex)
                            }
                    }
                    .tag(1)
                    
                TrainerCalendarView()
                    .tabItem{
                        Label("일정 관리", systemImage: "calendar")
                            .onTapGesture {
                                selectedIndex = 2
                                print(selectedIndex)
                            }
                    }
                    .tag(2)
                    

            }
            .accentColor(.purple)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading){
                    HStack{
                        Text(changeTitle(titlenumber:selectedIndex))
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                            .foregroundColor(.purple)
                            .onAppear{
                                print(selectedIndex)
                            }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination:AddUserView().navigationBarBackButtonHidden(true),
                                   label: {
                        HStack{
                            Image(systemName: selectedIndex == 0 ? "plus":"")
                                .foregroundColor(.purple)
                                .onAppear{
                                    print(selectedIndex)
                                }
                        }
                        
                    })
                }
            })
        }
//        .navigationBarHidden(true)
        
    }
}

struct TrainerBaseView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerBaseView()
    }
}

private func changeTitle(titlenumber:Int) -> String{
    switch titlenumber{
    case 0:
        return "회원 목록"
    case 1:
        return "채팅 목록"
    case 2:
        return "일정 관리"
    default:
        return ""
    }
}

//func ChangeTrailingToolBarButton(viewtype:TrainerviewType)->some View{
//    print(viewtype)
//    let itemname = viewtype == .userlist ? "plus":""
//    return
//}
