//
//  ViewController.swift
//  HistoryView
//
//  Created by Takeshi Ihara on 2015/08/13.
//  Copyright (c) 2015年 Takeshi Ihara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let historyView = HistoryView(frame: CGRectMake(0.0, UIScreen.mainScreen().bounds.size.height,
                                                    UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "popView:", name: "Pop", object: nil)
        
        if let index: Int = self.navigationController?.viewControllers.count { self.view.backgroundColor = rtrColor(index) }
        
        self.view.addSubview(historyView)
        
        let homeBtn = UIButton(frame: CGRectMake(0.0, 0.0, 60.0, 49.0))
        homeBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 230.0)
        homeBtn.setImage(UIImage(named: "Home"), forState: .Normal)
        homeBtn.addTarget(self, action: "homeBtnTapped:", forControlEvents: .TouchDown)
        self.view.addSubview(homeBtn)
        
        let rightBtn = UIBarButtonItem(title: ">>", style: .Plain, target: self, action: "navBtnTapped:")
        self.navigationItem.rightBarButtonItem = rightBtn
        
        if let viewCtrs = self.navigationController?.viewControllers { historyView.setPreView(viewCtrs) }
    }
    
    func navBtnTapped(btn: UIBarButtonItem) {        
        let viewCtr = ViewController()
        self.navigationController?.pushViewController(viewCtr, animated: true)
    }
    
    func homeBtnTapped(btn: UIButton) {
        UIView.animateWithDuration(0.4,
            animations: { () -> Void in
                self.historyView.upDown()
            }) { (Bool) -> Void in
                self.historyView.condition = !self.historyView.condition
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func rtrColor(index: Int) -> UIColor {
        switch index % 3 {
            case 0:
                return .blackColor()
            case 1:
                return .yellowColor()
            case 2:
                return .blueColor()
            default:
                return .whiteColor()
        }
    }
    
    func popView(notification: NSNotification) {
        if let userInfo = notification.userInfo, index = userInfo["index"] as? Int {
            
            let vc: AnyObject? = self.navigationController?.viewControllers[index]
            self.navigationController?.popToViewController(vc as! UIViewController, animated: true)
        }
    }
}

class HistoryView: UIView, UIScrollViewDelegate {
    
    let sv = UIScrollView(frame: CGRectMake(0.0, 64.0, UIScreen.mainScreen().bounds.width, 62.0 + 178.0 * 2.0))
    let pc = UIPageControl()
    var condition = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .whiteColor()
        
        sv.delegate = self
        sv.backgroundColor = .whiteColor()
        sv.contentSize = CGSizeMake(sv.frame.size.width, sv.frame.size.height - 64.0)
        sv.pagingEnabled = true
        sv.bounces = false
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        self.addSubview(sv)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPreView(viewCtrs: [AnyObject]) {
        
        pc.frame = CGRectMake(0.0, sv.frame.size.height + 25.0, self.frame.size.width, 60.0)
        pc.numberOfPages = (viewCtrs.count - 1)/6 + 1
        pc.hidesForSinglePage = true
        pc.pageIndicatorTintColor = .grayColor()
        pc.currentPageIndicatorTintColor = .blackColor()
        pc.addTarget(self, action: "pageControl:", forControlEvents: .ValueChanged)
        self.addSubview(pc)
        
        sv.contentSize = CGSizeMake(sv.frame.size.width * CGFloat((viewCtrs.count - 1)/6 + 1), sv.frame.size.height - 64.0)
        
        for (var i = 0 ; i < viewCtrs.count ; i++) {
            if let preView: UIView = (viewCtrs[i] as! UIViewController).view {
                let iv = UIImageView(image: preView.toImage())
                let index = i%6
                iv.frame = CGRectMake(17.5 + (100.0 + 20.0) * CGFloat(index%3) + sv.frame.size.width * CGFloat(i/6),
                                      -48.0 + (178.0 + 20.0) * CGFloat(index/3), 100.0, 178.0)
                iv.userInteractionEnabled = true
                iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapped:"))
                iv.tag = 100 + i
                sv.addSubview(iv)
            }
        }
    }
    
    func pageControl(sender: AnyObject) {
        
        let frame = sv.frame
        sv.contentOffset = CGPointMake(frame.size.width * CGFloat(pc.currentPage), 64.0)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pc.currentPage = Int(sv.contentOffset.x / sv.frame.size.width)
    }
    
    func upDown() {
        let extend = self.condition ? UIScreen.mainScreen().bounds.height : -UIScreen.mainScreen().bounds.height
        self.center = CGPointMake(self.center.x, self.center.y + extend)
    }
    
    func tapped(gesture: UIGestureRecognizer) {
        if let view = gesture.view {
            NSNotificationCenter.defaultCenter().postNotificationName("Pop", object: self, userInfo: ["index": view.tag - 100])
        }
    }
}

extension UIView {
    
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0.0, 0.0)
        self.layer.renderInContext(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

