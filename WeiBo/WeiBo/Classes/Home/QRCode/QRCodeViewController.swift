//
//  QRCodeViewController.swift
//  WeiBo
//
//  Created by Konan on 16/3/13.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    ///顶部约束
    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    /// 高度约束
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!


    @IBOutlet weak var scanLine: UIImageView!
    
    
    @IBOutlet weak var customTabBar: UITabBar!


    
    @IBAction func closeBtnItemClick(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func albumClick(sender: AnyObject) {
        
        let sb = UIStoryboard(name: "SegueTestViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        presentViewController(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func myCardClick(sender: AnyObject) {
        let vc = QRCodeCardViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTabBar.selectedItem = customTabBar.items![0]
        customTabBar.delegate = self
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //开始动画
        startAnimation()
        
        //开始扫描
        startScan()
    }
    private func startScan(){
        //1.判断是否能够将输入添加到会话中
        //2.判断是否能够将输出添加到会话中
        if (!session.canAddInput(deviceInput)){
            return
        }
        if (!session.canAddOutput(output)){
            return
        }
        //3.将输入和输出添加到会话中
        session.addInput(deviceInput)
        session.addOutput(output)
        //4.设置输出能够解析的数据类型
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        //5.这只输出对象代理，解析成功就会通知代理
        
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        output.rectOfInterest = CGRectMake(0.0, 0.0, 1, 1)
        
        view.layer.insertSublayer(preViewLayer, atIndex: 0)
        
        preViewLayer.addSublayer(drawLayer)
        
        //6.告诉session开始扫描
        session.startRunning()
    }
    
    private func startAnimation(){
        self.scanLineCons.constant = -self.containerHeightCons.constant
        self.scanLine.layoutIfNeeded()
        UIView.animateWithDuration(2, animations: { () -> Void in
            self.scanLineCons.constant = self.containerHeightCons.constant
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLine.layoutIfNeeded()
            }, completion: nil)
    }
    
    private lazy var session:AVCaptureSession = AVCaptureSession()
    private lazy var deviceInput :AVCaptureDeviceInput? = {
        //获取摄像头
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do{
            //创建输入对象
            let input = try AVCaptureDeviceInput(device: device)
            return input
        }catch{
            print(error)
            return nil
        }
        
    }()
//    拿到输出对象
    private lazy var output:AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
// MARK: - 创建预览图层
    private lazy var preViewLayer:AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
    
// MARK: - 绘制边线图层
    private lazy var drawLayer:CALayer = {
        let layer   = CALayer()
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
}
extension QRCodeViewController:UITabBarDelegate{
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if(item == customTabBar.items![0]){
            print("二维码")
            self.containerHeightCons.constant = 300
        }else{
            print("条形码")
            self.containerHeightCons.constant = 150
        }
        
            scanLine.layer.removeAllAnimations()
            startAnimation()
    }
}
extension QRCodeViewController:AVCaptureMetadataOutputObjectsDelegate{
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        //获取扫描数据
        print(metadataObjects)
        if(metadataObjects.last == nil){
            clearCorners()
        }
        resultLabel.text = metadataObjects.last?.stringValue
        resultLabel.sizeToFit()
        //获取扫描位置,转换坐标
        print(metadataObjects.last)
        for object in metadataObjects{
            if object is AVMetadataMachineReadableCodeObject{
                let codeobject = preViewLayer.transformedMetadataObjectForMetadataObject(object as!AVMetadataObject) as! AVMetadataMachineReadableCodeObject
                //绘制图形
                drawCorners(codeobject)
            }
        }
    }
    private func drawCorners(codeObject:AVMetadataMachineReadableCodeObject)
    {
        if(codeObject.corners.isEmpty){
            clearCorners()
            return
        }
        clearCorners()
        let layer = CAShapeLayer()
        layer.lineWidth = 4
        layer.strokeColor = UIColor.redColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        //创建路径
//        layer.path = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 200, height: 200)).CGPath
        
        let path = UIBezierPath()
        var point = CGPointZero
        var index :Int = 0
        CGPointMakeWithDictionaryRepresentation((codeObject.corners[index++]
            as! CFDictionaryRef), &point)
        path.moveToPoint(point)
        while index < codeObject.corners.count{
            CGPointMakeWithDictionaryRepresentation((codeObject.corners[index++]
                as! CFDictionaryRef), &point)
            path.addLineToPoint(point)
        }
        //关闭路径
        path.closePath()
        layer.path = path.CGPath
        drawLayer.addSublayer(layer)
        
        /*
        let time : NSTimeInterval = 1.5
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
            self.clearCorners()
        }
        */
    }
    //清空边线
    private func clearCorners(){
        if((drawLayer.sublayers == nil) || drawLayer.sublayers?.count == 0){
            return
        }
        for subLayer in drawLayer.sublayers!{
            subLayer.removeFromSuperlayer()
        }
    }
}