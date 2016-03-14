//
//  SegueHandlerType.swift
//  WeiBo
//
//  Created by Konan on 16/3/14.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit
import Foundation

protocol SegueHandlerType {
    typealias SegueIdentifier :RawRepresentable
}
extension SegueHandlerType where Self : UIViewController,
SegueIdentifier.RawValue == String{
    func performSegueWithIdentifier(segueIdentifier:SegueIdentifier,sender:AnyObject?){
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }
    func segueIdentifierForSegue(segue:UIStoryboardSegue) ->SegueIdentifier{
        guard let identifier = segue.identifier,
            segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                fatalError("Invalid segue identifier \(segue.identifier)")
                
        }
        return segueIdentifier
    }
    
}