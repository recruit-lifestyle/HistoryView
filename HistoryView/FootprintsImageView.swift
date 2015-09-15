//
//  FootprintsImageView.swift
//  HistoryView
//
//  Created by Takeshi Ihara on 2015/09/13.
//  Copyright (c) 2015年 Takeshi Ihara. All rights reserved.
//

import UIKit

protocol FootprintsImageViewDelegate: class {
    func footprintsTapped(index: Int)
}

class FootprintsImageView: UIImageView {
    weak var delegate: FootprintsImageViewDelegate? = nil
    var navigationIndex = 0
    
    override init(image: UIImage!) {
        super.init(image: image)
        self.userInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapped:"))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapped(gesture: UITapGestureRecognizer) {
        self.delegate?.footprintsTapped(self.navigationIndex)
    }
}
