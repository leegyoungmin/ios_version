////
////  RequestExerciseView.swift
////  TrainerSwiftui
////
////  Created by 이경민 on 2021/11/24.
////
//
//import SwiftUI
//import UIKit
//import Foundation
//
//
//struct RequestExerciseView: View {
//    @State var tabIndex = 0
////    @State var date = Date()
//    @State var showingAlert = false
//    @State var savedDate: Date? = nil
//    @State var savedobjDate: String?
//    @State var tempDate: String = ""
////    @ObservedObject var viewModel = FitnessExViewModel()
////    @Binding var sendingTabDates: String?
//
//    var body: some View {
//        NavigationView{
//            VStack{
//                HStack{
//                    Image(systemName: "calendar")
//                        .resizable()
//                        .frame(width: 32, height: 32, alignment: .trailing)
//                        .onTapGesture{
//                            showingAlert = true
//                        }
//                    Spacer()
//
//
//                    Text(savedobjDate ?? tempDate)
//                        .onAppear{
//                            let formatter_year = DateFormatter()
//                            formatter_year.dateFormat = "yyyy-MM-dd"
//                            let current_year_string = formatter_year.string(from: Date())
//                            tempDate = current_year_string
//                        }
//                        .onChange(of: self.savedobjDate){newValue in
//                            print("onChanged")
//                            print(newValue!)
//                            tempDate = newValue!
//    //                        sendingTabDates = self.savedobjDate
//                        }
//
//                    Spacer()
//
//                        NavigationLink(
//                            destination: RequestingExerciseView(date: tempDate),
//                            label: {
//                                Image("stretch")
//                                    .resizable()
//                                    .frame(width: 32, height: 32, alignment: .topLeading)
//
//                            }
//
//                        )
//
//                }.padding(.horizontal)
//
//
//                if showingAlert{
//                    DatePickerWithButtons(showDatePicker: $showingAlert, savedDate: $savedDate, savedObjDate: $savedobjDate,  selectedDate: savedDate ?? Date())
//                                        .animation(.linear)
//                                        .transition(.opacity)
//                }
//
//
//                CustomTopTapBar(tabIndex: $tabIndex)
//                    switch(tabIndex){
//                    case 0: RoutineEx(date: $tempDate)
//                    case 1: FitnessEx(date: $tempDate)
//                    case 2: Aerobic(date: $tempDate)
//                    case 3: BackEx(date: $tempDate)
//                    case 4: ChestEx(date: $tempDate)
//                    case 5: ArmEx(date: $tempDate)
//                    case 6: LegEx(date: $tempDate)
//                    case 7: AbsEx(date: $tempDate)
//                    default: RoutineEx(date: $tempDate)
//                    }
//                    Spacer()
//                        .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
//                        .padding(.horizontal, 12)
//                        .onAppear{
//                        }
//
//            }
//
//            .navigationBarHidden(true)
//        }
//    }
//}
//
//struct DatePickerWithButtons: View {
//
//    @Binding var showDatePicker: Bool
//    @Binding var savedDate: Date?
//    @Binding var savedObjDate: String?
//    @State var selectedDate: Date = Date()
//
//    var body: some View {
//        ZStack {
//
//            Color.black.opacity(0.3)
//                .edgesIgnoringSafeArea(.all)
//
//
//            VStack {
//                DatePicker("Test", selection: $selectedDate, displayedComponents: [.date])
//                    .datePickerStyle(GraphicalDatePickerStyle())
////                    .onDisappear{
////                        print("picker")
////                        print( savedDate!)
////                        var savedStringDate: String = ""
////                        savedStringDate = DateFormattertoString(date: selectedDate)
////                        print(savedStringDate)
////                        savedObservedDate.savedDate = savedStringDate
////                    }
//                Divider()
//                HStack {
//
//                    Button(action: {
//                        showDatePicker = false
//                    }, label: {
//                        Text("Cancel")
//                    })
//
//                    Spacer()
//
//                    Button(action: {
//                        savedDate = selectedDate
//                        var savedStringDate: String = ""
//                        savedStringDate = DateFormattertoString(date: selectedDate)
////                        savedObservedDate.savedDate = savedStringDate
//                        print(savedStringDate)
////                        envDate.savedDate = savedStringDate
//                        savedObjDate = savedStringDate
//                        showDatePicker = false
//
////                        print("Save button")
//
////                        print("========")
//                    }, label: {
//                        Text("Save".uppercased())
//                            .bold()
//                    })
//                        .onTapGesture{
//                            print("button")
//                            print(savedDate!)}
//
//                }
//                .padding(.horizontal)
//
//            }
//            .padding()
//            .background(
//                Color.white
//                    .cornerRadius(30)
//            )
//
//
//        }
//
//    }
//
//    func DateFormattertoString(date: Date?) -> String{
//        let dateFormatter = Foundation.DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        return dateFormatter.string(from: date ?? Date())
//    }
//}
//
//
//
//struct RequestExerciseView_Previews: PreviewProvider {
//    @State static var tempDate: String = ""
//
//    static var previews: some View {
//        RequestExerciseView()
//    }
//}
//
//struct CustomTopTapBar: View {
//    @Binding var tabIndex: Int
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false, content: {
//            HStack(spacing: 30){
//                TabBarButton(text: "루틴", isSelected: .constant(tabIndex == 0)).onTapGesture {
//                    onButtonTapped(index: 0)
//                }
//                TabBarButton(text: "피트니스", isSelected: .constant(tabIndex == 1)).onTapGesture {
//                    onButtonTapped(index: 1)
//                }
//                TabBarButton(text: "유산소", isSelected: .constant(tabIndex == 2)).onTapGesture {
//                    onButtonTapped(index: 2)
//                }
//                TabBarButton(text: "등", isSelected: .constant(tabIndex == 3)).onTapGesture {
//                    onButtonTapped(index: 3)
//                }
//                TabBarButton(text: "가슴", isSelected: .constant(tabIndex == 4)).onTapGesture {
//                    onButtonTapped(index: 4)
//                }
//                TabBarButton(text: "팔", isSelected: .constant(tabIndex == 5)).onTapGesture {
//                    onButtonTapped(index: 5)
//                }
//                TabBarButton(text: "다리", isSelected: .constant(tabIndex == 6)).onTapGesture {
//                    onButtonTapped(index: 6)
//                }
//                TabBarButton(text: "복근", isSelected: .constant(tabIndex == 7)).onTapGesture {
//                    onButtonTapped(index: 7)
//                }
//                Spacer()
//            }
//
//        })
//        .border(width: 1, edges: [.bottom], color: .black)
//
//    }
//    private func onButtonTapped(index: Int){
//        withAnimation{tabIndex = index}
//    }
//}
//
//
//
//struct TabBarButton: View{
//    let text: String
//    @Binding var isSelected: Bool
//
//    var body: some View{
//        Text(text)
//            .fontWeight(isSelected ? .heavy : .regular)
//            .font(.system(size: 20))
//            .padding(.bottom, 10)
//            .border(width: isSelected ? 2: 1, edges: [.bottom], color: .black)
//    }
//
//}
//
//
//struct EdgeBorder: Shape{
//    var width: CGFloat
//    var edges: [Edge]
//
//    func path(in rect: CGRect) -> Path{
//        var path = Path()
//        for edge in edges {
//            var x: CGFloat{
//                switch edge{
//                case .top, .bottom, .leading: return rect.minX
//                case .trailing: return rect.maxX - width
//                }
//            }
//
//            var y: CGFloat{
//                switch edge{
//                case .top, .leading, .trailing: return rect.minY
//                case .bottom: return rect.maxY - width
//                }
//            }
//            var w: CGFloat{
//                switch edge{
//                case .top, .bottom: return rect.width
//                case .leading, .trailing: return self.width
//                }
//            }
//
//            var h: CGFloat{
//                switch edge{
//                case .top, .bottom: return self.width
//                case .leading, .trailing: return rect.height
//                }
//            }
//
//            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
//        }
//        return path
//    }
//}
//
//
//
//
//extension View{
//    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View{
//        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
//    }
//}
//
//
