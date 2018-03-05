//
//  HomeCVC.swift
//  GitHubAPI
//
//  Created by Emir haktan Ozturk on 21.02.2018.
//  Copyright © 2018 emirhaktan. All rights reserved.
//

import UIKit
import UILoadControl

private let reuseIdentifierForUser = "UserCell"
private let reuseIdentifierForRepo = "RepositoryCell"

class HomeCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var user = [User]()
    var repository = [Repository]()
    var final = [Final]()
    
    var index : Int = 0
    var searchText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.yellow
        collectionView?.keyboardDismissMode = .interactive
        self.setupSearchBar()
        self.collectionView?.loadControl = UILoadControl(target: self, action: #selector(loadNextPage(sender:)))
        self.collectionView?.loadControl?.heightLimit = 100.0 //The default is 80.0
        self.collectionView?.loadControl?.tintColor = UIColor.red
        self.setupRefreshControl()
        // Register cell classes
        self.collectionView!.register(HomeCell.self, forCellWithReuseIdentifier: reuseIdentifierForUser)
    }
    
    func setupRefreshControl(){
        let refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                #selector(HomeCVC.loadPreviousPage(_:)),
                                     for: UIControlEvents.valueChanged)
            refreshControl.tintColor = UIColor.red
            return refreshControl
        }()
        self.collectionView?.addSubview(refreshControl)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
    }
    
    @objc func loadNextPage(sender: AnyObject?) {
        self.index += 1
        self.loadUsersAndRepositories(name: self.searchText, index: self.index)
        self.collectionView?.loadControl?.endLoading()
        self.collectionView?.reloadData()
    }
    
    @objc func loadPreviousPage(_ refreshControl: UIRefreshControl) {
        self.index -= 1
        if self.index == 0 {
                self.index = 1
                self.loadUsersAndRepositories(name: self.searchText, index: self.index)
                self.collectionView?.reloadData()
                refreshControl.endRefreshing()
        }else{
            self.loadUsersAndRepositories(name: self.searchText, index: self.index)
            self.collectionView?.reloadData()
            refreshControl.endRefreshing()
        }
    }

    func setupSearchBar(){
        let width = self.view.frame.width - 40
        let height = 20.0
        let searchBar :UISearchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: Double(width), height: height))
        searchBar.placeholder = "Search"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.delegate = self
    }
    
    func loadUsersAndRepositories(name:String, index:Int){
        self.user.removeAll()
        self.repository.removeAll()
        self.final.removeAll()
        APIManager.sharedInstance.getUserWithName(userName: name, pageIndex: index, onSuccess: { (user) in
            self.user.append(contentsOf: user)
            self.user.sort(by: { (obj1,obj2 ) -> Bool in
                    return (obj1.id!) < (obj2.id!)
                })
            APIManager.sharedInstance.getRepositoryWithName(repositoryName: name, pageIndex: index, onSuccess: { (repository) in
                self.repository.append(contentsOf: repository)
                self.repository.sort(by: { (obj1, obj2) -> Bool in
                        return (obj1.id!) < (obj2.id!)
                    })
                    self.populateResult(user: self.user, repository: self.repository)
                    self.collectionView?.reloadData()
                }) { (error) in
                    self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
                }
            }
                ,onFailure: { error in
                    self.createAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
            })
    }
    
    func populateResult(user:[User], repository:[Repository]){
        for item in user{
            let element = Final()
            element.finalUser = item
            final.append(element)
        }
        for item in repository{
            let element = Final()
            element.finalRepository = item
            final.append(element)
        }
        final.sort { (f1, f2) -> Bool in
            return sortFinalArray(f1: f1, f2: f2)
        }
    }
    
    func sortFinalArray(f1:Final, f2:Final) -> Bool{
        if f1.finalUser != nil && f2.finalUser != nil {
            return (f1.finalUser!.id)! < (f2.finalUser!.id)!
        }else if f1.finalUser != nil && f2.finalRepository != nil{
            return (f1.finalUser!.id)! < (f2.finalRepository!.repositoryUser!.id)!
        }else if f1.finalRepository != nil && f2.finalUser != nil{
            return (f1.finalRepository!.id)! < (f2.finalUser!.id)!
        }else if f1.finalRepository != nil && f2.finalRepository != nil {
            return (f1.finalRepository!.id)! < (f2.finalRepository!.id)!
        }else{
            return false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text!
        loadUsersAndRepositories(name: self.searchText, index: self.index)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.index = 1
        searchBar.resignFirstResponder()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.view.frame.width-16-16) * 9 / 32
        return CGSize(width: view.frame.width-8-8, height: height)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.final.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForUser, for: indexPath) as! HomeCell
        cell.backgroundColor = UIColor.red
        
        if self.final[indexPath.row].finalUser != nil {
            cell.resultUserObject = final[indexPath.row].finalUser
            return cell
        }else{
            cell.resultRepositoryObject = final[indexPath.row].finalRepository
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let profileCVC = ProfileCVC(collectionViewLayout: layout)
        profileCVC.user = self.final[indexPath.row].finalUser
        profileCVC.repository = self.final[indexPath.row].finalRepository
        self.navigationController?.pushViewController(profileCVC, animated: true)
    }
}
