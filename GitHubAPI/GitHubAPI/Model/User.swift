//
//  User.swift
//  GitHubAPI
//
//  Created by Emir haktan Ozturk on 23.02.2018.
//  Copyright © 2018 emirhaktan. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: NSObject{
    var id : Int?
    var userName:String?
    var userAvatarImageUrl:String?
    var type:String?
    var followers:String?
    var following:String?
    
    init(json:JSON) {
        id = json["id"].intValue
        userName = json["login"].stringValue
        userAvatarImageUrl = json["avatar_url"].stringValue
        type = json["type"].stringValue
        followers = json["followers_url"].stringValue
        following = json["following_url"].stringValue
    }
    
}

class Repository: NSObject{
    var id: Int?
    var name: String?
    
    var user: User?
    
    init(json:JSON){
        id = json["id"].intValue
        name = json["name"].stringValue
        
        let items = json["owner"]
        user = User(json: items)
        
//        user?.id = items["id"].intValue
//        user?.userName = items["login"].stringValue
//        user?.userAvatarImageUrl = items["avatar_url"].stringValue
//        
    }
}
