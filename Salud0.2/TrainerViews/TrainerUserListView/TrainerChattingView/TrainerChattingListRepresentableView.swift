//
//  TrainerChattingListRepresentableView.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/12/08.
//

import Foundation

import Foundation
import SwiftUI

struct TrainerChattingListRepresentableView:UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIViewController {
        let ChattingListViewController = ChattingListViewController()
        return ChattingListViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
