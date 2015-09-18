//
//  FootprintsCollectionViewCell.swift
//  HistoryView
//
//  Created by Takeshi Ihara on 2015/09/18.
//  Copyright (c) 2015年 Takeshi Ihara. All rights reserved.
//

import UIKit

class FootprintsCollectionViewCell: UICollectionViewCell {
    let footprintsImageView = FootprintsImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(footprintsImageView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
