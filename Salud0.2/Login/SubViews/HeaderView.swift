//
//  HeaderView.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/11/30.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class HeaderView:UIView{
    var headerviewTitle:UILabel = {
        let headerviewTitle = UILabel()
        headerviewTitle.text = "추가 정보 기입"
        headerviewTitle.textAlignment = .left
        headerviewTitle.textColor = .purple
        headerviewTitle.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return headerviewTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        [headerviewTitle].forEach{
            addSubview($0)
        }
        headerviewTitle.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview()
        }
    }
}


struct UserTypeViewPreviews:PreviewProvider{
    static var previews: some View{
        
        UIViewPreview{
            let HeaderView = HeaderView()
            return HeaderView
        }
    }
}
