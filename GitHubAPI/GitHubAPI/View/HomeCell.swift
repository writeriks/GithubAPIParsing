//
//  resultCell.swift
//  GitHubAPI
//
//  Created by Emir haktan Ozturk on 3.03.2018.
//  Copyright © 2018 emirhaktan. All rights reserved.
//

import UIKit

class HomeCell: BaseCell {
    
    
    var resultRepositoryObject: Repository? {
        didSet {
            nameLabel.text = resultRepositoryObject?.name
            typeLabel.text = "Repository"
            setupUserAvatarImage()
        }
    }
    var resultUserObject: User? {
        didSet {
            nameLabel.text = resultUserObject?.userName
            typeLabel.text = "User"
            setupUserAvatarImage()
        }
    }
    func setupUserAvatarImage(){
        if let userAvatarImageUrl = resultRepositoryObject?.repositoryUser?.userAvatarImageUrl{
            APIManager.sharedInstance.loadImage(url: userAvatarImageUrl, onSuccess: { (image) in
                self.avatarImageView.image = image
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
        if let userAvatarImageUrl = resultUserObject?.userAvatarImageUrl{
            APIManager.sharedInstance.loadImage(url: userAvatarImageUrl, onSuccess: { (image) in
                self.avatarImageView.image = image
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
    }
    
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "User/Repository Name"
        return label
    }()
    
    let typeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.left
        label.font = label.font.withSize(13)
        label.text = "User/Repository"
        return label
    }()
    
    let avatarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func setUpViews() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(typeLabel)
        
        let width = (self.contentView.frame.size.height - 10)
        avatarImageView.frame = CGRect(x: 5, y: 5, width: width, height: width)
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: avatarImageView, attribute: .right, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: typeLabel, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -10))
        addConstraint(NSLayoutConstraint(item: typeLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
    }

}
