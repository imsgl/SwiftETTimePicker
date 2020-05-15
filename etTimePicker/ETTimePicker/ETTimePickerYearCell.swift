//
//  ETTimePickerYearToMonthCell.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/20.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit

class ETTimePickerYearCell: UICollectionViewCell {
    var model : ETTimePickerMonthModel?{
        didSet{
            self.titleLabel.text = String.init(format: "%d月", model!.month)
            if model!.year == CURRENTYEAR , model!.month > CURRENTMONTH {
                self.notCanSelectImg.isHidden = false
            }else{
                self.notCanSelectImg.isHidden = true
            }
            self.collectionView.reloadData()
        }
    }
    var contentHeight : CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = false
        self.backgroundColor = UIColor.white
        self.addSubviews([self.titleLabel,self.collectionView,self.notCanSelectImg])
    }
    
    lazy var collectionLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: self.width / 7, height: self.width / 7)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.width, height: 20))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.text = "4月"
        titleLabel.textColor =  UIColor.init(hexString: "FD892F")
        return titleLabel
    }()
    
    lazy var notCanSelectImg : UIImageView = {
        let imgWidth = self.width
        let imgHeight = imgWidth / 373 * 98
        let notCanSelectImg = UIImageView.init(frame: CGRect(x: 0, y: self.height / 2.0 - imgHeight / 2.0, width: imgWidth, height: imgHeight))
        notCanSelectImg.image = UIImage.init(named: "ETTimePickerMonthNotCanSelect")
        return notCanSelectImg
    }()
    
    lazy var collectionView : UICollectionView = {
        
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: self.titleLabel.bottom, width: self.width, height: self.height - self.titleLabel.height) , collectionViewLayout: collectionLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(ETTimePickerYearToDayCell.self, forCellWithReuseIdentifier: "ETTimePickerYearToDayCell")
        collectionView.isUserInteractionEnabled = false
        return collectionView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ETTimePickerYearCell : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.daysArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ETTimePickerYearToDayCell.self, for: indexPath)
        cell.model = model?.daysArray[indexPath.row]
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 10)
        return cell
    }
    
}
