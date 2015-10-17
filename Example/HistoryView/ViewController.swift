//
//  ViewController.swift
//  HistoryView
//
//  Created by Takeshi Ihara on 2015/09/13.
//  Copyright (c) 2015年 Takeshi Ihara. All rights reserved.
//

import UIKit
import HistoryView

class ViewController: HistoryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index: Int = self.navigationController?.viewControllers.count {
            self.title = "Screen\(index)"
            setBackgroundColor(index)
        }
        
        let rightButton = UIBarButtonItem(title: ">>", style: .Plain, target: self, action: "popViewCtr:")
        self.navigationItem.rightBarButtonItem = rightButton
        
        let homeButton = UIButton(frame: CGRectMake(0.0, 0.0, 60.0, 49.0))
        homeButton.center = CGPointMake(self.view.center.x, self.view.center.y + 230.0)
        homeButton.setImage(UIImage(named: "Home"), forState: .Normal)
        homeButton.addTarget(self, action: "popFootprintsViewCtr:", forControlEvents: .TouchDown)
        self.view.addSubview(homeButton)
        
        self.historyRowNumber = 3
        self.footViewController.titleLabel.text = "History"
        self.footViewController.closeButton.tintColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
}

// MARK: BackgroundColor
extension ViewController {
    func setBackgroundColor(index: Int) {
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
    func popViewCtr(button: UIBarButtonItem) {
        let viewController = ViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popFootprintsViewCtr(button: UIButton) {
        button.highlighted = false
        popFootprintsView()
    }
}
