//
//  PaddingLabel.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/12/06.
//

import Foundation
import UIKit

class PaddingLabel:UILabel{
    var topInset = 5.0
    var bottomInset = 5.0
    var leadingInset = 5.0
    var traelingInset = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leadingInset, bottom: bottomInset, right: traelingInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize{
        let size = super.intrinsicContentSize
        return CGSize(width: size.width+leadingInset+traelingInset, height: size.height+bottomInset+topInset)
    }
}
