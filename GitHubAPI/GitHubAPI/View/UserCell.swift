//
//  HomeCell.swift
//  GitHubAPI
//
//  Created by Emir haktan Ozturk on 22.02.2018.
//  Copyright © 2018 emirhaktan. All rights reserved.
//

import UIKit

class UserCell: BaseCell {

    var user: User? {
        didSet {
            nameLabel.text = user?.userName
            setUpUserAvatarImage()
        }
    }
    
    func setUpUserAvatarImage(){
        if let userAvatarImageUrl = user?.userAvatarImageUrl{
            APIManager.sharedInstance.loadImage(url: userAvatarImageUrl, onSuccess: { (image) in
                self.avatarImageView.image = image
            }, onFailure: { (error) in
                print(error.localizedDescription)
            })
        }
    }
    
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.left
        label.text = "User/Repository Name"
        return label
    }()
    
    let avatarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
//        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func setUpViews() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        
        // avatarImageView Horizontal Constraint
        addConstraintsWithFormat(format: "H:|-5-[v0(70)]-10-[v1]|", views: avatarImageView,nameLabel)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: avatarImageView)
        
//        addConstraintsWithFormat(format: "H:|-5-[v0]-5-[v1]|", views: avatarImageView,nameLabel)
        
        // nameLabel Top Constraint
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0)) // titleLabel'ın üst kısmı, thumbnail imageView'ın 1x8 px altında.
    }
}
