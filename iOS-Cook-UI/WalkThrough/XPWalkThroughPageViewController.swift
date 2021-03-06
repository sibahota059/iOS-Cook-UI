//
//  XPWalkThroughPageViewController.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/10/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

enum WalkthroughAnimationType{
    case Linear
    case Curve
    case Zoom
    case InOut
    
    static func fromString(str:String)->WalkthroughAnimationType{
        switch(str){
            case "Linear":
                return .Linear;
            case "Curve":
                return .Curve;
            case "Zoom":
                return .Zoom;
            case "InOut":
                return .InOut;
        default:
            return .Linear;
        }
    }
}

class XPWalkThroughPageViewController: UIViewController, XPWalkthroughPageDelegate {
    
    @IBInspectable var speed:CGPoint = CGPoint(x:0.0, y:0.0);
    @IBInspectable var speedVariance:CGPoint = CGPoint(x:0.0, y:0.0);
    @IBInspectable var animationType:String = "Linear";
    @IBInspectable var animateAlpha:Bool = false;
    
    private var subsWeights:[CGPoint] = Array();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.layer.masksToBounds = true;
        subsWeights = Array();
        for v in view.subviews{
            speed.x += speedVariance.x;
            speed.y += speedVariance.y;
            subsWeights.append(speed);
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: XPWalkthroughPageDelegate 
    func walkthroughDidScroll(position: CGFloat, offset: CGFloat) {
        for(var i = 0; i < subsWeights.count; i++){
            switch WalkthroughAnimationType.fromString(animationType){
            case WalkthroughAnimationType.Linear:
                animationLinear(i, offset);
            case WalkthroughAnimationType.Zoom:
                animationZoom(i, offset);
            case WalkthroughAnimationType.Curve:
                animationCurve(i, offset);
            case WalkthroughAnimationType.InOut:
                animationInOut(i, offset);
            }
            
            if(animateAlpha){
                animationAlpha(i, offset);
            }
        }
        
    }
    
    private func animationAlpha(index:Int, var _ offset:CGFloat){
        let cView = view.subviews[index] as UIView;
        if(offset > 1.0){
            offset = 1.0 + (1.0 - offset);
        }
        cView.alpha = offset;
    }
    
    private func animationCurve(index:Int, var _ offset:CGFloat){
        var transform = CATransform3DIdentity;
        var x:CGFloat = (1.0 - offset) * 10;
        transform = CATransform3DTranslate(transform, (pow(x,3) - (x * 25)) * subsWeights[index].x, (pow(x,3) - (x * 20)) * subsWeights[index].y, 0);
        view.subviews[index].layer.transform = transform;
    }
    
    private func animationZoom(index:Int, _ offset:CGFloat){
        var transform = CATransform3DIdentity
        
        var tmpOffset = offset
        if(tmpOffset > 1.0){
            tmpOffset = 1.0 + (1.0 - tmpOffset)
        }
        var scale:CGFloat = (1.0 - tmpOffset)
        transform = CATransform3DScale(transform, 1 - scale , 1 - scale, 1.0)
        view.subviews[index].layer.transform = transform
    }
    
    private func animationLinear(index:Int, _ offset:CGFloat){
        var transform = CATransform3DIdentity
        var mx:CGFloat = (1.0 - offset) * 100
        transform = CATransform3DTranslate(transform, mx * subsWeights[index].x, mx * subsWeights[index].y, 0 )
        view.subviews[index].layer.transform = transform
    }
    
    private func animationInOut(index:Int, _ offset:CGFloat){
        var transform = CATransform3DIdentity
        var x:CGFloat = (1.0 - offset) * 20
        
        var tmpOffset = offset
        if(tmpOffset > 1.0){
            tmpOffset = 1.0 + (1.0 - tmpOffset)
        }
        transform = CATransform3DTranslate(transform, (1.0 - tmpOffset) * subsWeights[index].x * 100, (1.0 - tmpOffset) * subsWeights[index].y * 100, 0)
        view.subviews[index].layer.transform = transform
        
    }}
