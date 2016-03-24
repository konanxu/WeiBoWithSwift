//
//  StatusPictureView.swift
//  WeiBo
//
//  Created by Konan on 16/3/22.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

import SDWebImage

class StatusPictureView: UICollectionView {
    var status:Status? {
        didSet{
            reloadData()
        }
    }
    private var pictureViewLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    init() {
        super.init(frame: CGRectZero, collectionViewLayout: pictureViewLayout)
        
        
        

            //注册cell
        registerClass(PictureViewCell.self, forCellWithReuseIdentifier: collectionCellIdentifier)
        delegate = self
        dataSource = self
        
        //设置cell之间的间隙
        pictureViewLayout.minimumInteritemSpacing = 10
        pictureViewLayout.minimumLineSpacing = 10
        //设置配图颜色
        backgroundColor = UIColor.redColor()
        

        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func calculateImageSize() ->CGSize{
        //1.取出配图数量
        let count = status?.storedPicURLS?.count
        //2.没有配图
        if  count == 0 || count == nil{
            return CGSizeZero
        }
        //3.配图为一张
        print("count:\(count)")
        if  count == 1{
            //            let key = status?.storedPicURLS!.first?.absoluteString
            let key = status?.bmiddle_picUrl?.absoluteString
            print("key:" + key!)
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
            
            let size = image == nil ? CGSizeZero  : CGSizeMake(image.size.width * 0.5, image.size.height * 0.5)
            return size
        }
        //4.配图为4张
        let width = 90
        let margin = 10
        pictureViewLayout.itemSize = CGSize(width: width, height: width)
        if  count == 4{
            let viewWidth = CGFloat(width * 2 + margin)
            
            return CGSize(width: viewWidth, height: viewWidth)
        }
        //5.配图为其他张数
        let colNumber = 3
        
        let rowNumber = (count! - 1) / 3 + 1
        let viewWidth = colNumber * width + (colNumber - 1) * margin
        let viewHeight = rowNumber * width + (rowNumber - 1) * margin
        //        pictureViewLayout.itemSize = CGSize(width: width, height: width)
        return CGSize(width: viewWidth, height: viewHeight)
    }

    
}

extension StatusPictureView: UICollectionViewDataSource,UICollectionViewDelegate{
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

class PictureViewCell:UICollectionViewCell{
    
    var imageUrl:NSURL? {
        didSet{
            pictureImageView.sd_setImageWithURL(imageUrl)
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
        self.addSubview(pictureImageView)
        pictureImageView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(pictureImageView.superview!)
            make.center.equalTo(pictureImageView.superview!)
        }
    }
    
    
    private lazy var pictureImageView:UIImageView = {
        let view = UIImageView()
        view.contentMode = UIViewContentMode.ScaleToFill
        return view
    }()
    
}