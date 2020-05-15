//
//  ETTimePickerYearToDayCell.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/21.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit

class ETTimePickerYearToDayCell: UICollectionViewCell {
     var model : ETTimePickerDayModel?{
            didSet{
                if model!.day == 0 {
                    self.titleLabel.text = ""
                }else{
                    self.titleLabel.text = String.init(format: "%d", model!.day)
                }
            }
        }
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = UIColor.clear
            self.addSubviews([titleLabel])
        }
        
        lazy var titleLabel : UILabel = {
            let titleLabel = UILabel.init(frame: self.bounds)
            titleLabel.textAlignment = .center
            titleLabel.text = ""
            titleLabel.textColor = COLOR150
            return titleLabel
        }()
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
