//
//  UserChattingRepresentable.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/11/24.
//

import Foundation
import SwiftUI

struct UserChattingRepresentable:UIViewControllerRepresentable{
    var trainerid:String
    func makeUIViewController(context: Context) -> UIViewController {
        print("User Chatting Representable clicked")
        let userchattingviewcontroller = UINavigationController(rootViewController: UserChattingViewController(trainerid: trainerid))
        print(trainerid)
        return userchattingviewcontroller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
