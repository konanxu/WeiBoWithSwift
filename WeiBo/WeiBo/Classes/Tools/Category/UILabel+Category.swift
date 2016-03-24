//
//  UILabel+Category.swift
//  WeiBo
//
//  Created by Konan on 16/3/24.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

extension UILabel{
    class func createLabel(color:UIColor,fontSize:CGFloat) ->UILabel{
        let label = UILabel()
        label.textColor = color
        label.font = UIFont.systemFontOfSize(fontSize)
        return label
    }
}