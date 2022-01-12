//
//  TrainerRepresentableView.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/11/24.
//

import Foundation
import SwiftUI

struct TrainerUserListRepresntableView:UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIViewController {
        let TrainerUserListVieController:UIViewController = TrainerUserListViewController()
        return TrainerUserListVieController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
