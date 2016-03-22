//
//  UIView+Category.swift
//  WeiBo
//
//  Created by Konan on 16/3/21.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

extension UIView{

    func getConstraintWidth() ->NSLayoutConstraint?{
        let arr = self.constraints
        for cons in arr{
            if(cons.firstAttribute == NSLayoutAttribute.Width){
                return cons
            }
        }
        return nil
    }

    func getConstraintHeight() ->NSLayoutConstraint?{
        let arr = self.constraints
        for cons in arr{
            if(cons.firstAttribute == NSLayoutAttribute.Height){
                return cons
            }
        }
        return nil
    }
}