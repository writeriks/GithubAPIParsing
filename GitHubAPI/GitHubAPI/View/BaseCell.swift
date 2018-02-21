//
//  BaseCell.swift
//  CollectionViewMockUp
//
//  Created by Emir haktan Ozturk on 16.02.2018.
//  Copyright © 2018 emirhaktan. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
