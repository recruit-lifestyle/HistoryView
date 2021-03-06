//
//  HistoryViewController.swift
//  HistoryView
//
//  Created by Takeshi Ihara on 2015/09/13.
//  Copyright (c) 2015年 Takeshi Ihara. All rights reserved.
//

import UIKit

enum Footprints: String {
    case Back = "BackToPreViewCtr"
}

public class HistoryViewController: UIViewController {
    public var historyRowNumber = 3
    public let footViewController = FootprintsViewController()
    
    convenience public init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override public init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: Footprints.Back.rawValue, object: nil)
    }
}

// MARK: Footprints
extension HistoryViewController {
    public func popFootprintsView() {
        if let viewControllers = self.navigationController?.viewControllers {
            footViewController.rowNumber = historyRowNumber
            footViewController.viewControllers = viewControllers
            footViewController.navigationBar.backgroundColor = UINavigationBar.appearance().barTintColor
            footViewController.setFootprints()
            self.presentViewController(footViewController, animated: true, completion: { () -> Void in
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "back:", name: Footprints.Back.rawValue, object: nil)
            })
        }
    }
}

// MARK: Notification
extension HistoryViewController {
    func back(notification: NSNotification) {
        if let userInfo = notification.userInfo, index = userInfo["Index"] as? Int {
            let vc: AnyObject? = self.navigationController?.viewControllers[index]
            self.navigationController?.popToViewController(vc as! UIViewController, animated: true)
        }
    }
}