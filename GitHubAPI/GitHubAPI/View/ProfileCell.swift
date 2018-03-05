//
//  ProfileCell.swift
//  GitHubAPI
//
//  Created by Emir haktan Ozturk on 1.03.2018.
//  Copyright © 2018 emirhaktan. All rights reserved.
//

import UIKit

class ProfileCell: BaseCell {
    var resultRepositoryObject: Repository? {
        didSet {
            setupUserProfile()
            setupUserAvatarImage()
            self.setupStars(pageIndex: 1)
        }
    }
    var resultUserObject: User? {
        didSet {
            setupUserProfile()
            setupUserAvatarImage()
            self.setupStars(pageIndex: 1)
        }
    }
    var starCount : Int = 0
    
    func setupUserProfile(){
        if let user = resultUserObject{
            APIManager.sharedInstance.getSpecificUser(userName: (user.userName)!, onSuccess: { (user) in
                let user = user
                DispatchQueue.main.async {
                    self.nameLabel.text = user.userName
                    self.numberOfFollowersLabel.text = "Followers : " + String(describing : user.followers!)
                }
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
        if let repository = resultRepositoryObject{
            APIManager.sharedInstance.getSpecificUser(userName: (repository.repositoryUser?.userName)!, onSuccess: { (user) in
                let user = user
                DispatchQueue.main.async {
                    self.nameLabel.text = user.userName
                    self.numberOfFollowersLabel.text = "Followers : " + String(describing : user.followers!)
                }
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
    }
    
    func setupUserAvatarImage(){
        if let userAvatarImageUrl = resultRepositoryObject?.repositoryUser?.userAvatarImageUrl{
            APIManager.sharedInstance.loadImage(url: userAvatarImageUrl, onSuccess: { (image) in
                DispatchQueue.main.async {
                self.avatarImageView.image = image
                }
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
        if let userAvatarImageUrl = resultUserObject?.userAvatarImageUrl{
            APIManager.sharedInstance.loadImage(url: userAvatarImageUrl, onSuccess: { (image) in
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
    }
    
    func setupStars(pageIndex:Int) {
        var index = pageIndex
        
        if let user = self.resultUserObject{
            APIManager.sharedInstance.getListOfReposForSpecificUser(userName: (user.userName)!, page: pageIndex, onSuccess: { (repository) in
                    if !repository.isEmpty{
                        for item in repository{
                            self.starCount += item.stars!
                        }
                        index += 1
                        self.setupStars(pageIndex: index)
                    }else{
                        DispatchQueue.main.async {
                        self.numberOfStarsLabel.text =  "Stars : " + String(describing: self.starCount)
                        }
                }
                
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
        if let repository = self.resultRepositoryObject{
            APIManager.sharedInstance.getListOfReposForSpecificUser(userName: (repository.repositoryUser?.userName)!, page: pageIndex, onSuccess: { (repository) in
                if !repository.isEmpty{
                    for item in repository{
                        self.starCount += item.stars!
                    }
                    index += 1
                    self.setupStars(pageIndex: index)
                }else{
                    DispatchQueue.main.async {
                    self.numberOfStarsLabel.text =  "Stars : " + String(describing: self.starCount)
                    }
                }
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
    }
    
    // UI Objects
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "name"
        return label
    }()
    
    let numberOfStarsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Stars : 0"
        return label
    }()
    
    let numberOfFollowersLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Followers : 0"
        return label
    }()
    
    let avatarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Setup UI Objects
    override func setUpViews() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(numberOfStarsLabel)
        addSubview(numberOfFollowersLabel)
        // ImageView Constraints
        let yCor   : CGFloat = (self.contentView.frame.size.height) / 10
        let width  : CGFloat = (self.contentView.frame.size.width) / 3
        let height : CGFloat = width
        let xCor = (self.contentView.frame.size.width) / 2 - width / 2
        avatarImageView.frame = CGRect(x: xCor, y: yCor, width: width, height: height)
        // nameLabel Constraints
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: avatarImageView, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: avatarImageView, attribute: .centerX, multiplier: 1, constant: 0))
        // numberOfStarsLabel Constraints
        addConstraint(NSLayoutConstraint(item: numberOfStarsLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: numberOfStarsLabel, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 30))
        // numberOfFollowersLabel Constraints
        addConstraint(NSLayoutConstraint(item: numberOfFollowersLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: numberOfFollowersLabel, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -30))
    }
}
