//
//  UserBaseModel.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/11/20.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class UserBaseModel{
    var Model:Dictionary<String,Any> = [:]
}

extension NSDictionary{
    var convertDictionary : Dictionary<String,Any>{
        var convertDictionary = Dictionary<String,Any>()

        for key:Any in self.allKeys{
            let Stringkey = key as! String
            if let keyValue = self.value(forKey: Stringkey){
                convertDictionary[Stringkey] = keyValue
            }
        }
        return convertDictionary
    }
}
