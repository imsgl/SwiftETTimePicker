//
//  ETTimePickerLayout.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/16.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit

class ETTimePickerDayLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        for (index ,value) in (attributes ?? [UICollectionViewLayoutAttributes]()).enumerated() {
            if index != 0{
                let currentAtts = value
                var currentFrame = currentAtts.frame
                if index % 7 != 0 {
                    let passAtts = attributes![index - 1]
                    let passFrame = passAtts.frame
                    currentFrame.origin.x = passFrame.origin.x + passFrame.size.width
                }
                currentAtts.frame = currentFrame
            }
            
        }
        
        return attributes
    }
}
