//
//  NSDate+Category.swift
//  WeiBo
//
//  Created by Konan on 16/3/19.
//  Copyright © 2016年 Konan. All rights reserved.
//

import UIKit

extension NSDate {
    class func dateWithStr(timeStr:String) ->NSDate{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        formatter.locale = NSLocale(localeIdentifier: "en")
        let createDate = formatter.dateFromString(timeStr)!
        return createDate
    }
    
    var descDate:String{
        let calendar = NSCalendar.currentCalendar()
        
    //判断是否今天
        if  calendar.isDateInToday(self){
            let since = Int(NSDate().timeIntervalSinceDate(self))
            if since < 60{
                return "刚刚"
            }
            if(since < 60 * 60){
                return "\(since / 60)分钟前"
            }
            return "\(since / 60 * 60 )小时前"
        }
        
        var formatterStr = "HH:mm"
        if  calendar.isDateInYesterday(self){
            formatterStr = "昨天" + formatterStr
        }else{
            //一年以内
            formatterStr = "MM-dd " + formatterStr
            
            let comps = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            if  comps.year >= 1{
                formatterStr = "yyyy-MM-dd"
            }
        }
        
        
        
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = formatterStr
        formatter.locale = NSLocale(localeIdentifier: "en")
        return formatter.stringFromDate(self)
        
        
        
    }
}