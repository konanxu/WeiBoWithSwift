//
//  SegueTestViewController.swift
//  WeiBo
//
//  Created by Konan on 16/3/14.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class SegueTestViewController: UIViewController,SegueHandlerType{
    enum SegueIdentifier:String{
        case TheRedPillExperience
        case TheBluePillExperience
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segueIdentifierForSegue(segue){
        case .TheRedPillExperience:
                print("123")
        case .TheBluePillExperience:
                print("456")
        }
    }
    @IBAction func onRedClick(sender: AnyObject) {
        performSegueWithIdentifier(.TheRedPillExperience, sender: self)
    }
    @IBAction func onBlueClick(sender: AnyObject) {
        performSegueWithIdentifier(.TheBluePillExperience, sender: self)
    }
//    func onRedPillButtonTap(sender:AnyObject){
//        
//    }
}
