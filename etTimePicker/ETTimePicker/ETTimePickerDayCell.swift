//
//  ETTimeCell.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/15.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit

class ETTimePickerDayCell: UICollectionViewCell {
    
    var model : ETTimePickerDayModel?{
        didSet{
            if model!.day == 0 {
                self.titleLabel.text = ""
            }else{
                self.titleLabel.text = String.init(format: "%d", model!.day)
            }
            self.hiddenStatusImgs()
            //如果是用来填充数据的model则不进行检测匹配
            if model!.day == 0 {
                return
            }
            self.selectStatusJudge()
            
        }
    }
    
    //MARK:根据选择的状态进行开始和结束时间的判断
    private func selectStatusJudge(){
        
        if ETTimePickerFirst.year == 0 {//当前没有选中时间
            return
        }
        
        
        
        let startDate = DateInRegion.init(year: ETTimePickerFirst.year, month: ETTimePickerFirst.month, day: ETTimePickerFirst.day)
        let endDate = DateInRegion.init(year: ETTimePickerSecond.year, month: ETTimePickerSecond.month, day: ETTimePickerSecond.day)
        let currentDate = DateInRegion.init(year: model!.year, month: model!.month, day: model!.day)
        
        if startDate == endDate , currentDate == startDate {
            self.circleImg.isHidden = false
            self.startSelectImg.isHidden = false
            self.endSelectImg.isHidden = false
        }else if currentDate == startDate { //等于开始时间
            self.circleImg.isHidden = false
            if ETTimePickerFirst.year != 0 , ETTimePickerSecond.year != 0 {//有开始和结束时间
                self.startSelectImg.isHidden = false
            }
            
        }else if currentDate > startDate , currentDate < endDate{//大于开始时间 小于结束还是件
            self.startSelectImg.isHidden = false
            self.endSelectImg.isHidden = false
        }else if currentDate == endDate{
            self.circleImg.isHidden = false
            self.endSelectImg.isHidden = false
        }
    }
    
    
    //MARK:隐藏选择状态的背景图片
    private func hiddenStatusImgs(){
        self.circleImg.isHidden = true
        self.startSelectImg.isHidden = true
        self.endSelectImg.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubviews([startSelectImg,endSelectImg,circleImg,titleLabel])
    }
    
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel.init(frame: self.bounds)
        titleLabel.textAlignment = .center
        titleLabel.text = ""
        titleLabel.textColor = COLOR150
        return titleLabel
    }()
    
    //MARK 当前开始或者结束的选中状态
    lazy var circleImg : UIImageView = {
        let circleImgView = UIImageView.init(frame: CGRect(x: 5, y: 5, width: self.width - 10, height: self.width - 10))
        circleImgView.image = UIImage.init(named: "ETTimePickerSelectCircle")
        circleImgView.isHidden = true
        return circleImgView
    }()
    
    //MARK 结束位置的选中状态的颜色 -结束位置在前面
    lazy var endSelectImg : UIImageView = {
        let endSelectImg = UIImageView.init(frame: CGRect(x: 0, y: 5, width: self.width / 2.0, height: self.height - 10))
        endSelectImg.image = UIImage.init(named: "ETTimePickerSelectOblong")
        endSelectImg.isHidden = true
        return endSelectImg
    }()
    //MARK 开始位置的选中状态的颜色 -开始位置在后面
    lazy var startSelectImg : UIImageView = {
        let startSelectImg = UIImageView.init(frame: CGRect(x: self.width / 2.0, y: 5, width: self.width / 2.0, height: self.height - 10))
        startSelectImg.image = UIImage.init(named: "ETTimePickerSelectOblong")
        startSelectImg.isHidden = true
        return startSelectImg
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
