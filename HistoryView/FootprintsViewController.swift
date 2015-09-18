//
//  FootprintsViewController.swift
//  HistoryView
//
//  Created by Takeshi Ihara on 2015/09/13.
//  Copyright (c) 2015年 Takeshi Ihara. All rights reserved.
//

import UIKit

class FootprintsViewController: UIViewController {
    var rowNumber = 3
    private var viewControllers = [AnyObject]()
    
    let navigationBar = UIView(frame: CGRectMake(0.0, 0.0, UIScreen.mainScreen().bounds.width, 64.0))
    var closeButton = UIImageView(image: UIImage(named: "Close")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate))
    var titleLabel = UILabel(frame: CGRectMake(0.0, 20.0, UIScreen.mainScreen().bounds.width, 44.0))
    
    private let collectionView = UICollectionView(frame: CGRectMake(0.0, 64.0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 64.0), collectionViewLayout: UICollectionViewLayout())
    private let layout = UICollectionViewFlowLayout()
    private let space: CGFloat = 10.0
    
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
        
        layout.sectionInset = UIEdgeInsetsMake(space, space, space, space)
        collectionView.registerClass(FootprintsCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = self.view.backgroundColor
        self.view.addSubview(collectionView)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension FootprintsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotificationName(Footprints.Back.rawValue, object: self, userInfo: ["Index": indexPath.row])
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as? FootprintsCollectionViewCell {
            if let preViewCtr = viewControllers[indexPath.row] as? UIViewController {
                cell.footprintsImageView.image = preViewCtr.view.screenshot()
                cell.footprintsImageView.delegate = self
                cell.footprintsImageView.navigationIndex = indexPath.row
                cell.footprintsImageView.frame = CGRectMake(0.0, 0.0, layout.itemSize.width, layout.itemSize.height)
            }
            return cell
        } else {
            return FootprintsCollectionViewCell()
        }
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
        viewControllers = viewCtrs
        
        layout.itemSize = CGSizeMake(self.view.frame.size.width/CGFloat(rowNumber) - (space * 2.0),
                                     self.view.frame.size.height/CGFloat(rowNumber) - (space * 2.0))
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
}

// MARK: FootprintsImageViewDelegate
extension FootprintsViewController: FootprintsImageViewDelegate {
    func footprintsTapped(index: Int) {
        collectionView(collectionView, didSelectItemAtIndexPath: NSIndexPath(forItem: index, inSection: 0))
    }
}
