//
//  HomeRefreshControl.swift
//  WeiBo
//
//  Created by Konan on 16/3/24.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit
import SnapKit

class HomeRefreshControl: UIRefreshControl {

    override init() {
        super.init()
        setUpUI()
    }

    
    private func setUpUI(){
        addSubview(refreshView)
//        refreshView.backgroundColor = UIColor.redColor()
        refreshView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.size.equalTo(CGSizeMake(160, 60))
        }
        addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    private lazy var refreshView = HomeRefreshView.refreshView()
    
    private var rotationArrow:Bool = false
    private var loadingFlag:Bool = false
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        print(frame.origin.y)
        if frame.origin.y >= 0{
            return
        }
        
        if  refreshing && !loadingFlag{
            refreshView.startLoadingAnimation()
            loadingFlag = true
            
            /*
            let dis_t = dispatch_time(DISPATCH_TIME_NOW, (Int64)(2 * NSEC_PER_SEC))
            
            dispatch_after(dis_t, dispatch_get_main_queue()) { () -> Void in
                self.endRefreshing()
            }
            */
            
            
            return
        }
        
        if frame.origin.y >= -50 && rotationArrow
        {
            print("旋转")
            rotationArrow = false
            refreshView.rotationAnimation(rotationArrow)

            
        }else if frame.origin.y < -50 && !rotationArrow{
            
            print("翻转")
            rotationArrow = true
            refreshView.rotationAnimation(rotationArrow)
        }
    }
    override func endRefreshing() {
        super.endRefreshing()
        refreshView.stopLoadingAnimation()
        loadingFlag = false
        
    }
    deinit{
        removeObserver(self, forKeyPath: "frame")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class HomeRefreshView:UIView
{
    
    @IBOutlet weak var loadingIcon: UIImageView!
    
    @IBOutlet weak var tipView: UIView!
    
    @IBOutlet weak var arrowIcon: UIImageView!
    
    class func refreshView() -> HomeRefreshView {
        return NSBundle.mainBundle().loadNibNamed("HomeRefreshView", owner: nil, options: nil).last as! HomeRefreshView
    }
    
    func rotationAnimation(flag:Bool){
        var angle = M_PI
        angle += flag ? -0.01 :0.01
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.arrowIcon.transform = CGAffineTransformRotate(self.arrowIcon.transform, CGFloat(angle))
            }, completion: nil)
    }
    func startLoadingAnimation(){
        tipView.hidden = true
        let anime = CABasicAnimation(keyPath: "transform.rotation")
        anime.duration = 1
        anime.toValue = 2 * M_PI
        anime.removedOnCompletion = false
        anime.repeatCount = MAXFLOAT
        loadingIcon.layer.addAnimation(anime, forKey: nil)
    }
    func stopLoadingAnimation(){
        tipView.hidden = false
        loadingIcon.layer.removeAllAnimations()
    }
}
