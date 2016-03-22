//
//  StatusTableViewCell.swift
//  WeiBo
//
//  Created by Konan on 16/3/18.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

import SnapKit
import SDWebImage


let collectionCellIdentifier = "collectionCellIdentifier"
let kWidth  = UIScreen.mainScreen().bounds.size.width
let kHeight = 40
class StatusTableViewCell: UITableViewCell {
    
    var pictureViewWidthCons : NSLayoutConstraint?
    var pictureViewHeightCons : NSLayoutConstraint?
    
    var status:Status? {
        didSet{

            headerView.status = status
            contentLabel.text = status?.text
            //根据配图的尺寸
            pictureView.status = status
            let size = pictureView.calculateImageSize()
            pictureViewWidthCons?.constant = size.width
            pictureViewHeightCons?.constant = size.height
            
//            if size.itemSize != CGSizeZero{
//                pictureViewLayout.itemSize = size.itemSize
//            }
            
//            print("layoutSize: \(size.itemSize)")
            //设置layout.layoutitem
            
//            pictureView.reloadData()
        }
    }
    
    func rowHeight(status:Status) ->CGFloat{
        self.status = status

        self.layoutIfNeeded()
        return CGRectGetMaxY(footerView.frame)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
//        setUpPictureView()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI(){
        contentView.addSubview(headerView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(footerView)
        contentView.addSubview(pictureView)

        headerView.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(headerView.superview!).offset(0)
            make.height.equalTo(60)
            make.width.equalTo(kWidth-20)
        }
        
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(headerView.snp_bottom).offset(20)
            make.left.equalTo(headerView).offset(10)
        }
        pictureView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentLabel)
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(contentLabel.snp_bottom).offset(10)
        }
        pictureViewWidthCons = pictureView.getConstraintWidth()
        pictureViewHeightCons = pictureView.getConstraintHeight()
        
        footerView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(kWidth)
            make.height.equalTo(40)
            make.left.equalTo(footerView.superview!)
            make.top.equalTo(pictureView.snp_bottom).offset(10)
            
        }
        
        

    }
    
    private lazy var headerView:StatusHeaderView = StatusHeaderView()

    
    private lazy var contentLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.size.width - 20
        return label
    }()
    
    private lazy var pictureViewLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var pictureView:StatusPictureView = StatusPictureView()
//    UICollectionView(frame: CGRectZero, collectionViewLayout: self.pictureViewLayout)
    
    
    private lazy var footerView:StatusFooterView = StatusFooterView()
    
    
//    private func setUpPictureView(){
//        //注册cell
//        pictureView.registerClass(PictureViewCell.self, forCellWithReuseIdentifier: collectionCellIdentifier)
//        pictureView.delegate = self
//        pictureView.dataSource = self
//        
//        //设置cell之间的间隙
//        pictureViewLayout.minimumInteritemSpacing = 10
//        pictureViewLayout.minimumLineSpacing = 10
//        //设置配图颜色
//        pictureView.backgroundColor = UIColor.redColor()
//        
//    }
}



extension StatusTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return status?.storedPicURLS?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellIdentifier, forIndexPath: indexPath) as! PictureViewCell
        cell.imageUrl = status?.storedPicURLS![indexPath.row]
        cell.backgroundColor = UIColor.yellowColor()
        
        return cell
    }
}


