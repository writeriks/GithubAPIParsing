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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(String(describing:user?.userName!))
        self.navigationController?.navigationBar.backgroundColor = UIColor.brown
        // Register cell classes
        self.collectionView!.register(ProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        cell.backgroundColor = UIColor.red
        // Configure the cell
    
        return cell
    }
}
