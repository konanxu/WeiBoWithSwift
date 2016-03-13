//
//  UIBarButtonItem+Category.swift
//  WeiBo
//
//  Created by Konan on 16/3/13.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    class func createBarButton(imageName:String,target:AnyObject?,action:Selector) ->UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
}