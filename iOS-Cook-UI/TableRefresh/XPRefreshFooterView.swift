//
//  XPRefreshFooterView.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPRefreshFooterView: XPRefreshBaseView {    
    required convenience init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(){
        self.init(frame: CGRectZero);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview);
        
        self.adjustFooterView();
        
        if let superview = newSuperview{
            superview.addObserver(self, forKeyPath:XPRefreshTableViewConfig.XPRefreshContentSize, options:NSKeyValueObservingOptions.New, context:nil);
        }
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if (keyPath == XPRefreshTableViewConfig.XPRefreshContentSize){
            self.adjustFooterView();
        }
        
        if(self.state == XPRefreshState.Refreshing){
            return;
        }
        
        if(keyPath == XPRefreshTableViewConfig.XPRefreshContentOffset){
            self.changeStateWithContentOffset();
            
//            if let animation = self.animationView{
//                if(animation.respondsToSelector(Selector("refreshViewPullingToPosition:"))){
//                    if let scroll = self.scrollView{
//                        var position:CGFloat = scroll.contentOffset.y + scroll.bounds.size.height - scroll.contentSize.height - scroll.contentInset.bottom;
//                        if(position < 0 || position > XPRefreshTableViewConfig.XPRefreshViewHeight){
//                            return;
//                        }
//                        animation.refreshViewPullingToPosition(position);
//                    }
//                }
//            }
        }
    }
    
    func changeStateWithContentOffset(){
        if let scroll = self.scrollView{
            var currentOffsetY:CGFloat = scroll.contentOffset.y;
            var releaseToRefreshOffsetY = scroll.contentSize.height - scroll.bounds.size.height + scroll.contentInset.bottom;
            if(currentOffsetY <= releaseToRefreshOffsetY){
                return;
            }
            
            releaseToRefreshOffsetY += XPRefreshTableViewConfig.XPRefreshViewHeight;
            if(scroll.dragging){
                if(self.state == XPRefreshState.Normal && currentOffsetY > releaseToRefreshOffsetY){
                    self.state = XPRefreshState.Pulling;
                }else if(self.state == XPRefreshState.Pulling && currentOffsetY <= releaseToRefreshOffsetY){
                    self.state = XPRefreshState.Normal;
                }
            }else{
                if(self.state == XPRefreshState.Pulling){
                    self.state = XPRefreshState.Refreshing;
                }
            }
        }
        
    }
    
    func adjustFooterView(){
        if let scrollView = self.scrollView{
            var contentSizeHeight:CGFloat = scrollView.contentSize.height;
            var scrollHeight:CGFloat = scrollView.frame.size.height;
            self.frame.origin.y = max(contentSizeHeight, scrollHeight);
        }
    }
}
