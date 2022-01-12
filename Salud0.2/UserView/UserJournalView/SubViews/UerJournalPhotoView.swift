//
//  UerJournalPhotoView.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import SwiftUI

struct UerJournalPhotoView: View {
    @State var title:String
    var body: some View {
        VStack{
            Text(title)
                .padding(.top)
            Spacer()
            Image("logo1")
                .padding()
                .background(Color.gray)
            Spacer()
        }
        .frame(width: 200, height: 200, alignment: .center)
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct UerJournalPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        UerJournalPhotoView(title: "아침")
    }
}
