//
//  SenderTableViewCell.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/05.
//
import Foundation
import UIKit
import SnapKit

class Sender: UITableViewCell{
    static let identifier = "ReceiverTableViewCell"
    
    let senderName: UILabel = {
        let senderName = UILabel()
        senderName.translatesAutoresizingMaskIntoConstraints = false
        senderName.font = UIFont.boldSystemFont(ofSize: 20)
        return senderName
    }()
    
    let sendedTime: UILabel = {
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.font = UIFont.boldSystemFont(ofSize: 10)
        return time
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
        contentView.addSubview(messageText)
        contentView.addSubview(sendedTime)
    }
    
    private func autoLayout(){
        messageText.snp.makeConstraints{ (make) in
            
        }
        sendedTime.snp.makeConstraints{ (make) in
            make.right.equalTo(messageText.snp.left)
            make.bottom.equalTo(messageText.snp.bottom)
        }
        
        
    }
    
}
