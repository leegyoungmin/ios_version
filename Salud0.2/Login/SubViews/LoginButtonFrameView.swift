//
//  LoginButtonFrameView.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/12/01.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

class LoginButtonFrameView:UIView{
    var imageString:String
    var LoginText:String
    var backcolor:UIColor
    
    var LoginImageView:UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    var LoginTextView:UILabel = {
        let LoginTextView = UILabel()
        return LoginTextView
    }()
    
    init(imageString:String,LoginText:String,backcolor:UIColor){
        self.imageString = imageString
        self.LoginText = LoginText + "로 로그인하기"
        self.backcolor = backcolor
        super.init(frame: .zero)
        
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


private extension LoginButtonFrameView{
    func setupViews(){
        
        [LoginImageView,LoginTextView].forEach{
            addSubview($0)
        }
        
        LoginImageView.snp.makeConstraints{
            $0.height.equalTo(30)
            $0.width.equalTo(30)
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        LoginTextView.snp.makeConstraints{
            $0.leading.equalTo(LoginImageView.snp.trailing).offset(10)
            $0.top.equalTo(LoginImageView.snp.top)
            $0.bottom.equalTo(LoginImageView.snp.bottom)
        }
        
        LoginTextView.text = LoginText
        
        LoginImageView.image = UIImage(named: imageString)
        layer.backgroundColor = backcolor.cgColor
        layer.cornerRadius = 20
    }
}


struct LoginButtonFrameViewPreviews:PreviewProvider{
    static var previews: some View{
        UIViewPreview{
            let layout = LoginButtonFrameView(imageString: "ProductLogo",LoginText: "구글",backcolor: UIColor.yellow)
            return layout
        }
    }
}
