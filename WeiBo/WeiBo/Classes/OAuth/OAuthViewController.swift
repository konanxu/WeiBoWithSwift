//
//  OAuthViewController.swift
//  WeiBo
//
//  Created by Konan on 16/3/15.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {
    
    let WB_APP_KEY = ""
    let WB_APP_SECRET = ""
    let WB_REDIRECT = "http://www.baidu.com"
    let WB_OAuth_ADREESS = "https://api.weibo.com/oauth2/authorize?"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "登录"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "closeClick")
        //1.获取授权requestToken
        let urlStr = "\(WB_OAuth_ADREESS)client_id=\(WB_APP_KEY)&response_type=code&redirect_uri=\(WB_REDIRECT)"
        
//        let srlS = "http://alading.avantouch.com/AladingAppServiceJsonForAndroid/ProductDesc/Alading_story.html"
//        let strZYC = "http://192.168.1.111/Test/Htmltest/manifest/index.html"
        let request = NSURLRequest(URL: NSURL(string: urlStr)!)
        webView.loadRequest(request)
        webView.delegate = self
       
    }
    
    
    func closeClickWithSuccess(){
        dismissViewControllerAnimated(true) { () -> Void in
            HomeTableViewController.load()
        }
    }
    
    func closeClick(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func loadView() {
        view = webView
    }
    private lazy var webView:UIWebView = {
        let wView = UIWebView()
        return wView
    }()

}
extension OAuthViewController:UIWebViewDelegate{
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        print(request.URL?.absoluteString)
        
        //判断是否是授权回调页面
        let urlStr = request.URL!.absoluteString
        if(!urlStr.hasPrefix(WB_REDIRECT)){
            return true
        }
        let codeStr = "code="
        if request.URL!.query!.hasPrefix(codeStr){
            print("授权成功")
            //1.取出已授权requestToken
           let code = request.URL!.query?.substringFromIndex(codeStr.endIndex)
            print(code)
            //2.利用已经授权的RequestToken
            loadAccssToken(code!)
            
            
        }else{
            print("取消授权")
            closeClick()
        }
        
        return false
    }
    private func loadAccssToken(code:String){
        //定义路径
        let path = "oauth2/access_token"
        //封装参数
        let params = ["client_id":WB_APP_KEY, "client_secret":WB_APP_SECRET, "grant_type":"authorization_code", "code":code, "redirect_uri":WB_REDIRECT]
        
        
        NetworkTools.shareNetworkTools().POST(path, parameters: params, success: { (_, JSON) -> Void in
                print(JSON)
            let account = UserAccount(dict: JSON as! [String:AnyObject])
            
            account.saveAccount()
            self.closeClick()
            
            }) { (_, error) -> Void in
                print(error)
        }
    }
}
