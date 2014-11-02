//
//  XPRefreshHeaderView.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPRefreshHeaderView: XPRefreshBaseView {
    required convenience init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(){
        self.init(frame:CGRectZero);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview);
        self.frame.origin.y = -XPRefreshTableViewConfig.XPRefreshViewHeight;
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if(self.state == XPRefreshState.Refreshing){
            return;
        }
        
        if(keyPath == XPRefreshTableViewConfig.XPRefreshContentOffset){
            self.changeStateWithContentOffset();
        }
    }
    
    func changeStateWithContentOffset(){
        if let scroll = self.scrollView{
            var currentOffsetY:CGFloat = scroll.contentOffset.y;
            var releaseToRefreshOffsetY = -scroll.contentInset.top;
            
            if(currentOffsetY > releaseToRefreshOffsetY){
                return;
            }
            releaseToRefreshOffsetY -= self.frame.size.height;
            
            if(scroll.dragging){
                if(self.state == XPRefreshState.Normal && currentOffsetY < releaseToRefreshOffsetY){
                    self.state = XPRefreshState.Pulling;
                }else if(self.state == XPRefreshState.Pulling && currentOffsetY >= releaseToRefreshOffsetY){
                    self.state = XPRefreshState.Normal;
                }
            }else if(self.state == XPRefreshState.Pulling){
                self.state = XPRefreshState.Refreshing;
            }
        }
    }
    
}
