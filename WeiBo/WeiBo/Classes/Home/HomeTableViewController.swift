//
//  HomeTableViewController.swift
//  WeiBo
//
//  Created by Konan on 16/3/8.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

let kTableViewCellIndentifier = "kTableViewCellIndentifier"
class HomeTableViewController: BaseTableViewController {
    
    var statuses:[Status]?
    {
        didSet{
            tableView.reloadData()
        }
    }
    
    
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
        tableView.delegate = self
        setupNav()
        if userLogin{
            loadData()
        }
        tableView.registerClass(StatusTableViewCell.self, forCellReuseIdentifier: kTableViewCellIndentifier)
//        tableView.estimatedRowHeight = 200
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    private func loadData(){
        Status.loadStatus { (models, error) -> () in
            if error != nil{
                return
            }
            self.statuses = models
        }
        
    }
    
    
    
    let titleBtn = TitleButton()
    private func setupNav(){
        
        //初始化左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButton("navigationbar_friendattention", target: self, action: "friendClick")
        
       navigationItem.rightBarButtonItem =  UIBarButtonItem.createBarButton("navigationbar_pop", target: self, action: "qCodeClick")
        
        
        let spaRight   = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spaRight.width = -10
        navigationItem.setRightBarButtonItems([spaRight,navigationItem.rightBarButtonItem!], animated: true)
        let spaLeft    = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spaLeft.width  = -5
        navigationItem.setLeftBarButtonItems([spaLeft,navigationItem.leftBarButtonItem!], animated: true)
        
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
        
        let sb = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        presentViewController(vc!, animated: true, completion: nil)
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
        rowCache.removeAll()
    }

        private lazy var popoverAnimation:PopoverAnimation  = {
        let pop = PopoverAnimation()
        pop.popFrame = CGRect(x: 80, y: 56, width: 150, height: 300)
        return pop
    }()
    
    
    var rowCache: [Int: CGFloat] = [Int: CGFloat]()
    
}
extension HomeTableViewController{
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kTableViewCellIndentifier, forIndexPath: indexPath) as! StatusTableViewCell
        cell.status = statuses![indexPath.row]
//        cell.textLabel?.text = statuses![indexPath.row].text
//        cell.detailTextLabel?.text = statuses![indexPath.row].user?.name
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let status = statuses![indexPath.row]
        if let height = rowCache[status.id]
        {
            print("从缓存中获取")
            return height
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kTableViewCellIndentifier) as! StatusTableViewCell
        let height = cell.rowHeight(status)
        
        rowCache[status.id] = height
        print("新的计算")
        return height
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return statuses?.count ?? 0
    }

}


