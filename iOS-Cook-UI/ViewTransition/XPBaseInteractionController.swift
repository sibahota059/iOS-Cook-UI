//
//  XPBaseInteractionController.swift
//  iOS-Cook-UI
//
//  Created by XP on 11/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

enum XPInteractionOperation{
    case Pop
    case Dismiss
    case Tab
}

class XPBaseInteractionController: NSObject {
    
    func wireToViewController(viewController:UIViewController, forOperation:XPInteractionOperation){
        //this has to be override;
    }
}
