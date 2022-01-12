//
//  ChatTableViewCell.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/05.
//

import Foundation
import UIKit
import SnapKit


class ReceiverTableViewCell: UITableViewCell{
    static let identifier = "ReceiverTableViewCell"
    
    let receiverImage: UIImageView = {
        let receiver = UIImageView()
        receiver.translatesAutoresizingMaskIntoConstraints = false
        return receiver
    }()
    
    
    
    let receiverName: UILabel = {
       let receiverName = UILabel()
        receiverName.translatesAutoresizingMaskIntoConstraints = false
        receiverName.font = UIFont.boldSystemFont(ofSize: 20)
        return receiverName
    }()
    
    
    
    let messageText: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 10)
        return text
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView(){
        contentView.addSubview(receiverImage)
        contentView.addSubview(receiverName)
        contentView.addSubview(messageText)
    }
    
    private func autoLayout(){
        receiverImage.snp.makeConstraints{ (make) in
            make.left.equalTo(self.contentView)
        }
        receiverName.snp.makeConstraints{ (make) in
            make.left.equalTo(receiverImage.snp.right)
            make.top.equalTo(receiverImage.snp.top)
        }
        messageText.snp.makeConstraints{ (make) in
            make.top.equalTo(receiverName.snp.bottom).offset(2)
            make.left.equalTo(receiverImage.snp.right)
        }
    }
    
    
}
