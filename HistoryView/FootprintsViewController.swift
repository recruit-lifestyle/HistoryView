//
//  FootprintsViewController.swift
//  HistoryView
//
//  Created by Takeshi Ihara on 2015/09/13.
//  Copyright (c) 2015年 Takeshi Ihara. All rights reserved.
//

import UIKit

class FootprintsViewController: UIViewController {
    var rowNumber: Int?
    private var viewControllers = [AnyObject]()
    
    let navigationBar = UIView(frame: CGRectMake(0.0, 0.0, UIScreen.mainScreen().bounds.width, 64.0))
    var closeButton = UIImageView(image: UIImage(named: "Close")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate))
    var titleLabel = UILabel(frame: CGRectMake(0.0, 20.0, UIScreen.mainScreen().bounds.width, 44.0))
    
    private let scrollView = UIScrollView(frame: CGRectMake(0.0, 64.0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 64.0))
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .whiteColor()
        
        closeButton.frame = CGRectMake(14.0, 38.0, 14.0, 14.0)
        closeButton.userInteractionEnabled = true
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismiss:"))
        navigationBar.addSubview(closeButton)
        
        titleLabel.text = "History"
        titleLabel.textAlignment = .Center
        navigationBar.addSubview(titleLabel)
        
        self.view.addSubview(navigationBar)
        self.view.addSubview(scrollView)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: Tap Action
extension FootprintsViewController {
    func dismiss(gesture: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: Footprints
extension FootprintsViewController {
    func setFootprints(viewCtrs: [AnyObject]) {
        let space: CGFloat = 10.0
        let areaSize = CGSizeMake(self.view.frame.size.width/CGFloat(rowNumber!) - (space * 2.0),
            self.view.frame.size.height/CGFloat(rowNumber!) - (space * 2.0))
        for (index, viewCtr) in enumerate(viewCtrs) {
            if let preViewCtr = viewCtr as? UIViewController {
                let screenshot = preViewCtr.view.screenshot()
                let footprintsImageView = FootprintsImageView(image: screenshot)
                footprintsImageView.delegate = self
                footprintsImageView.navigationIndex = index
                footprintsImageView.frame = CGRectMake(CGFloat(index%rowNumber!) * (areaSize.width + (space * 2.0)) + space,
                    CGFloat(index/rowNumber!) * (areaSize.height + (space * 2.0)) + space,
                    areaSize.width, areaSize.height)
                scrollView.addSubview(footprintsImageView)
            }
        }
        scrollView.contentSize.height = CGFloat((viewCtrs.count - 1)/rowNumber! + 1) * self.view.frame.size.height/CGFloat(rowNumber!)
    }
}

// MARK: FootprintsImageViewDelegate
extension FootprintsViewController: FootprintsImageViewDelegate {
    func footprintsTapped(index: Int) {
        self.dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotificationName(Footprints.Back.rawValue, object: self, userInfo: ["Index": index])
    }
}
