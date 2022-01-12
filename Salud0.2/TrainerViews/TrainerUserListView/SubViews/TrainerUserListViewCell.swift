//
//  TrainerUserListViewCell.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/12/08.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
import SwiftUI

class TrainerUserListViewCell: UITableViewCell{
    static let identifier = "TrainerUserListViewCell"
    
    let userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.layer.cornerRadius = 25
        userImage.contentMode = .scaleAspectFit
        userImage.image = UIImage(named: "logo_only")
        return userImage
    }()
    
    let userName: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "example_Name"
        userName.font = UIFont.boldSystemFont(ofSize: 20)
        return userName
    }()
    
    let messageText: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 15)
        text.text = "example_Message"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout(){
        contentView.snp.makeConstraints{
            $0.height.equalTo(50)
        }
        
        [
            userImage,
            userName,
            messageText
        ].forEach{
            addSubview($0)
        }
        
        
        userImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.height.width.equalTo(50)
            $0.top.equalToSuperview()
        }
        userName.snp.makeConstraints{
            $0.leading.equalTo(userImage.snp.trailing).offset(10)
            $0.top.equalTo(userImage.snp.top)
        }
        messageText.snp.makeConstraints{
            $0.leading.equalTo(userName.snp.leading)
            $0.top.equalTo(userName.snp.bottom)
        }
        
        
        
    }
}

struct TrainerUserListViewCellPreviews:PreviewProvider{
    static var previews: some View{
        UIViewPreview{
            let view = TrainerUserListViewCell()
            return view
        }
    }
}
