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

class HistoryViewController: UIViewController {
    var historyRowNum = 3
    let footViewCtr = FootprintsViewController()
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: Footprints.Back.rawValue, object: nil)
    }
}

// MARK: Footprints
extension HistoryViewController {
    func popFootprintsView() {
        if let viewCtrs = self.navigationController?.viewControllers {
            footViewCtr.rowNum = historyRowNum
            footViewCtr.navBar.backgroundColor = UINavigationBar.appearance().barTintColor
            footViewCtr.setFootprints(viewCtrs)
            self.presentViewController(footViewCtr, animated: true, completion: { () -> Void in
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