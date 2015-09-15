//
//  ViewController.swift
//  HistoryView
//
//  Created by Takeshi Ihara on 2015/09/13.
//  Copyright (c) 2015年 Takeshi Ihara. All rights reserved.
//

import UIKit

class ViewController: HistoryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index: Int = self.navigationController?.viewControllers.count {
            self.title = "画面\(index)"
            setBgColor(index)
        }
        
        let rightBtn = UIBarButtonItem(title: ">>", style: .Plain, target: self, action: "popViewCtr:")
        self.navigationItem.rightBarButtonItem = rightBtn
        
        let homeBtn = UIButton(frame: CGRectMake(0.0, 0.0, 60.0, 49.0))
        homeBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 230.0)
        homeBtn.setImage(UIImage(named: "Home"), forState: .Normal)
        homeBtn.addTarget(self, action: "popFootprintsViewCtr:", forControlEvents: .TouchDown)
        self.view.addSubview(homeBtn)
        
        self.historyRowNum = 3
        self.footViewCtr.titleLabel.text = "History"
        self.footViewCtr.closeBtn.tintColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
}

// MARK: BackgroundColor
extension ViewController {
    func setBgColor(index: Int) {
        switch index % 4 {
        case 0:
            return self.view.backgroundColor = .blackColor()
        case 1:
            return self.view.backgroundColor = .yellowColor()
        case 2:
            return self.view.backgroundColor = .blueColor()
        case 3:
            return self.view.backgroundColor = .redColor()
        default:
            return self.view.backgroundColor = .whiteColor()
        }
    }
}

// MARK: Touch Action
extension ViewController {
    func popViewCtr(btn: UIBarButtonItem) {
        let viewCtr = ViewController()
        self.navigationController?.pushViewController(viewCtr, animated: true)
    }
    
    func popFootprintsViewCtr(btn: UIButton) {
        btn.highlighted = false
        popFootprintsView()
    }
}
