//
//  VistorView.swift
//  WeiBo
//
//  Created by Konan on 16/3/9.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class VistorView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
//    swift推荐自定义控件 纯代码 xib/sb 二选一
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImgView)
        addSubview(centerImgView)
        addSubview(titleLabel)
        addSubview(loginBtn)
        addSubview(registerBtn)
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
        label.text = "sdfsdfdfsdfsdfsd"
        return label
    }()
    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        return btn
    }()
    
    private lazy var registerBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Register", forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        return btn
    }()
    
    

}
