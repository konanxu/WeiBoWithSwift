//
//  HomeTableViewController.swift
//  WeiBo
//
//  Created by Konan on 16/3/8.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if !userLogin{
           vistorView!.setUpInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
           return
        }
        setupNav()
    }
    
    let titleBtn = TitleButton()
    private func setupNav(){
        
        //初始化左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButton("navigationbar_friendattention", target: self, action: "friendClick")
        
       navigationItem.rightBarButtonItem =  UIBarButtonItem.createBarButton("navigationbar_pop", target: self, action: "qCodeClick")
        
        //初始化标题按钮
        
        titleBtn.setTitle("Konan_Xu ", forState: UIControlState.Normal)
        titleBtn.addTarget(self, action: "titleClick:", forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = titleBtn
        
       popoverAnimation.addObserver(self, forKeyPath: "isPresent", options: NSKeyValueObservingOptions.New, context: nil)
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if(keyPath == "isPresent"){
            titleBtn.selected = !titleBtn.selected
        }
    }
    
    func titleClick(btn:TitleButton){
        print(__FUNCTION__)
        
        
        //弹出菜单,取出vc 设置转场自定义
        let sb = UIStoryboard(name: "PopoverViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        vc?.transitioningDelegate = popoverAnimation
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom
        presentViewController(vc!, animated: true, completion: nil)
    }
    
    func friendClick(){
        print(__FUNCTION__)
    }
    func qCodeClick(){
        print(__FUNCTION__)
    }
    
    deinit{
        super.viewDidLoad()
        popoverAnimation.removeObserver(self, forKeyPath: "isPresent")
    }
    
    override func viewWillAppear(animated: Bool) {
        if !userLogin{
         vistorView!.centerViewUpdateConstraints()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    private lazy var popoverAnimation:PopoverAnimation  = {
        let pop = PopoverAnimation()
        pop.popFrame = CGRect(x: 80, y: 56, width: 150, height: 300)
        return pop
    }()
}


