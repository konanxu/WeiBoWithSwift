//
//  StatusHeaderView.swift
//  WeiBo
//
//  Created by Konan on 16/3/22.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class StatusHeaderView: UIView {
    
    
    var status:Status? {
        didSet{
            fromLabel.text = status?.source       
            timeLabel.text = status?.created_at
            iconView.sd_setImageWithURL(status?.user?.image_url,placeholderImage: UIImage(named: "avatar_default"))
            verifiedView.image = status?.user?.verigiedImage
            nameLabel.text = status?.user?.name
            kingImageView.image = status?.user?.mbrankImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        addSubview(iconView)
        iconView.addSubview(verifiedView)
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(fromLabel)
        addSubview(kingImageView)
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(50)
            make.top.left.equalTo(iconView.superview!).offset(10)
        }
        verifiedView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.bounds.size.width * 0.5)
            make.centerY.equalTo(iconView.frame.size.height * 0.5)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(10)
            make.top.equalTo(iconView.snp_top)
        }
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp_bottom).offset(10)
            make.width.lessThanOrEqualTo(80)
        }
        fromLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(timeLabel.snp_right).offset(10)
            make.top.equalTo(nameLabel.snp_bottom).offset(10)
            make.right.equalTo(fromLabel.superview!.snp_right).offset(-10)
        }
        kingImageView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel.snp_right).offset(10)
            make.bottom.equalTo(nameLabel.snp_bottom)
        }
        
    }
    
    //MARK: - 控件
    private lazy var iconView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "avatar_default"))
        return imgView
    }()
    
    
    private lazy var verifiedView:UIImageView  = {
        let imgView = UIImageView(image: UIImage(named: "avatar_grassroot"))
        return imgView
    }()
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        
        return label
    }()
    private lazy var timeLabel:UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        //        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var fromLabel:UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        
        return label
    }()
    private lazy var kingImageView :UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "common_icon_membership"))
        return imgView
    }()
}
