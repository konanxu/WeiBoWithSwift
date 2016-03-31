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
    var pullupRefreshFlag = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !userLogin{
           vistorView!.setUpInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
           return
        }
        tableView.delegate = self
        setupNav()
        if userLogin{
            loadData()
        }
        
            refreshControl = HomeRefreshControl()
            refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        //注册二个cell
        tableView.registerClass(StatusNormalTableViewCell.self, forCellReuseIdentifier: StatusTableViewCellIdentifier.NormalCell.rawValue)
        
        tableView.registerClass(StatusForwardTableViewCell.self, forCellReuseIdentifier: StatusTableViewCellIdentifier.ForwardCell.rawValue)
        
        /*  iOS 8 结合autolayout自动高度
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        */
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    
    @objc private func loadData(){
        var since_id = statuses?.first?.id ?? 0
        var max_id = 0
        if pullupRefreshFlag {
            since_id = 0
            max_id = statuses?.last?.id ?? 0
        }
        
        Status.loadStatus(since_id,max_id: max_id) { (models, error) -> () in
            
            self.refreshControl?.endRefreshing()
            if error != nil{
                return
            }
            if  since_id > 0{
                self.statuses = models! + self.statuses!
            }else if(max_id > 0){
                self.statuses = self.statuses! + models!
                self.pullupRefreshFlag = false
            }
            else{
                self.statuses = models
            }
            
            
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
//        let cell = tableView.dequeueReusableCellWithIdentifier(kTableViewCellIndentifier, forIndexPath: indexPath) as! StatusTableViewCell
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StatusTableViewCellIdentifier.cellID(statuses![indexPath.row]), forIndexPath: indexPath) as! StatusTableViewCell
        
        let status = statuses![indexPath.row]
        cell.status = status
//        cell.textLabel?.text = statuses![indexPath.row].text
//        cell.detailTextLabel?.text = statuses![indexPath.row].user?.name
        
        //判断是否到了最后一个cell
        let count = statuses?.count ?? 0
        if indexPath.row == (count - 1){
            pullupRefreshFlag = true
            loadData()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let status = statuses![indexPath.row]
        if let height = rowCache[status.id]
        {
            print("从缓存中获取")
            return height
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StatusTableViewCellIdentifier.cellID(statuses![indexPath.row])) as! StatusTableViewCell
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


