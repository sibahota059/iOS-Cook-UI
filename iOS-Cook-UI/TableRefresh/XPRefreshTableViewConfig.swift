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
    class var XPRefreshFastAnimationDuration:Float{
        return 0.2;
    }
    class var XPRefreshSlowAnimationDuration:Float{
        return 0.4;
    }
    class var XPRefreshShowResultAnimationDuration:Float{
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
        return "1";
    }
   
}
