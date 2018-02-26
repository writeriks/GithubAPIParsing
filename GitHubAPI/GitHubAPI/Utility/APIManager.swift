//
//  APIManager.swift
//  GitHubAPI
//
//  Created by Emir haktan Ozturk on 23.02.2018.
//  Copyright © 2018 emirhaktan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit
//
// https://api.github.com/search/users?q=writeri&page=1&per_page=5&access_token=f4abebb90f88fe0c3e2cd38e37a6454e74816aad
class APIManager{
    static let sharedInstance = APIManager()
    let baseURL = "https://api.github.com"
    static let search = "/search"
    static let getUsers = "/users?q="
    static let pageIndex = "&page=1"
    static let per_page = "&per_page=20"
    static let acces_token = "&access_token=f4abebb90f88fe0c3e2cd38e37a6454e74816aad"
    
    func getUserWithName(userName: String, onSuccess:@escaping([User]) -> Void, onFailure:@escaping(Error) -> Void){
        APIManager.sharedInstance.loadData(title: userName, onSuccess: { (json) in
            var user = [User]()
//            let a = User(json: json)
//            print(a.userName!)
            let items = json["items"]
            for (_, item) in items{
                let thisUser = User(json: item)
                user.append(thisUser)
            }
            onSuccess(user)
        }) { (error) in
            print(error.localizedDescription)
            onFailure(error)
        }
    }
    
    func loadData(title:String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url:String = baseURL + APIManager.search + APIManager.getUsers + title + APIManager.pageIndex + APIManager.per_page + APIManager.acces_token
        print(url)
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess{
                if let jsn = response.result.value{
                    let json = JSON(jsn)
                    onSuccess(json)
                }
            }else if response.result.isFailure{
                onFailure(response.error?.localizedDescription as! Error)
            }
        }
    }
}
