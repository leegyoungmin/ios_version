//
//  UserExerciseImage.swift
//  PTon
//
//  Created by 이경민 on 2021/11/23.
//

import Foundation
import SwiftUI

struct UserExerciseImage:Hashable,Codable,Identifiable{
    var id:String
    
    var title:String
    private var imageName:String
    var isFeatured:Bool
    var image:Image{
        Image(imageName)
    }
    var featureImage:Image?{
        isFeatured ? Image(imageName + "_feature") : nil
    }
}
