//
//  TrainerChattingView.swift
//  TrainerSwiftui
//
//  Created by 이경민 on 2021/11/24.
//

import SwiftUI

struct TrainerChattingView: View {
    @State var ispresent:Bool = false
    var body: some View {
        ZStack{
            VStack{
                makeTopView(title: "채팅 목록")
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(0..<11){_ in
                        NavigationLink(destination: {
                            ChattingRepresentable()
                                .navigationTitle("")
                                .navigationBarTitleDisplayMode(.inline)
                                .onAppear{
                                    UINavigationBar.appearance().tintColor = .purple
                                }
                        }, label: {
                            TrainerChattingCell()
                                .foregroundColor(.black)
                        })
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct TrainerChattingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerChattingView()
    }
}
