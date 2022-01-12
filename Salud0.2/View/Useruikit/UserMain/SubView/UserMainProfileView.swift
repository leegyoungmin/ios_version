//
//  UserMainProfileView.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/11/20.
//

import Foundation
import UIKit

final class UserMainProfileView:UIView{
    lazy var NameView:UITextView = {
        let NameView = UITextView()
        NameView.text = "example Text View Title"
        NameView.font = .systemFont(ofSize: 20, weight: .bold)
        return NameView
    }()
    lazy var ProfileImage:UIImageView = {
        let ProfileImage = UIImageView()
        return ProfileImage
    }()
    override init(frame:CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        [ProfileImage,NameView].forEach{
            self.addSubview($0)
        }
        self.snp.makeConstraints{
            $0.height.equalTo(100)
            $0.width.equalTo(120)
        }
        ProfileImage.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        NameView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalTo(ProfileImage.snp.trailing).offset(16)
        }
        
    }

}
