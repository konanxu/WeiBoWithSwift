//
//  MainViewController.swift
//  WeiBo
//
//  Created by Konan on 16/3/8.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.orangeColor()
        
        addViewController("HomeTableViewController", title: "首页", imageNmae: "tabbar_home")
        addViewController("MessageTableViewController", title: "消息", imageNmae: "tabbar_message_center")
        addViewController("DiscoverTableViewController", title: "广场", imageNmae: "tabbar_discover")
        addViewController("ProfileTableViewController", title: "我", imageNmae: "tabbar_profile")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /**
     初始化控制器
     
     - parameter childViewController: 需要初始化的控制器
     - parameter title:               控制器title
     - parameter imageNmae:           图片名
     */
    private func addViewController(childViewControllerName:String,title:String,imageNmae:String){
        
        
        //动态获取命名空间
        
        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        print(nameSpace)
        let cls:AnyClass? = NSClassFromString(nameSpace + "." + childViewControllerName)
        print(cls)
        
        //将anyClass转为指定的UIViewController类型
        let vcCls = cls as! UIViewController.Type
        
        //通过类创建对象
        let vc = vcCls.init()
        
        
        vc.tabBarItem.image = UIImage(named: imageNmae)
        vc.tabBarItem.selectedImage = UIImage(named: imageNmae + "_highlighted")
        vc.title = title
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        addChildViewController(nav)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
