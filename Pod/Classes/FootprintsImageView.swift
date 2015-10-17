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
    weak var delegate: FootprintsImageViewDelegate?
    var navigationIndex = 0
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
