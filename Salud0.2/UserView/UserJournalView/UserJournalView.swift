//
//  UserJournalView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import SwiftUI

struct UserJournalView: View {
    @State var today:Date = Date()
    @State var maxItemCount:Int = 5
    @State var isaddExercise:Bool = false
    let PhotoTitleList:[String] = ["아침 식사","점심 식사","간식","저녁 식사"]
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    DatePicker("", selection: $today, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding(.horizontal,7)
                        .environment(\.locale, Locale(identifier: "ko-KR"))
                        .onAppear{
                            UIDatePicker.appearance().tintColor = .purple
                        }
                    
                    // TODO: Data Processing
                    // 식단 기록
                    CreateSectionView("식단 기록")
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(PhotoTitleList,id: \.self){
                                item in
                                UerJournalPhotoView(title: item)
                            }
                            
                        }
                        .padding(.horizontal)
                        
                    }
                    // TODO: Data Processing
                    //운동 기록
                    HStack{
                        Text("운동 기록")
                            .font(.system(size:20,weight: .semibold))
                        Spacer()
                        Button(action: {
                            isaddExercise.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.purple)
                        }).sheet(isPresented: $isaddExercise){
                            UserAddExercise()
                        }
                    }
                    .padding(.horizontal)
                    
                    // TODO: PageViewController 완성하기
                    ZStack{
                        ForEach(0..<maxItemCount+1){index in
                            UserExerciseCardView()
                        }
                    }
                    
                    PageController(maxItemCount: maxItemCount)
                    

                    
                    // TODO: Data Processing
                    // PT 기록 확인
                    CreateSectionView("PT 기록")
                    ForEach(0..<6,id: \.self){
                        index in
                        CreateListCell("\(index)")
                            .padding(.horizontal)
                    }
                    
                    CreateSectionView("기본 정보 기록")
                        .padding(.top)
                    UserBodyInputView()
                        .padding(.vertical)
                }
                
            }
        }
    }
}

struct UserJournalView_Previews: PreviewProvider {
    static var previews: some View {
        UserJournalView()
    }
}

private func CreateSectionView(_ title:String) -> some View{
    return HStack{
        Text("\(title)")
            .font(.system(size:20,weight: .semibold))
        Spacer()
    }
    .padding(.horizontal)
}

private func CreateListCell(_ contents:String) -> some View{
    return HStack{
        Image(systemName: "message.fill")
        Text(contents)
        Spacer()
    }
    .background(Color.purple)
    
}

enum SectionViewType:String{
    case normal
    case button
}
