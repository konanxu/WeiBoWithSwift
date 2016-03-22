//
//  StatusFooterView.swift
//  WeiBo
//
//  Created by Konan on 16/3/22.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class StatusFooterView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    private func setUpUI(){
        addSubview(leftBtn)
        addSubview(centerBtn)
        addSubview(rightBtn)
        
        leftBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(leftBtn.superview!)
            make.width.equalTo(kWidth / 3)
            make.height.equalTo(kHeight)
            make.top.equalTo(leftBtn.superview!)
        }
        centerBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(leftBtn.snp_right)
            make.width.equalTo(kWidth / 3)
            make.height.equalTo(kHeight)
            make.top.equalTo(leftBtn.superview!)
        }
        rightBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(centerBtn.snp_right)
            make.width.equalTo(kWidth / 3)
            make.height.equalTo(kHeight)
            make.top.equalTo(leftBtn.superview!)
        }
    }
    
    private lazy var leftBtn:UIButton = {
        return  self.getBtn("timeline_icon_retweet", btnTitleName: "转发")
    }()
    
    private lazy var centerBtn:UIButton = {
        return  self.getBtn("timeline_icon_comment", btnTitleName: "评论")
    }()
    
    private lazy var rightBtn:UIButton = {
        return  self.getBtn("timeline_icon_unlike", btnTitleName: "赞")
    }()
    
    private func getBtn(btnImageName:String,btnTitleName:String) ->UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named:btnImageName), forState: UIControlState.Normal)
        btn.setTitle(btnTitleName, forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        btn.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "timeline_card_bottom_line_highlighted"), forState: UIControlState.Highlighted)
        return btn
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
