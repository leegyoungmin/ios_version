//
//  MembershipSettingView.swift
//  TrainerSwiftui
//
//  Created by 이경민 on 2021/11/24.
//

import SwiftUI

struct MembershipSettingView: View {
    init(){
        UINavigationBar.appearance().backItem?.backBarButtonItem?.tintColor = .white
    }
    var body: some View {
        Text("MembershipSettingView")
    }
}

struct MembershipSettingView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipSettingView()
    }
}
