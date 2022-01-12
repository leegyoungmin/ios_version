////
////  RequestingExerciseView.swift
////  Salud0.2
////
////  Created by 이관형 on 2021/12/08.
////
//
//import Foundation
//import SwiftUI
//import UIKit
//
//struct RequestingExerciseView: View{
//    @State var tabIndex = 0
//    @State var date: String
//    
//    var body: some View{
//        CustomTopTapBar(tabIndex: $tabIndex)
//        switch(tabIndex){
//        case 0: RequestingRoutineEx(date: date)
//        case 1: RequestingFitnessEx(date: date)
//        case 2: RequestingAerobicEx(date: $date)
//        case 3: RequestingBackEx(date: date)
//        case 4: RequestingChestEx(date: date)
//        case 5: RequestingArmEx(date: date)
//        case 6: RequestingLegEx(date: date)
//        case 7: RequestingAbsEx(date: date)
//        default: RequestingRoutineEx(date: date)
//        }
//        Spacer()
//            .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
//            .padding(.horizontal, 12)
//            .onAppear{
//                print("RequestingExerciseView")
//                print(self.date)
//            }
//            .navigationBarTitle("운동 요청")
//            .navigationBarTitleDisplayMode(.inline)
//        
//    }
//}
