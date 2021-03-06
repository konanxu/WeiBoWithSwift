//
//  BaseTableViewController.swift
//  WeiBo
//
//  Created by Konan on 16/3/9.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    var userLogin = UserAccount.loadAccount() != nil ? true :false

    
    var vistorView: VistorView?
    override func loadView() {
        userLogin ? super.loadView() : setupVistorView()
        
    }
    private func setupVistorView(){
        let customview = VistorView()
        customview.backgroundColor = UIColor.whiteColor()
        view = customview
        view.backgroundColor = UIColor(colorLiteralRed: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1)
        vistorView = customview
        vistorView?.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "vistorViewRegisterClick")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "vistorViewLoginClick")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
         
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

      /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BaseTableViewController:vistorViewDelegate{
    func vistorViewRegisterClick() {
        print("hello")
       let account = UserAccount.loadAccount()
        print(account)
    }
    func vistorViewLoginClick() {
        print("fuck")
        let vc = UINavigationController(rootViewController: OAuthViewController())
        presentViewController(vc, animated: true, completion: nil)
    }
}

