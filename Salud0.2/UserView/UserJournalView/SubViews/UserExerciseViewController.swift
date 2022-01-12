//
//  UserExerciseViewController.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import Foundation
import SnapKit
import UIKit
import SwiftUI

struct PageViewController : UIViewControllerRepresentable{
    var controllers:[UIViewController]
    
    func makeUIViewController(context: Context) -> some UIPageViewController {
        let pageviewcontroller = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal)
        return pageviewcontroller
    }
    
    func updateUIViewController(_ pageviewcontroller: UIViewControllerType, context: Context) {
        pageviewcontroller.setViewControllers([controllers[0]], direction: .forward, animated: true)
    }
}
