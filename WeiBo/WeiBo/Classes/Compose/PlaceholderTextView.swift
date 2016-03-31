//
//  PlaceholderTextView.swift
//  WeiBo
//
//  Created by Konan on 16/3/31.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit
import SnapKit

protocol PlaceholderTextViewDelegate{
    func isShow(ishow:Bool)
}

class PlaceholderTextView: UITextView {
    
    var myDelegate:PlaceholderTextViewDelegate?
    
    var isShow:Bool = true
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect) {
        label.frame = CGRectMake(8, 8, self.frame.size.width-16, 0)
        addSubview(label)
        label.font = self.font
        label.text = "分享新鲜事..."
        label.sizeToFit()
        
        super.drawRect(rect)
    }
    
    
    private lazy var label:UILabel = {
        let lab = UILabel()
        
        lab.textColor = UIColor.lightGrayColor()
        lab.backgroundColor = UIColor.clearColor()
        return lab
    }()
}
extension PlaceholderTextView:UITextViewDelegate{
    func textViewDidChange(textView: UITextView) {
        label.hidden = textView.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 ? true : false
        isShow = textView.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 ? true:false
        self.myDelegate?.isShow(isShow)

    }
}
