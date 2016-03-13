//
//  PopoverAnimation.swift
//  WeiBo
//
//  Created by Konan on 16/3/13.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class PopoverAnimation: NSObject,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning{
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        
        let vc = PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting)
        vc.popFrame = popFrame
        return vc
    }
    dynamic var isPresent  = false
    var popFrame = CGRectZero
    /**
     告诉系统谁来负责modal的展现动画
     
     - parameter presented:  被展现视图
     - parameter presenting: 发起的视图
     - parameter source:     <#source description#>
     
     - returns: 谁来负责
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = false
        return self
    }
    
    func  transitionDuration(transitionContext: UIViewControllerContextTransitioning?) ->NSTimeInterval{
        return 0.5
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        //拿到vc
        if(isPresent){
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            transitionContext.containerView()?.addSubview(toView!)
            
            //设置锚点
            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            toView?.transform = CGAffineTransformMakeScale(1.0, 0.0)
            //执行动画
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                toView?.transform = CGAffineTransformIdentity
                }) { (_) -> Void in
                    transitionContext.completeTransition(true)
            }
        }else{
            let formView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                formView?.transform = CGAffineTransformMakeScale(1.0, 0.000001)
                }, completion: { (_) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
    }
}