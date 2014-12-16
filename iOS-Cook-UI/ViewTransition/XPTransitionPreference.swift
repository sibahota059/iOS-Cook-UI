//
//  XPTransitionPreference.swift
//  iOS-Cook-UI
//
//  Created by XP on 11/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

//define keys for ViewTransition Settings

class XPTransitionPreference:NSObject {
    class func shareInstance()->XPTransitionPreference{
        struct XPSingleton{
            static var predicate:dispatch_once_t = 0
            static var instance:XPTransitionPreference? = nil
        }
        dispatch_once(&XPSingleton.predicate,{
            XPSingleton.instance=XPTransitionPreference()
            }
        )
        return XPSingleton.instance!
    }
    
    var settingsAnimationController:XPReversibleAnimationController?;
    var navigationControllerAnimationController:XPReversibleAnimationController?;
    var navigationControllerInteractionCotroller:XPBaseInteractionController?;
    var settingsInteractionController:XPBaseInteractionController?;
}
