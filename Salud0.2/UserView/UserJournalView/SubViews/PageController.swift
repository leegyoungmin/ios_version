//
//  PageController.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import Foundation
import SwiftUI

struct PageController:UIViewRepresentable{
    var maxItemCount:Int
    var current = 0
    func makeUIView(context: UIViewRepresentableContext<PageController>) -> UIPageControl {
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = .purple
        page.numberOfPages = maxItemCount
        page.pageIndicatorTintColor = .gray
        return page
    }
    func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<PageController>) {
        uiView.currentPage = current
    }
}
