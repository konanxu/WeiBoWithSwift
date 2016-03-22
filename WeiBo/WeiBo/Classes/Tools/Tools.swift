//
//  Tools.swift
//  WeiBo
//
//  Created by Konan on 16/3/14.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class Tools: NSObject {

    static let instance:Tools = Tools()
    
    class func shareTools()-> Tools{
        return instance
    }
    
}
