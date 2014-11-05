//
//  XPRefreshTableViewConfig.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/24/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

enum XPRefreshViewType{
    case Header
    case Footer
}

enum XPRefreshState{
    case Pulling
    case Normal
    case Refreshing
}

enum XPRefreshResult{
    case None
    case Success
    case Failure
}


class XPRefreshTableViewConfig: NSObject {
    class var XPRefreshViewHeight:CGFloat{
        return 60.0;
    }
    class var XPRefreshFastAnimationDuration:Double{
        return 0.2;
    }
    class var XPRefreshSlowAnimationDuration:Double{
        return 0.4;
    }
    class var XPRefreshShowResultAnimationDuration:Double{
        return 0.8;
    }
    class var XPRefreshContentOffset:String{
        return "contentOffset"
    }
    class var XPRefreshContentSize:String{
        return "contentSize"
    }
    class var XPRefreshConfigKey:String{
        return "XPRefreshConfig"
    }
    class var XPRefreshLastUpdateTimeKey:String{
        return "XPRefreshLastUpdateTime";
    }
    class var XPRefreshLastUpdateTimeFormat:String{
        return "yyyy-MM-dd HH:mm";
    }

    
    class func getLastUpdateTimeWithRefreshViewID(id:Int!)->String{
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults();
        var refreshDic:NSDictionary? = userDefaults.objectForKey(self.XPRefreshConfigKey) as? NSDictionary;
        if let dic = refreshDic{
            var timeDic:NSDictionary? = dic.objectForKey(self.XPRefreshLastUpdateTimeKey) as? NSDictionary;
            if let lasttimeDic = timeDic{
                var key:String = NSString.localizedStringWithFormat("%@_%d", self.XPRefreshLastUpdateTimeKey, id);
                var time:NSString? = lasttimeDic.objectForKey(key) as? String;
                if let updateTime = time{
                    return updateTime;
                }
            }
        }
        return self.nowtimeString();
    }
    
    class func nowtimeString()->String{
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = self.XPRefreshLastUpdateTimeFormat;
        var time:String = dateFormatter.stringFromDate(NSDate());
        return NSString.localizedStringWithFormat("last updated:%@", time);
    }
    
    class func updateLastUpdateTimeWithRefreshViewId(id:Int!){
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults();
        var refreshDic:NSMutableDictionary? = userDefaults.objectForKey(self.XPRefreshConfigKey) as? NSMutableDictionary
        refreshDic = refreshDic?.mutableCopy() as? NSMutableDictionary;
        if (refreshDic == nil){
            refreshDic = NSMutableDictionary();
        }
        var timeDic:NSMutableDictionary? = refreshDic!.objectForKey(self.XPRefreshLastUpdateTimeKey) as? NSMutableDictionary;
        timeDic = timeDic?.mutableCopy() as? NSMutableDictionary;
        if(timeDic == nil){
            timeDic = NSMutableDictionary();
        }
        var key:String = NSString.localizedStringWithFormat("%@_%d", self.XPRefreshLastUpdateTimeKey, id);
        timeDic?.setObject(self.nowtimeString(), forKey: key);

        refreshDic?.setObject(timeDic!, forKey: XPRefreshLastUpdateTimeKey);
        userDefaults.setObject(refreshDic, forKey: self.XPRefreshConfigKey);
        userDefaults.synchronize();
    }
   
}
