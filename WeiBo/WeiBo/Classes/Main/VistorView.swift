//
//  VistorView.swift
//  WeiBo
//
//  Created by Konan on 16/3/9.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

import SnapKit

protocol vistorViewDelegate:NSObjectProtocol{
    func vistorViewLoginClick()
    func vistorViewRegisterClick()
}

class VistorView: UIView {

    
    weak var delegate:vistorViewDelegate?
    
    func setUpInfo(isHome:Bool,imageName:String,message:String){
        bgImgView.hidden = !isHome
        centerImgView.image = UIImage(named: imageName)
        titleLabel.text = message
        if(isHome){
            startAnimation()
        }
    }
    func centerViewUpdateConstraints() {
        centerImgView.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(titleLabel.snp_top).offset(-20)
        }
    }
    
    func loginClick(){
        delegate?.vistorViewLoginClick()
    }
    func registerClick(){
        delegate?.vistorViewRegisterClick()
    }
    
    private func startAnimation(){
        //创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.duration = 20
        anim.repeatCount = MAXFLOAT
        anim.removedOnCompletion = false
        bgImgView.layer.addAnimation(anim, forKey: nil)
        
    }
//    swift推荐自定义控件 纯代码 xib/sb 二选一
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImgView)
        addSubview(maskBgView)
        addSubview(titleLabel)
        addSubview(loginBtn)
        addSubview(registerBtn)
        
        addSubview(centerImgView)
       
        
        titleLabel.snp_makeConstraints { (make) -> Void in

            make.center.equalTo(self)
            make.width.equalTo(200)
        }
        centerImgView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(titleLabel.snp_top).offset(20)
            make.centerX.equalTo(titleLabel)
        }
        bgImgView.snp_makeConstraints { (make) -> Void in
//            make.bottom.equalTo(titleLabel.snp_top).offset(0)
            make.center.equalTo(centerImgView)
        }
        loginBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp_bottom).offset(30)
            make.left.equalTo(bgImgView)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        registerBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp_bottom).offset(30)
            make.right.equalTo(bgImgView)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        maskBgView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(centerImgView)
//            make.size.equalTo(self)
        }
        maskBgView.contentMode = UIViewContentMode.ScaleAspectFill
    }
    //若通过xib/sb 创建则崩溃
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var bgImgView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon") )
        return view
    }()
    private lazy var centerImgView:UIImageView = {
        let view = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "微博微博微博微博微博微博"
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor(colorLiteralRed: 208/255.0, green: 208/255.0, blue: 208/255.0, alpha: 1)
        label.textAlignment = .Center
        return label
    }()
    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.addTarget(self, action: "loginClick", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    private lazy var registerBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.tintColor = UIColor.orangeColor()
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.addTarget(self, action: "registerClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    private lazy var maskBgView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        
        return view
    }()
    

}
