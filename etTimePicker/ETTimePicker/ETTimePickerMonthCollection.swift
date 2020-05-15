//
//  ETTimePickerMonthCollection.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/17.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit
import RxSwift
class ETTimePickerMonthCollection: UICollectionView {
    let monthSubject = PublishSubject<Int>()//滚动到了哪年
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        let etLayout = UICollectionViewFlowLayout.init()
        etLayout.minimumLineSpacing = 0
        etLayout.minimumInteritemSpacing = 0
        etLayout.scrollDirection = .horizontal
        
        
        super.init(frame: frame, collectionViewLayout: etLayout)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.clear
        self.register(ETTimePickerMonthCell.self, forCellWithReuseIdentifier: "ETTimePickerMonthCell")
        self.isPagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.addSubview(self.headerView)
        self.monthSubject.onNext(0)
    }
    
    
    
    lazy var headerView : ETTimePickerMonthCollectionHeaderView  = {
        let headerView = ETTimePickerMonthCollectionHeaderView.init(frame: CGRect(x: 0, y: 0, width: self.width, height: 30))
        return headerView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ETTimePickerMonthCollection : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ETTimePickerAchieveInfo.monthListDataArray.count - (12 - CURRENTMONTH)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ETTimePickerMonthCell.self, for: indexPath)
        cell.model = ETTimePickerAchieveInfo.monthListDataArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: ETTimePickerMonthCollectionHeight - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.headerView.left = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.monthSubject.onNext(Int(scrollView.contentOffset.x / SCREEN_WIDTH))
        self.reloadData()
    }
    
}




class ETTimePickerMonthCollectionHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawLine(strokeColor: COLOR170!, lineWidth: 0.5, corners: [.bottom])
        self.setWeekName()
    }
    
    private func setWeekName(){
        let weekNameArray = ["一","二","三","四","五","六","日"]
        for (index , value) in weekNameArray.enumerated() {
            let weekNameLabel = UILabel.init(frame: CGRect(x: SCREEN_WIDTH / 7 * CGFloat(index), y: 0, width: SCREEN_WIDTH / 7, height: self.height))
            weekNameLabel.text = value
            weekNameLabel.textAlignment = .center
            weekNameLabel.font = UIFont.systemFont(ofSize: 16)
            weekNameLabel.textColor = COLOR170
            self.addSubview(weekNameLabel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
