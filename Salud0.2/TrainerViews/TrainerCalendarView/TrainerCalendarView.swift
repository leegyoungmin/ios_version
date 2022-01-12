//
//  TrainerCalendarView.swift
//  TrainerSwiftui
//
//  Created by 이경민 on 2021/11/24.
//

import SwiftUI

struct TrainerCalendarView: View {
    @State var selectedDate:Date = Date()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            DatePicker("", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.graphical)
                .environment(\.locale, Locale(identifier: "ko-KR"))
                .onAppear{
                    UIDatePicker.appearance().tintColor = .purple
                }
            ForEach(0..<11,id: \.self){_ in
                TrainerCalendarCell()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        
    }
}

struct TrainerCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerCalendarView()
    }
}
