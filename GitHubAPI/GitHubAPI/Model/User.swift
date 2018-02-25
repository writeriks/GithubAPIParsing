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
    var userName:String?
    var userAvatarImageUrl:String?
    var type:String?
    var followers:String?
    var following:String?
    
    init(json:JSON) {
//        userName = json["items"].arrayValue.map({$0["login"].stringValue})
//        userAvatarImage = json["items"].arrayValue.map({$0["avatar_url"].stringValue})
//        type = json["items"].arrayValue.map({$0["type"].stringValue})
//        followers = json["items"].arrayValue.map({$0["followers_url"].stringValue})
//        following = json["items"].arrayValue.map({$0["following_url"].stringValue})
        
        userName = json["login"].stringValue
        userAvatarImageUrl = json["avatar_url"].stringValue
        type = json["type"].stringValue
        followers = json["followers_url"].stringValue
        following = json["following_url"].stringValue
        
    }
    
}
