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
        }
    }
    
    func changeStateWithContentOffset(){

            var currentOffsetY:CGFloat = self.scrollView.contentOffset.y;
            var releaseToRefreshOffsetY = self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom;
            if(currentOffsetY <= releaseToRefreshOffsetY){
                return;
            }
            
            releaseToRefreshOffsetY += XPRefreshTableViewConfig.XPRefreshViewHeight;
            if(self.scrollView.dragging){
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
    
    func adjustFooterView(){
        if let scrollView = self.scrollView{
            var contentSizeHeight:CGFloat = scrollView.contentSize.height;
            var scrollHeight:CGFloat = scrollView.frame.size.height;
            self.frame.origin.y = max(contentSizeHeight, scrollHeight);
        }
    }
    
    override func setRefreshingContentInset(){
        //wait to be override
        self.scrollView.contentInset.bottom += XPRefreshTableViewConfig.XPRefreshViewHeight;
    }
    
    override func resumeContentInset() {
        self.scrollView.contentInset.bottom -= XPRefreshTableViewConfig.XPRefreshViewHeight;
    }
}
