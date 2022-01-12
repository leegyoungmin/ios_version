//
//  UserBodyInputView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import SwiftUI

struct UserBodyInputView: View {
    @State var weight:String = ""
    @State var fat:String = ""
    @State var muscle:String = ""
    var body: some View {
        VStack{
            makeTextField("체중", contents: $weight)
            makeTextField("체지방", contents: $fat)
            makeTextField("근육량", contents: $muscle)
        }
    }
}

struct UserBodyInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserBodyInputView()
    }
}

private func makeTextField(_ title:String,contents:Binding<String>)->some View{
    return TextField(title, text: contents)
        .keyboardType(.numberPad)
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width/1.5, alignment: .center)
        .shadow(color: .gray, radius: 1, x: 0, y: 0)
    
}
