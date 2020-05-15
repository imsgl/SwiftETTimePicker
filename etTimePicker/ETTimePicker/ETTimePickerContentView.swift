//
//  ETTimePickerContentView.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/16.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit
import RxSwift




class ETTimePickerContentView: UIView {
    var disposeBag = DisposeBag()
    var showStyle = ETTimePickerShowType.month
    var currentShowYearIndex = 0
    var currentShowMonthIndex = 0
    let finishObject = PublishSubject<String>()//选择完成
    init() {
        super.init(frame: CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 0))
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.Bind()
        self.addSubviews([self.headerView,self.monthBgTitleLabel,self.monthCollectionView,self.yearCollectionView,self.hourAndMinView])
        self.height = self.monthCollectionView.bottom
        //滚动到当前月份
        if #available(iOS 11.0, *) {
            self.monthCollectionView.performBatchUpdates(nil) { [weak self](_) in
                self!.monthCollectionView.contentOffset = CGPoint(x: Int(SCREEN_WIDTH) * (ETTimePickerAchieveInfo.monthListDataArray.count - (12 - CURRENTMONTH + 1)), y: 0)
                self!.currentShowMonthIndex = ETTimePickerAchieveInfo.monthListDataArray.count - (12 - CURRENTMONTH) - 1
            }
        }else {
            DispatchQueue.main.async {
                self.monthCollectionView.contentOffset = CGPoint(x: Int(SCREEN_WIDTH) * (ETTimePickerAchieveInfo.monthListDataArray.count - (12 - CURRENTMONTH + 1)), y: 0)
                self.currentShowMonthIndex = ETTimePickerAchieveInfo.monthListDataArray.count - (12 - CURRENTMONTH) - 1
            }
        }
    }
    
    //MARK:顶部的确认按钮 年份选择按钮等等
    lazy var headerView : ETTimePickerContentHeaderView = {
        let headerView = ETTimePickerContentHeaderView.init()
        return headerView
    }()
    
    //MARK:展示月份的底部的年份提示文字
    lazy var monthBgTitleLabel : UILabel = {
        let monthBgTitleLabel = UILabel.init(frame: CGRect(x: 0, y: self.headerView.bottom, width: SCREEN_WIDTH, height: ETTimePickerMonthCollectionHeight))
        monthBgTitleLabel.text = String.init(format: "%d", CURRENTYEAR)
        monthBgTitleLabel.textColor = UIColor.init(hexString: "E9E9E9")
        monthBgTitleLabel.textAlignment = .center
        monthBgTitleLabel.font = UIFont.systemFont(ofSize: 130)
        return monthBgTitleLabel
    }()
    
    //MARK:展示月份的collection
    lazy var monthCollectionView : ETTimePickerMonthCollection = {
        let collectionView = ETTimePickerMonthCollection.init(frame: CGRect(x: 0, y: self.headerView.bottom, width: SCREEN_WIDTH, height: ETTimePickerMonthCollectionHeight) , collectionViewLayout: UICollectionViewFlowLayout.init())
        return collectionView
    }()
    
    //MARK:展示年份的collection
    lazy var yearCollectionView : ETTimePickerYearCollection = {
        let collectionView = ETTimePickerYearCollection.init(frame: CGRect(x: 0, y: self.headerView.bottom, width: SCREEN_WIDTH, height: ETTimePickerYearCollectionHeight) , collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.isHidden = true
        return collectionView
    }()
    
    //MARK:选择小时和分钟的View
    lazy var hourAndMinView : ETTimePickerDatePickerView = {
        let hourAndMinView = ETTimePickerDatePickerView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.monthCollectionView.bottom))
        hourAndMinView.isHidden = true
        return hourAndMinView
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ETTimePickerContentView{
    func Bind(){
        //MARK:monthCollection滚动
        self.monthCollectionView.monthSubject.subscribe{[weak self] index in
            let monthModel = ETTimePickerAchieveInfo.monthListDataArray[index.element!]
            self!.currentShowMonthIndex = index.element!
            self!.headerView.yearOrMonthBtn.setTitle(String.init(format: "%d月", monthModel.month), for: .normal)
            self!.monthBgTitleLabel.text = String.init(format: "%d", monthModel.year)
        }.disposed(by: disposeBag)
        
        //MARK:YearCollection滚动
        self.yearCollectionView.yearSubject.subscribe{[weak self] index in
            let yearModel = ETTimePickerAchieveInfo.yearListDataArray[index.element!]
            self!.currentShowYearIndex = index.element!
            self!.headerView.yearOrMonthBtn.setTitle(String.init(format: "%d年", yearModel.year), for: .normal)
        }.disposed(by: disposeBag)
        
        //MARK:yearCollection选择月份
        self.yearCollectionView.yearCellSubject.subscribe{[weak self] index in
            self!.showStyle = .month
            self!.yearCollectionView.isHidden = true
            self!.currentShowMonthIndex = self!.currentShowYearIndex * 12 + index.element!
            self!.monthCollectionView.contentOffset = CGPoint(x: Int(SCREEN_WIDTH) * self!.currentShowMonthIndex, y: 0)
            self!.monthCollectionView.monthSubject.onNext(self!.currentShowMonthIndex)
            UIView.animate(withDuration: 0.2) {
                self!.height = self!.monthCollectionView.bottom
                self!.top = SCREEN_HEIGHT - self!.height
            }
        }.disposed(by: disposeBag)
        
        //MARK:顶部headerView按钮的点击事件
        self.headerView.subject.subscribe{[weak self] event in
            if event.element == .style{//显示年份还是月份
                self?.styleChange()
            }
            if event.element == .submit{//确认按钮
                if ETTimePickerFirst.year == 0{
                    print("kai shi  shijian buneng weikong ")
                    return
                }else if ETTimePickerSecond.year == 0{
                    print("jieshu  shijian buneng weikong ")
                    return
                }
                
                self!.finishObject.onNext("")
            }
            if event.element == .today{//今天按钮
                if self!.currentShowMonthIndex == ETTimePickerAchieveInfo.monthListDataArray.count - (12 - CURRENTMONTH) - 1{
                    return
                }
                self!.currentShowMonthIndex = ETTimePickerAchieveInfo.monthListDataArray.count
                self!.currentShowMonthIndex = self!.currentShowMonthIndex - (12 - CURRENTMONTH) - 1
                UIView.animate(withDuration: 0.3, animations: {
                    let left = Int(SCREEN_WIDTH) * (ETTimePickerAchieveInfo.monthListDataArray.count - (12 - CURRENTMONTH + 1))
                    self!.monthCollectionView.contentOffset = CGPoint(x: left, y: 0)
                }) { (_) in
                    self!.monthCollectionView.monthSubject.onNext(self!.currentShowMonthIndex)
                }
                
                
                
            }
        }.disposed(by: disposeBag)
        
        //MARK:选择了日期后显示时间的选择框
        ETSelectTimeObjcect.subscribe{[weak self] _ in
            self!.hourAndMinView.isHidden = false
        }.disposed(by: ETDisposeBag)
        
        //MARK:时间选择框的Object
        self.hourAndMinView.datePickerObject.subscribe{[weak self] time in
            if ETTimePickerFirst.year != 0 , ETTimePickerSecond.year == 0  {
                self?.headerView.endTimeLabel.isHidden = true
                ETTimePickerFirst.hour = time.element!.hour
                ETTimePickerFirst.minute = time.element!.minute
                self!.headerView.startTimeLabel.text = String.init(format: "开始时间:%@", ETGetStartDate().toFormat("yyyy-MM-dd HH:mm"))
                self?.headerView.startTimeLabel.isHidden = false
            }else{
                ETTimePickerSecond.hour = time.element!.hour
                ETTimePickerSecond.minute = time.element!.minute
                self!.headerView.endTimeLabel.text = String.init(format: "结束时间:%@", ETGetEndDate().toFormat("yyyy-MM-dd HH:mm"))
                self?.headerView.endTimeLabel.isHidden = false
            }
            
            let startDate = ETGetStartDate()
            let endDate = ETGetEndDate()
            if startDate == endDate{
                ETTimePickerSecond = (year: 0 , month: 0 , day: 0 , hour : 0 , minute : 0)
                self!.headerView.endTimeLabel.isHidden = true
                self!.headerView.startTimeLabel.isHidden = false
            }else if startDate > endDate , ETTimePickerSecond.year != 0{
                let temDate = ETTimePickerSecond
                ETTimePickerSecond = ETTimePickerFirst
                ETTimePickerFirst = temDate
                self!.headerView.startTimeLabel.text = String.init(format: "开始时间:%@", ETGetStartDate().toFormat("yyyy-MM-dd HH:mm"))
                self!.headerView.endTimeLabel.text = String.init(format: "结束时间:%@", ETGetEndDate().toFormat("yyyy-MM-dd HH:mm"))
                
            }
            self!.monthCollectionView.reloadData()
        }.disposed(by: disposeBag)
        
    }
    
    
    
    
    //MARK:显示风格改变
    func styleChange() {
        if self.showStyle == .month {
            self.showStyle = .year
            self.yearCollectionView.isHidden = false
            //设置当前显示的年份Index下标
            self.currentShowYearIndex = self.currentShowMonthIndex / 12
            //根据月份滚动到对应的年份
            self.yearCollectionView.contentOffset = CGPoint(x: Int(SCREEN_WIDTH) * self.currentShowYearIndex, y: 0)
            //发送信号调整顶部按钮的文字
            self.yearCollectionView.yearSubject.onNext(self.currentShowYearIndex)
            UIView.animate(withDuration: 0.2) {
                self.height = self.yearCollectionView.bottom
                self.top = SCREEN_HEIGHT - self.height
            }
        }
    }
    
}



