//
//  MyMessageCell.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/15.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI
import Firebase


class MyMessageTableViewCell: UITableViewCell{
    static let identifier = "MyMessageCell"
    
    let messageLabel: PaddingLabel = {
        let message = PaddingLabel()
        message.backgroundColor = .purple
        //Test Text
        message.text = "init(coder:) has not been   implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implementedinit(coder:) has not been implemented"
        message.textColor = .white
        message.numberOfLines = 0
        message.layer.cornerRadius = 8
        message.clipsToBounds = true
        return message
    }()
    
    let timeStampLabel: UILabel = {
        let time = UILabel()
        time.text = "example"
        time.font = .systemFont(ofSize: 10)
        return time
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView(){
        
        let stackview = UIStackView(arrangedSubviews: [messageLabel])
        stackview.axis = .vertical
        
        [stackview,timeStampLabel].forEach{
            contentView.addSubview($0)
        }
        
        stackview.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-5)
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
            $0.width.lessThanOrEqualTo(250)
        }
        timeStampLabel.snp.makeConstraints{
            $0.trailing.equalTo(messageLabel.snp.leading).offset(-5)
            $0.bottom.equalTo(messageLabel.snp.bottom)
        }
    }
}



struct MyMessageTableViewCellPreviews:PreviewProvider{
    static var previews: some View{
        UIViewPreview{
            let viewcontroller = MyMessageTableViewCell()
            return viewcontroller
        }
    }
}
