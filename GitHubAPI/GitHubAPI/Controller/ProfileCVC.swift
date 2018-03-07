//
//  ProfileCVC.swift
//  GitHubAPI
//
//  Created by Emir haktan Ozturk on 1.03.2018.
//  Copyright © 2018 emirhaktan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProfileCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user:User?
    var repository:Repository?
    var starCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.brown
        self.title = user?.userName
        setupUserProfile()
        self.setupStars(pageIndex: 1)
        setupUserAvatarImage()
        // Register cell classes
        self.collectionView!.register(ProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    func setupStars(pageIndex:Int) {
        var index = pageIndex
        if let user = self.user{
            APIManager.sharedInstance.getListOfReposForSpecificUser(userName: (user.userName)!, page: pageIndex, onSuccess: { (repository) in
                if !repository.isEmpty{
                    for item in repository{
                        self.user?.starCount += item.stars!
                    }
                    index += 1
                    self.setupStars(pageIndex: index)
                }else{
                    self.collectionView?.reloadData()
                }
                
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
        if let repository = self.repository{
            APIManager.sharedInstance.getListOfReposForSpecificUser(userName: (repository.repositoryUser?.userName)!, page: pageIndex, onSuccess: { (repository) in
                if !repository.isEmpty{
                    for item in repository{
                        self.repository?.repositoryUser?.starCount += item.stars!
                    }
                    index += 1
                    self.setupStars(pageIndex: index)
                }else{
                    self.collectionView?.reloadData()
                }
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
    }
    
    func setupUserAvatarImage(){
        if let userAvatarImageUrl = repository?.repositoryUser?.userAvatarImageUrl{
            APIManager.sharedInstance.loadImage(url: userAvatarImageUrl, onSuccess: { (image) in
                self.user?.profileImage = image
                self.collectionView?.reloadData()
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
        if let userAvatarImageUrl = user?.userAvatarImageUrl{
            APIManager.sharedInstance.loadImage(url: userAvatarImageUrl, onSuccess: { (image) in
                self.user?.profileImage = image
                self.collectionView?.reloadData()
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
    }
    
    func setupUserProfile(){
        if let user = self.user{
            APIManager.sharedInstance.getSpecificUser(userName: (user.userName)!, onSuccess: { (user) in
                self.user = user
                self.collectionView?.reloadData()
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
        if let repository = self.repository{
            APIManager.sharedInstance.getSpecificUser(userName: (repository.repositoryUser?.userName)!, onSuccess: { (user) in
                self.user = user
                self.collectionView?.reloadData()
            }, onFailure: { (error) in
                self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        cell.backgroundColor = UIColor.red
        // Configure the cell
    
        if self.user != nil {
            cell.resultUserObject = user
            return cell
        }else{
            cell.resultRepositoryObject = repository
            return cell
        }
        
    }
}
