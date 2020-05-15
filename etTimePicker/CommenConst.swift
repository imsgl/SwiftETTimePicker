//
//  CommenConst.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/2.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit




let CURRENTYEAR = Date().year
let CURRENTMONTH = Date().month


//MARK:tabbar高度
let TABBARHEIGHT : CGFloat = 49
//MARK:安全区高度
var SAFEHEIGHT : CGFloat{
    if isIphoneX {
        return 34
    }
    return 0
}
//MARK:NAV高度
let NAVBARHEIGHT : CGFloat = 44
//MARK:状态栏高度
var STATUSBARHEIGHT : CGFloat {
    if #available(iOS 13.0, *) {
        let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        return (statusBarManager?.statusBarFrame.height)!
    }
    else {
        return UIApplication.shared.statusBarFrame.height
    }
}
//MARK: 整个nav高度
let NAVHEIGHT = NAVBARHEIGHT + STATUSBARHEIGHT
//MARK:屏幕宽
let SCREEN_WIDTH = UIScreen.main.bounds.width
//MARK:屏幕高
let SCREEN_HEIGHT = UIScreen.main.bounds.height
//MARK:列表页二、三。。级页高度
let LISTCONENTHEIGHT = SCREEN_HEIGHT - NAVHEIGHT
//MARK:Index页高度
let INDEXCONENTHEIGHT = SCREEN_HEIGHT - NAVHEIGHT - TABBARHEIGHT - SAFEHEIGHT
//MARK:判断是否是iphoneX类型
var  isIphoneX : Bool{
    return (UIScreen.main.bounds.height >= 812.0)
}
 let LINECOLOR = UIColor.init(hexString: "E4E4E4")
 let COLOR92 = UIColor.init(hexString: "5C5C5C")  //深一点的灰色
 let COLOR150 = UIColor.init(hexString: "969696")  //深一点的灰色
 let COLOR170 = UIColor.init(hexString: "AAAAAA")  //深一点的灰色
 let COLOR200 = UIColor.init(hexString: "C8C8C8")  //浅一点的灰色
 let COLOR_PROGRESSBGVIEW = UIColor.init(hexString: "D6D6D6")  //进度条的背景颜色
 let COLOR_SCREEN = UIColor.init(hexString: "146CFF")//筛选按钮
 let COLOR_BLUE = UIColor.init(hexString: "2073FF")//确认按钮
 let COLOR_87 = UIColor.init(hexString: "878787")//时间的颜色
 let COLOR_PROGRESSNUMBER = UIColor.init(hexString: "4D4D4D")
 let COLOR_GROUPBACKGROUNDCOLOR = UIColor.init(hexString: "F2F2F2")
 let COLOR88194243 = UIColor.init(hexString: "58C2F3")//浅蓝色


