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
            setUpUserAvatarImage()
        }
    }
    var resultUserObject: User? {
        didSet {
            nameLabel.text = resultUserObject?.userName
            setUpUserAvatarImage()
        }
    }
    func setUpUserAvatarImage(){
        if let userAvatarImageUrl = resultRepositoryObject?.repositoryUser?.userAvatarImageUrl{
            APIManager.sharedInstance.loadImage(url: userAvatarImageUrl, onSuccess: { (image) in
                self.avatarImageView.image = image
            }, onFailure: { (error) in
                print(error.localizedDescription)
            })
        }
        if let userAvatarImageUrl = resultUserObject?.userAvatarImageUrl{
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
        
        //         avatarImageView Horizontal Constraint
        addConstraintsWithFormat(format: "H:|-5-[v0(70)]-10-[v1]|", views: avatarImageView,nameLabel)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: avatarImageView)
        
        //        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: nameLabel)
        
        // nameLabel Top Constraint
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0)) // titleLabel'ın üst kısmı, thumbnail imageView'ın 1x8 px altında.
    }

}
