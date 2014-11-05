//
//  XPRefreshAnimationBaseView.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/24/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPRefreshBaseView: UIView {
    var id:Int;
    var scrollView:UIScrollView!
    var _state:XPRefreshState;
    var animationView:XPRefreshAnimationBaseView!
    var refreshing:Bool!;
    var beginRefreshingClosure:()->();
    var _refreshResult:XPRefreshResult?;
    var state:XPRefreshState{
        get{
            return _state;
        }
        set(newstate){
            if(_state == newstate){
                return;
            }
            var oldState = _state;
            _state = newstate;
            switch(oldState){
                case XPRefreshState.Normal:
                    if(newstate == XPRefreshState.Pulling){
                        // normal to pulling
                        self.animationView!.refreshViewAniToBePulling();
                    }
                case XPRefreshState.Refreshing:
                    if(newstate == XPRefreshState.Normal){
                        //refreshing to nomal
                        self.animationView!.refreshViewEndRefreshing(_refreshResult!)
                        switch _refreshResult!{
                            case XPRefreshResult.None:
                                self.resumeContentInset();
                                self.animationView.refreshViewAniToBeNormal();
                            case XPRefreshResult.Failure:
                                let delay = XPRefreshTableViewConfig.XPRefreshShowResultAnimationDuration * Double(NSEC_PER_SEC)
                                var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay));
                                dispatch_after(dispatchTime, dispatch_get_main_queue(), {[weak self] ()->() in
                                    UIView.animateWithDuration(XPRefreshTableViewConfig.XPRefreshSlowAnimationDuration, animations: {()->() in
                                        if let strongSelf = self{
                                            strongSelf.resumeContentInset();
                                            strongSelf.animationView.refreshViewAniToBeNormal();
                                        }
                                        
                                    })
                                })
                            case XPRefreshResult.Success:
                                let delay = XPRefreshTableViewConfig.XPRefreshShowResultAnimationDuration * Double(NSEC_PER_SEC)
                                var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay));
                                dispatch_after(dispatchTime, dispatch_get_main_queue(), {[weak self] ()->() in
                                    UIView.animateWithDuration(XPRefreshTableViewConfig.XPRefreshSlowAnimationDuration, animations: {()->() in
                                        if let strongSelf = self{
                                            strongSelf.resumeContentInset();
                                            strongSelf.animationView.refreshViewAniToBeNormal();
                                        }
                                        
                                    })
                                })
                        }
                    }
                case XPRefreshState.Pulling:
                    if(newstate == XPRefreshState.Normal){
                        self.animationView.refreshViewAniToBeNormal();
                    }else if(newstate == XPRefreshState.Refreshing){
                        self.setRefreshingContentInset();
                        self.animationView.refreshViewBeginRefreshing();
                        self.beginRefreshingClosure();
                    }
            }
        }
    }
    
    override convenience init() {
        self.init(frame:CGRectZero);
    }

    required init(coder aDecoder: NSCoder) {
        _state = XPRefreshState.Normal;
        id = 0;
        self.beginRefreshingClosure = {() -> () in };
        super.init(coder:aDecoder);
    }
    
    override init(frame: CGRect) {
        id = 0;
        _state = XPRefreshState.Normal;
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
            superview.addObserver(self,forKeyPath:XPRefreshTableViewConfig.XPRefreshContentOffset,options:NSKeyValueObservingOptions.New,context:nil);
        }
        

        self.scrollView = newSuperview as? UIScrollView;
    }
    
    func endRefreshingWithResult(result:XPRefreshResult){
        _refreshResult = result;
        self.state = XPRefreshState.Normal;
    }
    
    func resumeContentInset(){
        //wait to be override
    }
    
    func setRefreshingContentInset(){
        //wait to be override
    }
    
}
