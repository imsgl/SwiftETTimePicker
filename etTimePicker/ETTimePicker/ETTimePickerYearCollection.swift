//
//  ETTimePickerScroll.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/20.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit
import RxSwift

class ETTimePickerYearCollection: UICollectionView {
    
    let yearSubject = PublishSubject<Int>()//滚动到了哪年
    let yearCellSubject = PublishSubject<Int>()//选中那个月份
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        let etLayout = ETTimePickerYearLayout.init()
        etLayout.minimumLineSpacing = 15
        etLayout.minimumInteritemSpacing = 15
        etLayout.scrollDirection = .horizontal
        
        
        super.init(frame: frame, collectionViewLayout: etLayout)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.white
        self.register(ETTimePickerYearCell.self, forCellWithReuseIdentifier: "ETTimePickerYearCell")
        self.isPagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ETTimePickerYearCollection : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return ETTimePickerAchieveInfo.yearListDataArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ETTimePickerAchieveInfo.yearListDataArray[section].monthsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ETTimePickerYearCell.self, for: indexPath)
        cell.model = ETTimePickerAchieveInfo.yearListDataArray[indexPath.section].monthsArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ETTimePickerYearCellWidth, height: ETTimePickerYearCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = ETTimePickerAchieveInfo.yearListDataArray[indexPath.section].monthsArray[indexPath.row]
        if model.year == CURRENTYEAR , model.month > CURRENTMONTH{
            return
        }
        self.yearCellSubject.onNext(indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.yearSubject.onNext(Int(scrollView.contentOffset.x / SCREEN_WIDTH))
    }
    
}


