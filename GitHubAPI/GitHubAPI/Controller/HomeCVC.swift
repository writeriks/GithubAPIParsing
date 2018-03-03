//
//  HomeCVC.swift
//  GitHubAPI
//
//  Created by Emir haktan Ozturk on 21.02.2018.
//  Copyright © 2018 emirhaktan. All rights reserved.
//

import UIKit

private let reuseIdentifierForUser = "UserCell"
private let reuseIdentifierForRepo = "RepositoryCell"

class HomeCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var user : [User]?
    var repository : [Repository]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.yellow
        collectionView?.keyboardDismissMode = .interactive
        self.setSearchBar()
        
        // Register cell classes
        self.collectionView!.register(UserCell.self, forCellWithReuseIdentifier: reuseIdentifierForUser)
        self.collectionView!.register(RepositoryCell.self, forCellWithReuseIdentifier: reuseIdentifierForRepo)
    }
    
    func setSearchBar(){
        let width = self.view.frame.width - 40
        let height = 20.0
        let searchBar :UISearchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: Double(width), height: height))
        searchBar.placeholder = "Search"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.delegate = self
    }
    
    func loadUsersAndRepositories(name:String){
        
            APIManager.sharedInstance.getUserWithName(userName: name, onSuccess: { (user) in
                self.user = user
                self.user?.sort(by: { (obj1,obj2 ) -> Bool in
                    return (obj1.id!) < (obj2.id!)
                })
                APIManager.sharedInstance.getRepositoryWithName(repositoryName: name, onSuccess: { (repository) in
                    self.repository = repository
                    //                print(repository[0].name as Any)
                    //                print(String(describing : repository[1].user?.id))
                    self.repository?.sort(by: { (obj1, obj2) -> Bool in
                        return (obj1.id!) < (obj2.id!)
                    })
                    self.collectionView?.reloadData()
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
                ,onFailure: { error in
                    print(error.localizedDescription)
            })
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        loadUsersAndRepositories(name: searchBar.text!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.view.frame.width-16-16) * 9 / 32
        return CGSize(width: view.frame.width-8-8, height: height)// collection view uitableview gibi görünmesi için
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if user != nil && repository != nil{
            let count = user!.count + repository!.count
            return count
        }else{
            return user?.count ?? 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        if indexPath.row % 2 == 0 {
            let path = indexPath.item / 2
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForUser, for: indexPath) as! UserCell
            cell.backgroundColor = UIColor.red
            cell.user = user?[path]
            return cell
        }else {
            let path = indexPath.item / 2
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForRepo, for: indexPath) as! RepositoryCell
            cell.backgroundColor = UIColor.green
            cell.repository = repository?[path]
            return cell
        }
        
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
