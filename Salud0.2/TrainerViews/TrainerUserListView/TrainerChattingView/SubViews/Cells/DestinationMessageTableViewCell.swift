//
//  DestinationMessageTableViewCell.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/15.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI


class DestinationMessageTableViewCell: UITableViewCell{
    static let identifier = "DestinationMessageCell"
    
    let messageLabel: PaddingLabel = {
        let message = PaddingLabel()
        message.backgroundColor = .lightGray
        message.numberOfLines = 0
        message.text = "init(coder:) has not been implemented"
        message.layer.cornerRadius = 8
        message.clipsToBounds = true
        return message
    }()
    
    lazy var profileImage: UIImageView = {
        let profile = UIImageView()
        profile.layer.cornerRadius = 25
        profile.image = UIImage(named: "logo_only")
        profile.contentMode = .scaleAspectFit
        return profile
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.text = "example_name"
        name.textColor = .black
        name.font = .systemFont(ofSize: 13)
        name.clipsToBounds = true
//        name.font = UIFont(name: "GillSans-Italic", size: 5)
        return name
    }()
    
    let timeStampLabel: UILabel = {
        let time = UILabel()
        time.text = "example_time"
        time.font = .systemFont(ofSize: 10)
        return time
    }()
    let uiview:UIView = {
        let emptyView = UIView()
        emptyView.backgroundColor = .black
        return emptyView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()

    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView(){
        
        let stackview = UIStackView(arrangedSubviews: [nameLabel,messageLabel])
        stackview.axis = .vertical
        stackview.spacing = 5
        
        [
            timeStampLabel,
            profileImage,
            stackview
        ].forEach{
            addSubview($0)
        }

        profileImage.snp.makeConstraints{
            $0.top.equalTo(stackview.snp.top)
            $0.trailing.equalTo(stackview.snp.leading).offset(-5)
            $0.leading.equalToSuperview().offset(10)
            $0.height.width.equalTo(50)
        }
        stackview.snp.makeConstraints{
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
            $0.width.lessThanOrEqualTo(250)
        }
        timeStampLabel.snp.makeConstraints{
            $0.leading.equalTo(messageLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(messageLabel.snp.bottom)
        }
        
    }
    
}

struct DestinationMessageTableViewCellPreviewProviders:PreviewProvider{
    static var previews: some View{
        UIViewPreview{
            let uiview = DestinationMessageTableViewCell()
            return uiview
        }
    }
}
