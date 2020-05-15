//
//  ETTimePickerMonthView.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/15.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit

class ETTimePickerMonthCell: UICollectionViewCell {
    
    var model : ETTimePickerMonthModel?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.collectionView)
    }
    
    
    lazy var collectionView : UICollectionView = {
        let layout = ETTimePickerDayLayout.init()
        layout.itemSize = CGSize(width: Int(self.width / 7), height: Int(self.width / 7))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView.init(frame: self.bounds , collectionViewLayout:layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(ETTimePickerDayCell.self, forCellWithReuseIdentifier: "ETTimePickerDayCell")
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ETTimePickerMonthCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ETTimePickerDayCell.self, for: indexPath)
        cell.model = self.model?.daysArray[indexPath.row]
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentModel = self.model!.daysArray[indexPath.row]
        if currentModel.day == 0 {
            return
        }
        if ETTimePickerFirst.year == 0 , ETTimePickerSecond.year == 0 { //开始时间未选择  结束时间未选择
            ETTimePickerFirst = (year: currentModel.year , month: currentModel.month , day: currentModel.day , hour : 0 , minute : 0)
        }else if ETTimePickerFirst.year != 0 , ETTimePickerSecond.year == 0{//有开始时间 结束时间未选择
            ETTimePickerSecond = (year: currentModel.year , month: currentModel.month , day: currentModel.day , hour : 0 , minute : 0)
        }else if ETTimePickerFirst.year != 0 , ETTimePickerSecond.year != 0 {
            ETTimePickerFirst = (year: currentModel.year , month: currentModel.month , day: currentModel.day , hour : 0 , minute : 0)
            ETTimePickerSecond = (year: 0 , month: 0 , day: 0 ,  hour : 0 , minute : 0)
        }
        //发送信号量 显示出选择小时和分钟的控件
        ETSelectTimeObjcect.onNext("")
    }
}

