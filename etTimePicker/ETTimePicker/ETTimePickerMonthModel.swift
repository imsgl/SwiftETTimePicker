//
//  ETTimeMonthModel.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/16.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit

class ETTimePickerMonthModel: NSObject {
    var year = 0//当前年份
    var month = 0//当前月份
    var daysArray = [ETTimePickerDayModel]()//存放当前月的日期信息
    var cellHeight : CGFloat = 0//cell的高度
}
