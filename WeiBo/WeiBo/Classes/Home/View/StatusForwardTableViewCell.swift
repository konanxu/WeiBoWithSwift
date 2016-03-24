//
//  StatusForwardTableViewCell.swift
//  WeiBo
//
//  Created by Konan on 16/3/22.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit
import SnapKit

class StatusForwardTableViewCell: StatusTableViewCell{
    
    
    //重写父类的didSet并不会覆盖父类的操作
    //只需要在重写方法中做自己想做的事
    //注意点：如果父类是didSet，那么子类重写也只能重写didSet
    override var status:Status?{
        didSet{
            let name = status?.retweeted_status?.user?.name ?? ""
            let text = status?.retweeted_status?.text ?? ""
            forwardLabel.text = name + ":" + text
        }
    }
    
    
    override func setUpUI() {
        super.setUpUI()
        contentView.insertSubview(forwardBtn, belowSubview: pictureView)
        forwardBtn.addSubview(forwardLabel)
        forwardBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(10)
//            make.right.equalTo(contentLabel.snp_right).offset(10)
            make.left.equalTo(contentLabel.snp_left).offset(-10)
            make.bottom.equalTo(footerView.snp_top).offset(-10)
            make.width.equalTo(UIScreen.mainScreen().bounds.width)
        }
        forwardLabel.text = "dsfsdfnjskdnfkjdsnfkjdsnfkjfn"
        forwardLabel.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(forwardBtn).offset(10)
        }
        
        pictureView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentLabel)
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(forwardLabel.snp_bottom).offset(10)
        }
        pictureViewWidthCons = pictureView.getConstraintWidth()
        pictureViewHeightCons = pictureView.getConstraintHeight()
        
        footerView.snp_updateConstraints { (make) -> Void in
            make.top.equalTo(pictureView.snp_bottom).offset(10)
        }
        
    }
    
    private lazy var forwardLabel:UILabel = {
        let label = UILabel.createLabel(UIColor.darkGrayColor(), fontSize: 15)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        return label
     }()
    private lazy var forwardBtn :UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        return btn
    }()
        
}