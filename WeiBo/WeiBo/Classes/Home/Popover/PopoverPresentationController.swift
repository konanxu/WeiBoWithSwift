//
//  PopoverPresentationController.swift
//  WeiBo
//
//  Created by Konan on 16/3/13.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {

    var popFrame = CGRectZero
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    override func containerViewWillLayoutSubviews() {
        let pv    = presentedView()
        if(popFrame == CGRectZero){
            pv?.frame = CGRect(x: 60, y: 56, width: 200, height: 300)
        }else{
            pv?.frame = popFrame
        }
        containerView?.insertSubview(coverView, atIndex: 0)
    }
    
    private lazy var coverView:UIView = {
       let view = UIView()
        view.frame = UIScreen.mainScreen().bounds
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
        let ges = UITapGestureRecognizer(target: self, action: "popViewDismiss")
        view.addGestureRecognizer(ges)
        
        return view
    }()
    
    func popViewDismiss(){
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
