//
//  XPRefreshCommonAnimationVIew.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/24/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

class XPRefreshCommonAnimationView: XPRefreshAnimationBaseView {

    let XPRefreshHeaderStatusTextNormal:String = "pull down to refresh";
    let XPRefreshHeaderStatusTextPulling:String = "release to refresh";
    let XPRefreshHeaderStatusTextRefreshing:String = "refreshing......";
    let XPRefreshHeaderStatusTextSuccess:String = "succeed";
    let XPRefreshHeaderStatusTextFailure:String = "failed";
    
    let XPRefreshFooterStatusTextNormal:String = "pull up to refresh";
    let XPRefreshFooterStatusTextPulling:String = "release to refresh";
    let XPRefreshFooterStatusTextRefreshing:String = "refreshing......";
    let XPRefreshFooterStatusTextSuccess:String = "succeed";
    let XPRefreshFooterStatusTextFailure:String = "failed";
    
    var _statusLabel:UILabel;
    var _arrowImageView:UIImageView;
    var _activityView:UIActivityIndicatorView;
    var _lastUpdateTimeLabel:UILabel;
    
    
    convenience init(){
        self.init(frame:CGRectZero);
    }
    
     required init(frame: CGRect) {
        _statusLabel = UILabel();
        _statusLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
        _statusLabel.font = UIFont.boldSystemFontOfSize(13);
        _statusLabel.textColor = UIColor.grayColor();
        _statusLabel.backgroundColor = UIColor.clearColor();
        _statusLabel.textAlignment = NSTextAlignment.Center;
        _statusLabel.text=XPRefreshHeaderStatusTextNormal;
        
        _lastUpdateTimeLabel = UILabel();
        _lastUpdateTimeLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
        _lastUpdateTimeLabel.font=UIFont.boldSystemFontOfSize(13);
        _lastUpdateTimeLabel.textColor = UIColor.lightTextColor();
        _lastUpdateTimeLabel.backgroundColor = UIColor.clearColor();
        _lastUpdateTimeLabel.textAlignment = NSTextAlignment.Center;
        
        _arrowImageView = UIImageView(image: UIImage(named:"arrow"));
        _arrowImageView.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin;
        
        _activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray);
        _activityView.bounds = _arrowImageView.bounds;
        _activityView.autoresizingMask = _arrowImageView.autoresizingMask;
        
        
        super.init(frame:frame);
        self.addSubview(_statusLabel);
        _lastUpdateTimeLabel.text = XPRefreshTableViewConfig.getLastUpdateTimeWithRefreshViewID(self.refreshViewId);
        self.addSubview(_lastUpdateTimeLabel);
        self.addSubview(_arrowImageView);
        self.addSubview(_activityView);
    }
    
    override func willMoveToSuperview(newSuperview: UIView?){
        super.willMoveToSuperview(newSuperview);
        
        if(self.refreshViewType == XPRefreshViewType.Footer){
            _statusLabel.text = XPRefreshFooterStatusTextNormal;
            _arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
            _lastUpdateTimeLabel.hidden = true;
        }
    }
    
    override func layoutSubviews(){
        super.layoutSubviews();

        
        _statusLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height*0.5);
        _lastUpdateTimeLabel.frame = CGRect(x: 0, y: _statusLabel.frame.size.height, width: _statusLabel.frame.size.width, height: _statusLabel.frame.size.height);
        _arrowImageView.center = CGPointMake(self.frame.size.width*0.5 - 100, self.frame.size.height*0.5);
        _activityView.center = _arrowImageView.center;
    
    }

    
    
    
    
    
}
