//
//  XPRefreshAnimationBaseView.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPRefreshAnimationBaseView: UIView, XPRefreshViewProtocol {
    var refreshViewType:XPRefreshViewType!;
    var refreshViewId:Int;
    
    required convenience init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override convenience init(){
        self.init(frame:CGRect(x:0,y:0,width:0,height:0));
    }
    
    override required init(frame: CGRect) {
        refreshViewId = 0;
        super.init(frame: frame);
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview);
        var newFrame:CGRect = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newSuperview!.frame.size.width, height: newSuperview!.frame.size.height);
        self.frame = newFrame;
        if let headerView = newSuperview as? XPRefreshHeaderView {
            self.refreshViewType = XPRefreshViewType.Header;
        }else if let footerView = newSuperview as? XPRefreshFooterView{
            self.refreshViewType = XPRefreshViewType.Footer;
        }
        self.refreshViewId = (newSuperview as XPRefreshBaseView).id;
    }
    
    //MARK: XPWalkthroughPageDelegate
    //下拉时候的动画
    func refreshViewAniToBePulling(){}
    
    //普通状态时的动画
    func refreshViewAniToBeNormal(){}
    
    //开始刷新
    func refreshViewBeginRefreshing(){}
    
    //结束刷新
    func refreshViewEndRefreshing(result:XPRefreshResult){}

    
}
