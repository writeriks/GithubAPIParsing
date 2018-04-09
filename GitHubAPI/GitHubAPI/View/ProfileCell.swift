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
            nameLabel.text = resultRepositoryObject?.repositoryUser?.userName
            numberOfFollowersLabel.text = "Followers : " + String(describing: (resultRepositoryObject?.repositoryUser?.followers)!)
            if resultRepositoryObject?.repositoryUser?.profileImage != nil{
                avatarImageView.image = resultRepositoryObject?.repositoryUser?.profileImage
            }
            numberOfStarsLabel.text = "Stars : " + String(describing: (resultRepositoryObject?.repositoryUser?.starCount)!)
        }
    }
    var resultUserObject: User? {
        didSet {
            nameLabel.text = resultUserObject?.userName
            numberOfFollowersLabel.text = "Followers : " + String(describing: (resultUserObject?.followers)!)
            if resultUserObject?.profileImage != nil{
                avatarImageView.image =  (resultUserObject?.profileImage)!
            }
            numberOfStarsLabel.text = "Stars : " + String(describing: (resultUserObject?.starCount)!)
        }
    }
    
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
    
    
    override func setUpViews() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(numberOfStarsLabel)
        addSubview(numberOfFollowersLabel)
        
        let yCor   : CGFloat = (self.contentView.frame.size.height) / 10
        let width  : CGFloat = (self.contentView.frame.size.width) / 3
        let height : CGFloat = width
        let xCor = (self.contentView.frame.size.width) / 2 - width / 2
        avatarImageView.frame = CGRect(x: xCor, y: yCor, width: width, height: height)
        
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: avatarImageView, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: avatarImageView, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: numberOfStarsLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: numberOfStarsLabel, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 30))
        
        addConstraint(NSLayoutConstraint(item: numberOfFollowersLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: numberOfFollowersLabel, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -30))
    }
}
