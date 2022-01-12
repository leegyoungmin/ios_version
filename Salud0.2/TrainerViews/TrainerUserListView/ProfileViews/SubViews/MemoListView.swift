//
//  MemoListView.swift
//  TrainerSwiftui
//
//  Created by 이경민 on 2021/11/24.
//

import SwiftUI

struct MemoListView: View {
    let MemoList:[Memo] = [
        Memo(title: "example_1", contents: "example_1_1", date: "example_1_2"),
        Memo(title: "example_2", contents: "example_2_1", date: "example_2_2"),
        Memo(title: "example_3", contents: "example_3_1", date: "example_3_2"),
        Memo(title: "example_4", contents: "example_4_1", date: "example_4_2"),
        Memo(title: "example_5", contents: "example_5_1", date: "example_5_2"),
        Memo(title: "example_6", contents: "example_6_1 example_6_1 example_6_1 example_6_1 example_6_1 example_6_1 example_6_1 example_6_1 example_6_1 example_6_1 example_6_1 example_6_1 example_6_1 example_6_1 example_6_1 ", date: "example_6_2"),
    ]
    var body: some View {
        VStack{
            UserCardView()
                .cornerRadius(20)
                .padding()
            ScrollView{
                ForEach(MemoList,id: \.self){memo in
                    NavigationLink {
                        MemoView(titleText: memo.title, memoText: memo.contents)
                    } label: {
                        MemoListViewCell(title: memo.title, content: memo.contents)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitle("메모장")
    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
    }
}

struct MemoListViewCell:View{
    @State var title:String
    @State var content:String
    
    @State var isrotationButton:Bool = false
    var body: some View{
        VStack(alignment:.leading){
            Text(title)
            HStack{
                Text(content)
                    .lineLimit(isrotationButton ? 20:0)
                    .frame(height:isrotationButton ? 100:20)
                Spacer()
                Button {
                    isrotationButton.toggle()
                } label: {
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.black)
                        .rotationEffect(isrotationButton ? Angle(degrees: 90):Angle(degrees: 0))
                }
                
            }
            
        }
        .padding()
        .background(Color.yellow)

        
    }
}

struct UserCardView:View{
    var body: some View{
        HStack{
            Image(systemName: "person.fill")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            VStack(alignment:.leading){
                Text("UserName")
                    .font(.system(size: 20))
                Text("User Date in Exercise")
                    .font(.system(size: 10))
            }
            Spacer()
        }
        .padding()
        .background(Color.blue)
    }
}
