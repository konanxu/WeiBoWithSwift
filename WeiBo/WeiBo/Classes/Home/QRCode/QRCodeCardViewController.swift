//
//  QRCodeCardViewController.swift
//  WeiBo
//
//  Created by Konan on 16/3/14.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit
import SnapKit

class QRCodeCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
       
    }

    private func setupView(){
        view.backgroundColor = UIColor.grayColor()
        navigationItem.title = "我的名片"
        view.addSubview(iconView)
        iconView.backgroundColor = UIColor.redColor()
        iconView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(iconView.superview!)
            make.width.height.equalTo(250)
        }
        
        let qrCodeImg = createQRCodeImage()
        iconView.image = qrCodeImg
        
        
    }
    
    private func createQRCodeImage()->UIImage{
        
        //1.创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        //2.还原滤镜默认属性
        filter?.setDefaults()
        //3.设置需要生成二维码数据
        filter?.setValue("konanxu".dataUsingEncoding(NSUTF8StringEncoding), forKey: "inputMessage")
        
        let ciImage = filter?.outputImage
        
        let bgImage = createNonInterpolatedUIImageFormCIImage(ciImage!, size: 300)
        let icon = UIImage(named: "xiuyi.jpg")
        let newImage = createImage(bgImage,iconImage:icon!)
        
        return newImage!
    }
    
    private func createImage(bgImage:UIImage,iconImage:UIImage)->UIImage?{
        //1.开启上下文
        
        UIGraphicsBeginImageContext(bgImage.size)
        //2.绘制背景图片
        bgImage.drawInRect(CGRect(origin: CGPointZero, size: bgImage.size))
        //3.绘制头像
        let width = CGFloat(50)
        let height = width
        let x = (bgImage.size.width - width) * 0.5
        let y = (bgImage.size.height - height) * 0.5
        iconImage.drawInRect(CGRect(x: x, y: y, width: width, height: height))
        //4.取出绘制图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //5.关闭上下文
        UIGraphicsEndImageContext()
        //6.返回合成图片
        return newImage
    }
    
    private lazy var iconView:UIImageView = UIImageView()

    
    /**
     生成高清二维码
     
     - parameter image: 需要生成原始图片
     - parameter size:  生成的二维码的宽高
     */
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = CGRectIntegral(image.extent)
        let scale: CGFloat = min(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent))
        
        // 1.创建bitmap;
        let width = CGRectGetWidth(extent) * scale
        let height = CGRectGetHeight(extent) * scale
        let cs: CGColorSpaceRef = CGColorSpaceCreateDeviceGray()!
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImageRef = context.createCGImage(image, fromRect: extent)
        
        CGContextSetInterpolationQuality(bitmapRef,  CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        // 2.保存bitmap到图片
        let scaledImage: CGImageRef = CGBitmapContextCreateImage(bitmapRef)!
        
        return UIImage(CGImage: scaledImage)
    }
}
