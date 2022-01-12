//
//  NotificationModel.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/05.
//

import Foundation
import ObjectMapper

class NotificationModel: Mappable{
    
    public var to: String?
    public var notification: Notification = Notification()
    public var data: Data = Data()
    
    init(){}
    
    required init?(map: Map) { }
    
    func mapping(map: Map){
        to <- map["to"]
        notification <- map["notification"]
        data <- map["data"]
    }
    
    class Notification: Mappable{
        
        public var title: String?
        public var text: String?
        init(){}
        required init?(map: Map) { }
        func mapping(map: Map){
            title <- map["title"]
            text <- map["text"]
        }
        
        
    }
}
