//
//  XPWalkThroughContainerViewController.swift
//  iOS-Cook-UI
//
//  Created by XP on 10/10/14.
//  Copyright (c) 2014 newland. All rights reserved.
//

import UIKit

@objc protocol XPWalkThroughContainerViewControllerDelegate{
    @objc func walkthroughCloseBtnClicked();
    @objc func walkthroughPageDidChange(pageNumber:Int);
}

@objc protocol XPWalkthroughPageDelegate{
    @objc func walkthroughDidScroll(position:CGFloat, offset:CGFloat)   // Called when the main Scrollview...scroll
}


class XPWalkThroughContainerViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    var delegate:XPWalkThroughContainerViewControllerDelegate?;
    
    private let scrollView:UIScrollView!;
    private var controllers:[UIViewController]!;
    private var lastViewConstraint:NSArray?;
    
    var currentPage:Int{
        get{
            let page = Int((scrollView.contentOffset.x/view.bounds.size.width));
            return page;
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        scrollView = UIScrollView();
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.pagingEnabled = true;
        
        controllers = Array();
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.delegate = self;
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false);
        view.insertSubview(scrollView, atIndex: 0);
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[scrollview]-0-|", options:nil, metrics: nil, views: ["scrollview":scrollView]));
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[scrollview]-0-|", options:nil, metrics: nil, views: ["scrollview":scrollView]))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        pageControl?.numberOfPages = controllers.count;
        pageControl?.currentPage = 0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBtnClicked(sender: AnyObject) {
        delegate?.walkthroughCloseBtnClicked();
    }
    
    func addViewController(vc:UIViewController){
        controllers.append(vc);
        
        vc.view.setTranslatesAutoresizingMaskIntoConstraints(false);
        scrollView.addSubview(vc.view);
        
        let metricDict = ["w":vc.view.bounds.size.width,"h":vc.view.bounds.size.height];
        
        vc.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(" |-50-[purpleBox]-50-|", options:nil, metrics: metricDict, views: ["view":vc.view]));
        vc.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[view(w)]", options:nil, metrics: metricDict, views: ["view":vc.view]));
        scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]|", options:nil, metrics: nil, views: ["view":vc.view]));
        
        if(controllers.count == 1){
            scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]", options: nil, metrics: nil, views: ["view":vc.view]));
        }else{
            let previousVC = controllers[controllers.count - 2];
            let previousView = previousVC.view;
            scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[previousView]-0-[view]", options:nil, metrics: nil, views: ["previousView":previousView,"view":vc.view]))
            
            if let cst = lastViewConstraint{
                scrollView.removeConstraints(cst);
            }
            lastViewConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:[view]-|", options:nil, metrics: nil, views: ["view":vc.view])
            scrollView.addConstraints(lastViewConstraint!);
        }
    }
    
    func updateUI(){
        pageControl?.currentPage = currentPage;
        delegate?.walkthroughPageDidChange(currentPage);
    }
    
    // MARK: - scrollview delegate -
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for var i = 0; i < controllers.count; i++ {
            if let vc = controllers[i] as? XPWalkthroughPageDelegate {
                // While sliding to the "next" slide (from right to left), the "current" slide changes its offset from 1.0 to 2.0 while the "next" slide changes it from 0.0 to 1.0
                // While sliding to the "previous" slide (left to right), the current slide changes its offset from 1.0 to 0.0 while the "previous" slide changes it from 2.0 to 1.0
                // The other pages update their offsets whith values like 2.0, 3.0, -2.0... depending on their positions and on the status of the walkthrough
                // This value can be used on the previous, current and next page to perform custom animations on page's subviews.
                let mx = ((scrollView.contentOffset.x + view.bounds.size.width)-(view.bounds.size.width * CGFloat(i)))/view.bounds.size.width;
                if(mx<2 && mx > -2){
                    vc.walkthroughDidScroll(scrollView.contentOffset.x, offset:mx);
                }
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updateUI()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        updateUI()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
