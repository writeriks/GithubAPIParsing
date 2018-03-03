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
import AlamofireImage
import UIKit

class APIManager{
    static let sharedInstance = APIManager()
    
    let baseURL = "https://api.github.com"
    let search = "/search"
    let getUsers = "/users?q="
    let getRepo = "/repositories?q="
    let pageIndexString = "&page="
    let per_page = "&per_page=20"
    
    func getUserWithName(userName: String, pageIndex:Int, onSuccess:@escaping([User]) -> Void, onFailure:@escaping(Error) -> Void){
//        let url = baseURL + APIManager.search + APIManager.getUsers + userName + APIManager.pageIndexString + pageIndex + APIManager.per_page
        let urlPart1 = baseURL + search + getUsers + userName
        let urlPart2 = pageIndexString + String(describing : pageIndex) + per_page
        let url = urlPart1 + urlPart2
        APIManager.sharedInstance.loadData(url: url, onSuccess: { (json) in
            var user = [User]()
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
    
    func getRepositoryWithName(repositoryName: String, pageIndex:Int, onSuccess:@escaping([Repository]) -> Void, onFailure:@escaping(Error) -> Void){
//        let url:String = baseURL + APIManager.search + APIManager.getRepo + repositoryName + APIManager.pageIndexString + pageIndex + APIManager.per_page
        let urlPart1 = baseURL + search + getRepo + repositoryName
        let urlPart2 = pageIndexString + String(describing : pageIndex) + per_page
        let url = urlPart1 + urlPart2
        
        APIManager.sharedInstance.loadData(url: url, onSuccess: { (json) in
            var repositories = [Repository]()
            let items = json["items"]
            for (_, item) in items{
                let thisRepo = Repository(json: item)
                repositories.append(thisRepo)
            }
            onSuccess(repositories)
        }) { (error) in
            print(error.localizedDescription)
            onFailure(error)
        }
    }
    
    func loadData(url:String,  onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        
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
    
    func loadImage(url:String, onSuccess: @escaping(UIImage) -> Void, onFailure: @escaping(Error) -> Void){
        Alamofire.request(url).responseImage { (response) in
            if response.result.isSuccess{
                if let image = response.result.value{
                    onSuccess(image)
                }
            }else if response.result.isFailure{
                onFailure(response.error?.localizedDescription as! Error)
            }
        }
    }
}
