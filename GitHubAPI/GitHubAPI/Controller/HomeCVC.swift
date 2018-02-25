//
//  HomeCVC.swift
//  GitHubAPI
//
//  Created by Emir haktan Ozturk on 21.02.2018.
//  Copyright © 2018 emirhaktan. All rights reserved.
//

import UIKit
import Octokit

private let reuseIdentifier = "Cell"

//Searching User : https://api.github.com/search/users?q=ARANACAK USER&page=1&per_page=5
//Searching Repositories : https://api.github.com/search/repositories?q=ARANACAK REPO&page=1&per_page=5
// github token : 2dfa66bed9d994c76056afb994fb0da5c496587e

class HomeCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var user : [User]?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.yellow
        collectionView?.keyboardDismissMode = .interactive
        self.setSearchBar()
        
        
        
        // Register cell classes
        self.collectionView!.register(HomeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        APIManager.sharedInstance.getUserWithName(userName: searchBar.text!, onSuccess: { (user) in
//            self.user = user
//            self.collectionView?.reloadData()
//        }
//            ,onFailure: { error in
//                print(error.localizedDescription)
//        })
//    }
    
    func setSearchBar(){
        let width = self.view.frame.width - 40
        let height = 20.0
        let searchBar :UISearchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: Double(width), height: height))
        searchBar.placeholder = "Search Users"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.view.frame.width-16-16) * 9 / 120
        return CGSize(width: view.frame.width, height: height+16+68)// collection view uitableview gibi görünmesi için
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return user?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCell
    
        // Configure the cell
        cell.backgroundColor = UIColor.red
        cell.user = user?[indexPath.item]
        return cell
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
}
