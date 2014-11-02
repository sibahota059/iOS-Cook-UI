//
//  XPRefreshAnimationBaseView.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/24/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPRefreshBaseView: UIView {
    var id:Int?;
    var scrollView:UIScrollView?
    var state:XPRefreshState;
    var animationView:XPRefreshAnimationBaseView?
    var refreshing:Bool?;
    var beginRefreshingClosure:()->();
    var _refreshResult:XPRefreshResult?;
    
    override convenience init() {
        self.init(frame:CGRectZero);
    }

    required init(coder aDecoder: NSCoder) {
        self.state = XPRefreshState.Normal;
        self.beginRefreshingClosure = {() -> () in };
        super.init(coder:aDecoder);
    }
    
    override init(frame: CGRect) {
        self.state = XPRefreshState.Normal;
        var newFrame:CGRect = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: XPRefreshTableViewConfig.XPRefreshViewHeight);
        self.beginRefreshingClosure = {() -> () in };
        super.init(frame: newFrame);
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
        self.backgroundColor = UIColor.clearColor();
    }
    
    override func willMoveToSuperview(newSuperview: UIView?){
        super.willMoveToSuperview(newSuperview);
        if let superview = newSuperview{
            var frame:CGRect = CGRect(x:self.frame.origin.x, y:self.frame.origin.y, width:superview.frame.size.width, height:self.frame.size.height);
            self.frame = frame;
        }
        
        if let serperview = newSuperview{
            serperview.addObserver(self,forKeyPath:XPRefreshTableViewConfig.XPRefreshContentOffset,options:NSKeyValueObservingOptions.New,context:nil)
        }

        self.scrollView = newSuperview as? UIScrollView;
    }
    
}
