//
//  TrainerUserProfileView.swift
//  Salud0.2
//
//  Created by 이경민 on 2022/01/05.
//

import Foundation
import SwiftUI
import Kingfisher

enum destitype:String{
    case chatting,journal,stretching,survey,memo,exercise
}

struct TrainerUserProfileView:View{
    @State var usermodel:UserListModel
    var userid:String
    let itemList:[IconList] = [
        IconList(iconName: "채팅 하기", iconImageName: "text.bubble",destiType: .chatting),
        IconList(iconName: "일지 확인", iconImageName: "doc.on.doc.fill",destiType: .journal),
        IconList(iconName: "스트레칭", iconImageName: "figure.wave",destiType: .stretching),
        IconList(iconName: "설문 조사", iconImageName: "pencil",destiType: .survey),
        IconList(iconName: "메모 하기", iconImageName: "list.dash",destiType: .memo),
        IconList(iconName: "운동 요청", iconImageName: "figure.walk",destiType: .exercise)
    ]
    var columns:[GridItem] = [GridItem(.fixed(100)),GridItem(.fixed(100)),GridItem(.fixed(100))]
    
    var body: some View{
        VStack{
            KFImage(URL(string: usermodel.userImageString ?? ""))
                .placeholder({
                    if #available(iOS 15.0, *) {
                        Image("logo_only")
                            .frame(width: 200, height: 200, alignment: .center)
                            .overlay{
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke()
                            }
                    } else {
                        // Fallback on earlier versions
                        Image("logo_only")
                            .frame(width: 200, height: 200, alignment: .center)
                            .border(.black, width: 1)
                    }
                })
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
            
            Text(usermodel.userName ?? "")
                .font(.system(size: 20))
            
            LazyVGrid(columns: columns){
                ForEach(itemList,id: \.self){item in
                    NavigationLink {
                        MemoListView()
                    } label: {
                        VStack(alignment:.center){
                            Image(systemName: item.iconImageName)
                                .font(.system(size: 30))
                            Spacer()
                            Text(item.iconName)
                        }
                        .foregroundColor(Color.black)
                        .padding()
                    }
                    
                }
            }.padding(.vertical)
            
        }
        
        
    }
}

struct TrainerUserProfileView_Previews:PreviewProvider{
    static var previews: some View{
        let userlistmodel = UserListModel(userImageString: "", userName: "example", messageText: "example_message")
        TrainerUserProfileView(usermodel: userlistmodel, userid: "Userid")
    }
}

struct IconList:Hashable{
    var iconName:String
    var iconImageName:String
    var destiType:destitype = .chatting
}
