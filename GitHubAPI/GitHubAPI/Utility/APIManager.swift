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
// 2dfa66bed9d994c76056afb994fb0da5c496587e
class APIManager{
    let baseURL = "https://api.github.com/search"
    static let sharedInstance = APIManager()
    static let getUser = "/users?q="
    static let page = "&page=1&per_page=10"
    
    func getUserWithName(userName: String, onSuccess:@escaping([User]) -> Void, onFailure:@escaping(Error) -> Void){
        APIManager.sharedInstance.loadData(title: userName, onSuccess: { (json) in
            print(json)
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
        let url:String = baseURL + APIManager.getUser + title + APIManager.page
        print(url)
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess{
                if let jsn = response.result.value{
                    let json = JSON(jsn)//Swifty JSON Begins
                    print(json)
                    onSuccess(json)
                }
            }else if response.result.isFailure{
                onFailure(response.error?.localizedDescription as! Error)
            }
        }
    }
    
    func loginUser(){
        let url:String = baseURL + APIManager.getUser + "writeriks" + APIManager.page
        let plainString = "clientID:2dfa66bed9d994c76056afb994fb0da5c496587e" as NSString
        let plainData = plainString.data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData?.base64EncodedString(options: [])//base64EncodedStringWithOptions([])
        let headers = [
            "Authorization": "Basic \(String(describing: base64String))",
            "Content-Type": "application/json"
        ]
        
        let params = [
            "grant_type": "client_credentials",
            "scope": "public"
        ]
        Alamofire.request(url,parameters:[
            "client_id"     : "writeriks",
            "client_secret" : "2dfa66bed9d994c76056afb994fb0da5c496587e",
            "grant_type"    : "client_credentials"
            ]).responseString { (response) in
            <#code#>
        }
        
    }
}
