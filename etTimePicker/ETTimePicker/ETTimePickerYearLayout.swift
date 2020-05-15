//
//  ETTimePickerYearLayout.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/17.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit

class ETTimePickerYearLayout: UICollectionViewFlowLayout {

    private var attributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        for (index,value) in ETTimePickerAchieveInfo.yearListDataArray.enumerated() {
            for (monthIndex,_) in value.monthsArray.enumerated(){
                let currentAtts = UICollectionViewLayoutAttributes(forCellWith: IndexPath.init(row: monthIndex, section: index))
                currentAtts.frame = CGRect(x: CGFloat(index) * SCREEN_WIDTH + 15 + CGFloat(monthIndex % 3) * (ETTimePickerYearCellWidth + 15), y: 15 + CGFloat(monthIndex / 3) * (ETTimePickerYearCellHeight + 15), width: ETTimePickerYearCellWidth, height: ETTimePickerYearCellHeight)
                attributes.append(currentAtts)
            }
        }
        
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var rectAttributes: [UICollectionViewLayoutAttributes] = []
        _ = attributes.map({
        if rect.contains($0.frame) {rectAttributes.append($0)}})
        return rectAttributes
    }
    



}
