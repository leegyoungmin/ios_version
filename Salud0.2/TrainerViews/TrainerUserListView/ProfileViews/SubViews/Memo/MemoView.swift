//
//  MemoView.swift
//  Salud0.2
//
//  Created by 이경민 on 2022/01/11.
//

import SwiftUI

struct MemoView: View {
    @State var titleText:String = ""
    @State var memoText:String = ""
    var body: some View {
        ZStack{
            Color.gray.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                    }
                    
                    TextField("제목을 입력하세요.", text: $titleText)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                    }
                    
                }
                .padding(.vertical,5)
                TextEditor(text: $memoText)
                    .onAppear{
                        UITextView.appearance().backgroundColor = .clear
                    }

            }
            .padding()
            
        }
        .navigationBarHidden(true)
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
    }
}
