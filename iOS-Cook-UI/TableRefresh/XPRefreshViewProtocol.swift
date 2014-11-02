//
//  XPRefreshViewDelegate.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/25/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

protocol XPRefreshViewProtocol {
    
    //下拉时候的动画
    func refreshViewAniToBePulling();
    
    //普通状态时的动画
    func refreshViewAniToBeNormal();
    
    //开始刷新
    func refreshViewBeginRefreshing();
    
    //结束刷新
    func refreshViewEndRefreshing(result:XPRefreshResult);
    
    //拖拽到对应的位置
    func refreshViewPullingToPosition(position:CGFloat);
       
}
