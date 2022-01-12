//
//  SubExerciseViews.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/12/08.
//

import SwiftUI

struct SubExerciseViews: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct SubExerciseViews_Previews: PreviewProvider {
//    static var previews: some View {
//        SubExerciseViews()
//    }
//}


struct RequestingFitnessEx: View{
    @State var date: String
    var body : some View{
        Text(date)
    }
}

struct RequestingRoutineEx: View{
    @State var date: String
    var body: some View{
        Text(date)
    }
}

struct RequestingAerobicEx: View{
    @Binding var date: String
    @ObservedObject var viewModel = RequestingExerciseViewModel()
    
    
    init(date: Binding<String>){
        self._date = date
        print(self._date)
        self.viewModel.getExerciseList(part: "Aerobic")
    }
    var body: some View{
        Text("Hello")
            .onAppear{self.viewModel.getExerciseList(part: "Aerobic")}
    }
}


//check 1 sadasda
struct RequestingBackEx: View{
    @State var date: String
    var body: some View{
        Text(date)
    }
}

struct RequestingChestEx: View{
    @State var date: String
    var body: some View{
        Text(date)
    }
}

struct RequestingArmEx: View{
    @State var date: String
    var body: some View{
        Text(date)
    }
}

struct RequestingLegEx: View{
    @State var date: String
    var body: some View{
        Text(date)
    }
}

struct RequestingAbsEx: View{
    @State var date: String
    var body: some View{
        Text(date)
    }
}
