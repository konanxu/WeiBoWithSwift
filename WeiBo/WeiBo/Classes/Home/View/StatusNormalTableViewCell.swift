//
//  StatusNormalTableViewCell.swift
//  WeiBo
//
//  Created by Konan on 16/3/24.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

class StatusNormalTableViewCell:StatusTableViewCell{
    override func setUpUI() {
        super.setUpUI()
        pictureView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentLabel)
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(contentLabel.snp_bottom).offset(10)
        }
        pictureViewWidthCons = pictureView.getConstraintWidth()
        pictureViewHeightCons = pictureView.getConstraintHeight()
    }
}
