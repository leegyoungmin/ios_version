//
//  TrainerUserProfileView.swift
//  TrainerSwiftui
//
//  Created by 이경민 on 2021/11/24.
//

import SwiftUI

struct TrainerUserProfileView: View {
    @State var ispresent:Bool = false
    var body: some View {
        ZStack{
                VStack{
                    HStack{
                        Text("")
                            .font(.system(size: 30, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                        NavigationLink(destination: {
                            MembershipSettingView()
                                .navigationTitle("")
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarHidden(false)
                                .navigationViewStyle(.stack)

                        }, label: {
                            Image(systemName: "plus")
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                        })
                            .isDetailLink(false)
                            
                    }
                    .padding()
                    .background(Color.white)
                    
                    Spacer()
                    Image(systemName: "person.fill")
                        .font(.system(size: 200))
                        .clipShape(Circle())
                    Text("이름 들어갈 자리")
                        .font(.system(size: 25))
                    VStack{
                        HStack{
                            NavigationLink(destination: {
                                ChattingRepresentable()
                                    .navigationTitle("")
                                    .navigationBarTitleDisplayMode(.inline)
                                    .navigationBarHidden(false)
                                    .navigationViewStyle(.stack)

                            }, label: {
                                makeItem("chatting")
                            })
                                .isDetailLink(false)
                            NavigationLink(destination: {
                                JournalView()
                                    .navigationTitle("")
                                    .navigationBarTitleDisplayMode(.inline)
                                    .navigationBarHidden(false)
                                    .navigationViewStyle(.stack)

                            }, label: {
                                makeItem("Journal")
                            })
                                .isDetailLink(false)
                            NavigationLink(destination: {
                                StretchingView()
                                    .navigationTitle("")
                                    .navigationBarTitleDisplayMode(.inline)
                                    .navigationBarHidden(false)
                                    .navigationViewStyle(.stack)

                            }, label: {
                                makeItem("Stretching")
                            })
                                .isDetailLink(false)
                            
                        }
                        HStack{
                            NavigationLink(destination: {
                                SurvayView()
                                    .navigationTitle("")
                                    .navigationBarTitleDisplayMode(.inline)
                                    .navigationBarHidden(false)
                                    .navigationViewStyle(.stack)

                            }, label: {
                                makeItem("Survay")
                            })
                                .isDetailLink(false)
                            
                            NavigationLink(destination: {
                                MemoListView()
                                    .navigationTitle("")
                                    .navigationBarTitleDisplayMode(.inline)
                                    .navigationBarHidden(false)
                                    .navigationViewStyle(.stack)

                            }, label: {
                                makeItem("memo")
                            })
                                .isDetailLink(false)
                            NavigationLink(destination: {
                                RequestExerciseView()
                                    .navigationTitle("")
                                    .navigationBarTitleDisplayMode(.inline)
                                    .navigationBarHidden(false)
                                    .navigationViewStyle(.stack)

                            }, label: {
                                makeItem("exercise")
                            })
                                .isDetailLink(false)
                        }
                    }
                    .padding(.top,30)
                    Spacer()
                    
                    NavigationLink(destination: {
                        TrainingRecordView()
                            .navigationTitle("")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(false)
                            .navigationViewStyle(.stack)

                    }, label: {
                        HStack{
                            Image(systemName: "plus")
                                .font(.system(size: 50))
                            Spacer()
                            Text("운동 기록하기")
                                .font(.system(size: 30))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.purple)
                    })
                        .isDetailLink(false)
                    

                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct TrainerUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerUserProfileView()
    }
}

private func makeItem(_ title:String)->some View{
    return VStack{
        Image(systemName: "person.fill")
            .font(.system(size: 30))
        Text(title)
            .font(.system(size: 15))
    }
    .padding()
    .foregroundColor(.black)
}

enum ChangeViewType:String,Identifiable,CaseIterable{
    case chatting = "채팅"
    case journal = "일지"
    case stretching = "스트레칭"
    case survay = "설문조사"
    case memo = "메모"
    case exercise = "운동"
    
    var id:String{self.rawValue}
}
