//
//  ChatListTableViewCell.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/05.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class ChatListTableViewCell: UITableViewCell{
    static let identifier = "ChatListTableViewCell"
    
    let imageview: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "example_Title"
        return label
    }()
    
    let lastMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "네 안녕하세요. 처음 뵙겠습니다. 이번에 트레이너 맡게된 이관형입니다."
        label.numberOfLines = 1
        return label
    }()
    
    let timeStampLabel: UILabel = {
        let label = UILabel()
        label.text = "example_time"
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addContentView(){
        [imageview,titleLabel,lastMessageLabel,timeStampLabel].forEach{
            contentView.addSubview($0)
        }
        imageview.isUserInteractionEnabled = false
        titleLabel.isUserInteractionEnabled = false
        lastMessageLabel.isUserInteractionEnabled = false
        timeStampLabel.isUserInteractionEnabled = false
        
        imageview.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.width.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(imageview.snp.trailing).offset(10)
        }
        lastMessageLabel.snp.makeConstraints{
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.width.lessThanOrEqualTo(250)
        }
        timeStampLabel.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalTo(lastMessageLabel.snp.centerY)
        }
    }
}

struct ChatListTableViewCellPreviews:PreviewProvider{
    static var previews: some View{
        UIViewPreview{
            let view = ChatListTableViewCell()
            return view
        }
    }
}
