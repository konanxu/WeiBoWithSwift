//
//  ComposeViewController.swift
//  WeiBo
//
//  Created by Konan on 16/3/30.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class ComposeViewController: UIViewController {
    
    var isSend :Bool = false{
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Plain, target: self, action: "send")
        navigationItem.rightBarButtonItem?.enabled = false
        
        setupInput()
    }
    private func setupInput(){
        view.addSubview(textView)
        
        textView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(textView.superview!)
            make.center.equalTo(textView.superview!)
        }
        textView.myDelegate = self
        textView.font = UIFont.systemFontOfSize(16)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }
    
    func close (){
        dismissViewControllerAnimated(true, completion: nil)
        print(__FUNCTION__)
    }
    func send (){
        print(__FUNCTION__)
        sendStatus()
    }
    private lazy var textView:PlaceholderTextView = {
        let view = PlaceholderTextView()
        return view
    }()
    private lazy var placeholder:UILabel = {
        let lab = UILabel()
        lab.text = "分享新鲜事..."
        lab.font = UIFont.systemFontOfSize(13)
        lab.textColor = UIColor.darkGrayColor()
        return lab
    }()
    deinit{
        textView.removeObserver(self, forKeyPath: "isShow")
    }
    
    //MARK: - 发送微博 -
    func sendStatus(){
        let path  = "2/statuses/update.json"
        let params = ["access_token":UserAccount.loadAccount()?.access_token!,"status":textView.text]
        NetworkTools.shareNetworkTools().POST(path, parameters: params, success: { (_, JSON) -> Void in
            SVProgressHUD.showSuccessWithStatus("发送成功", maskType: SVProgressHUDMaskType.Black)
            self.close()
            }) { (_, error) -> Void in
                SVProgressHUD.showErrorWithStatus("发送失败", maskType: SVProgressHUDMaskType.Black)
        }
    }
    
}
extension ComposeViewController:PlaceholderTextViewDelegate{
    func isShow(ishow: Bool) {
        navigationItem.rightBarButtonItem?.enabled = ishow
    }
}
