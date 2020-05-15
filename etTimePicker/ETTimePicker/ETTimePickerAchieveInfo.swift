//
//  ETTimePickerAchieveInfo.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/15.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit
import RxSwift

let ETTimeSelectFinishObject = PublishSubject<String>()
let ETSelectTimeObjcect = PublishSubject<String>()//选择了开始或者是结束时间
let ETDisposeBag = DisposeBag()

var ETTimePickerFirst = (year: 0 , month: 0 , day: 0 , hour : 0 , minute : 0)
var ETTimePickerSecond = (year: 0 , month: 0 , day: 0 , hour : 0 , minute : 0)

let ETTimePickerMonthCollectionHeight = SCREEN_WIDTH / 7 * 6 + 30
let ETTimePickerYearCellWidth : CGFloat = (SCREEN_WIDTH - 60) / 3
let ETTimePickerYearCellHeight : CGFloat = ETTimePickerYearCellWidth / 7 * 6 + 20
let ETTimePickerYearCollectionHeight : CGFloat = ETTimePickerYearCellHeight * 4 + 15 * 4 + 10


func ETGetStartDate() -> DateInRegion{
    let rome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
    let startDate = DateInRegion(components: {
        $0.year = ETTimePickerFirst.year
        $0.month = ETTimePickerFirst.month
        $0.day = ETTimePickerFirst.day
        $0.hour = ETTimePickerFirst.hour
        $0.minute = ETTimePickerFirst.minute
    }, region: rome)
    return startDate!
}
//MARK:获取结束时间的dateInRegion
func ETGetEndDate() -> DateInRegion {
    
    let rome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
    let endDate = DateInRegion(components: {
        $0.year = ETTimePickerSecond.year
        $0.month = ETTimePickerSecond.month
        $0.day = ETTimePickerSecond.day
        $0.hour = ETTimePickerSecond.hour
        $0.minute = ETTimePickerSecond.minute
    }, region: rome)
    return endDate!
}


func ETHidden(){
    UIView.animate(withDuration: 0.3, animations: {
        ETTimePickerView.ET.contentView.top = SCREEN_HEIGHT
    }) { (_) in
        ETTimePickerView.ET.isHidden = true
    }
}




enum ETTimePickerShowType {
    case month
    case year
}



class ETTimePickerAchieveInfo{
    
    static let yearListDataArray = ETTimePickerAchieveInfo.yearListData()
    static let monthListDataArray = ETTimePickerAchieveInfo.monthListData()
    
    
    static func yearListData() ->[ETTimePickerYearModel]{
        let startTimeDate = Date.init(timeIntervalSinceReferenceDate: 0)//开始时间
        let endTimeDate = Date()//结束时间
        //循环年份
        var dataArray = [ETTimePickerYearModel]()
        for year in startTimeDate.year...endTimeDate.year{
            let yearModel = ETTimePickerAchieveInfo.yearModel(year: year, monthsArray: ETTimePickerAchieveInfo.monthsModelArray(year: year))
            dataArray.append(yearModel)
        }
        
        return dataArray
    }
    
    
    static func monthListData() ->[ETTimePickerMonthModel]{
        let startTimeDate = Date.init(timeIntervalSinceReferenceDate: 0)//开始时间
        let endTimeDate = Date()//结束时间
        //循环年份
        var dataArray = [ETTimePickerMonthModel]()
        for year in startTimeDate.year...endTimeDate.year{
            dataArray.append(contentsOf: ETTimePickerAchieveInfo.monthsModelArray(year: year))
        }
        
        
        return dataArray
    }
    
    //MARK:设置 日 的model数据
    static func dayModel(year : Int , month : Int ,day : Int) -> ETTimePickerDayModel {
        let dayModel = ETTimePickerDayModel()
        dayModel.day = day
        dayModel.month = month
        dayModel.year = year
        return dayModel
    }
    
    //MARK:根据月份生成当前月份下的所有日期数组
    static func daysModelArray(year : Int , month : Int , monthDate : DateInRegion) -> [ETTimePickerDayModel]{
        var daysArray = [ETTimePickerDayModel](repeating: ETTimePickerDayModel(), count:ETTimePickerAchieveInfo.currentMonthEmptyDays(monthDate: monthDate))
        for day in 1...monthDate.monthDays {
            daysArray.append(ETTimePickerAchieveInfo.dayModel(year: year, month: month, day: day))
        }
        
        let emptyArray = [ETTimePickerDayModel](repeating: ETTimePickerDayModel(), count:42 - daysArray.count)
        daysArray.append(contentsOf: emptyArray)
        return daysArray
    }
    
    //MARK:设置月的model数据
    static func monthModel(year : Int , month : Int , daysArray : [ETTimePickerDayModel]) -> ETTimePickerMonthModel{
        let monthModel = ETTimePickerMonthModel()
        monthModel.month = month
        monthModel.year = year
        monthModel.daysArray = daysArray
        let number = daysArray.count / 7 + (daysArray.count % 7 > 0 ? 1 : 0)
        monthModel.cellHeight = CGFloat(number) * SCREEN_WIDTH / 7
        return monthModel
    }
    
    //MARK:根据年份生成当前年份下的所有月份数组
    static func monthsModelArray(year : Int) -> [ETTimePickerMonthModel]{
        var monthsArray = [ETTimePickerMonthModel]()
        for month in 1...12{
            let monthDate = DateInRegion(year: year, month: month, day: 1)
            let monthModel = ETTimePickerAchieveInfo.monthModel(year: year, month: month, daysArray: ETTimePickerAchieveInfo.daysModelArray(year: year, month: month, monthDate: monthDate))
            monthsArray.append(monthModel)
        }
        return monthsArray
    }
    
    //MARK:设置年的model数据
    static func yearModel(year : Int , monthsArray : [ETTimePickerMonthModel]) -> ETTimePickerYearModel{
        let yearModel = ETTimePickerYearModel()
        yearModel.year = year
        yearModel.monthsArray = monthsArray
        return yearModel
    }
    
    
    
    //MARK:获取当前月空余的位置（比如：星期二是第一天则空余一天）
    static func currentMonthEmptyDays(monthDate : DateInRegion) -> Int{
        var emptyDayNumber = monthDate.firstDayMonth
        if emptyDayNumber == 0 {
            emptyDayNumber = 6
        }else{
            emptyDayNumber = emptyDayNumber - 1
        }
        return emptyDayNumber
    }
}
